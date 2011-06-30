//
//  NSManagedObject+JSON.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+JSON.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"

@implementation NSManagedObject (NSManagedObject_JSON)

- (NSManagedObject*)managedObjectFromStructure:(NSDictionary*)structureDictionary withManagedObjectContext:(NSManagedObjectContext*)moc
{
	NSString *objectName = [structureDictionary objectForKey:@"ManagedObjectName"];
	NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:objectName inManagedObjectContext:moc];
	[managedObject setValuesForKeysWithDictionary:structureDictionary];
	
	for (NSString *relationshipName in [[[managedObject entity] relationshipsByName] allKeys]) {
		NSRelationshipDescription *description = [[[managedObject entity] relationshipsByName] objectForKey:relationshipName];
		if (![description isToMany]) {
			NSDictionary *childStructureDictionary = [structureDictionary objectForKey:relationshipName];
			NSManagedObject *childObject = [self managedObjectFromStructure:childStructureDictionary withManagedObjectContext:moc];
			[managedObject setValue:childObject forKey:relationshipName];
			continue;
		}
		NSMutableSet *relationshipSet = [managedObject mutableSetValueForKey:relationshipName];
		NSArray *relationshipArray = [structureDictionary objectForKey:relationshipName];
		for (NSDictionary *childStructureDictionary in relationshipArray) {
			NSManagedObject *childObject = [self managedObjectFromStructure:childStructureDictionary withManagedObjectContext:moc];
			[relationshipSet addObject:childObject];
		}
	}
	return managedObject;
}

- (NSArray*)managedObjectsFromJSONStructure:(NSString*)json withManagedObjectContext:(NSManagedObjectContext*)moc
{
	NSError *error = nil;
	NSArray *structureArray = [[CJSONDeserializer deserializer] deserializeAsArray:json error:&error];
	NSMutableArray *objectArray = [[NSMutableArray alloc] init];
	for (NSDictionary *structureDictionary in structureArray) {
		[objectArray addObject:[self managedObjectFromStructure:structureDictionary withManagedObjectContext:moc]];
	}
	return objectArray;
}

@end
