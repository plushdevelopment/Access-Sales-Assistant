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

- (NSDictionary*)dataStructureFromManagedObject:(NSManagedObject*)managedObject
{
	NSDictionary *attributesByName = [[managedObject entity] attributesByName];
	NSDictionary *relationshipsByName = [[managedObject entity] relationshipsByName];
	NSMutableDictionary *valuesDictionary = [[managedObject dictionaryWithValuesForKeys:[attributesByName allKeys]] mutableCopy];
	[valuesDictionary setObject:[[managedObject entity] name] forKey:@"ManagedObjectName"];
	for (NSString *relationshipName in [relationshipsByName allKeys]) {
		NSRelationshipDescription *description = [[[managedObject entity] relationshipsByName] objectForKey:relationshipName];
		if (![description isToMany]) {
			[valuesDictionary setValue:[self dataStructureForManagedObject:]];
			continue;
		}
		NSSet *relationshipObjects = [managedObject objectForKey:relationshipName];
		NSMutableArray *relationshipArray = [[NSMutableArray alloc] init];
		for (NSManagedObject *relationshipObject in relationshipObjects) {
			[relationshipArray addObject:[self dataStructureForManagedObject:relationshipObject]];
		}
		[valuesDictionary setObject:relationshipArray forKey:relationshipName];
	}
	return [valuesDictionary autorelease];
}

- (NSArray*)dataStructuresFromManagedObjects:(NSArray*)managedObjects
{
	NSMutableArray *dataArray = [[NSArray alloc] init];
	for (NSManagedObject *managedObject in managedObjects) {
		[dataArray addObject:[self dataStructureForManagedObject:managedObject]];
	}
	return [dataArray autorelease];
}

- (NSString*)jsonStructureFromManagedObjects:(NSArray*)managedObjects
{
	NSArray *objectsArray = [self dataStructuresFromManagedObjects:managedObjects];
	NSString *jsonString = [[CJSONSerializer serializer] serializeArray:objectsArray];
	return jsonString;
}

- (NSManagedObject*)managedObjectFromStructure:(NSDictionary*)structureDictionary withManagedObjectContext:(NSManagedObjectContext*)moc
{
	NSString *objectName = [structureDictionary objectForKey:@"ManagedObjectName"];
	NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:objectName inManagedObjectContext:moc];
	[managedObject setValuesForKeysWithDictionary:structureDictionary];
	
	for (NSString *relationshipName in [[[managedObject entity] relationshipsByName] allKeys]) {
		NSRelationshipDescription *description = [relationshipsByName objectForKey:relationshipName];
		if (![description isToMany]) {
			NSDictionary *childStructureDictionary = [structureDictionary objectForKey:relationshipName];
			NSManagedObject *childObject = [self managedObjectFromStructure:childStructureDictionary withManagedObjectContext:moc];
			[managedObject setObject:childObject forKey:relationshipName];
			continue;
		}
		NSMutableSet *relationshipSet = [managedObject mutableSetForKey:relationshipName];
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
	NSAssert2(error == nil, @"Failed to deserialize\n%@\n%@", [error localizedDescription], json);
	NSMutableArray *objectArray = [[NSMutableArray alloc] init];
	for (NSDictionary *structureDictionary in structureArray) {
		[objectArray addObject:[self managedObjectFromStructure:structureDictionary withManagedObjectContext:moc]];
	}
	return [objectArray autorelease];
}

@end
