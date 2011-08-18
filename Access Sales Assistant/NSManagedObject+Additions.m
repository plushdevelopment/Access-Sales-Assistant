//
//  NSManagedObject+Additions.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+Additions.h"
#import "CoreData+ActiveRecordFetching.h"

@implementation NSManagedObject (NSManagedObject_Additions)

+ (id)ai_objectForProperty:(NSString *)propertyName value:(id)propertyValue managedObjectContext:(NSManagedObjectContext *)context
{
	NSManagedObject *object;
	if (propertyValue) {
		object = [self findFirstByAttribute:propertyName withValue:propertyValue inContext:context];
		if (!object) {
			object = [self createInContext:context];
			NSDictionary *attributes = [[object entity] attributesByName];
			NSAttributeType attributeType = [[attributes objectForKey:propertyName] attributeType];
			if ((attributeType == NSStringAttributeType) && ([propertyValue isKindOfClass:[NSNumber class]])) {
				propertyValue = [propertyValue stringValue];
			} else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([propertyValue isKindOfClass:[NSString class]])) {
				propertyValue = [NSNumber numberWithInteger:[propertyValue integerValue]];
			} else if ((attributeType == NSFloatAttributeType) &&  ([propertyValue isKindOfClass:[NSString class]])) {
				propertyValue = [NSNumber numberWithDouble:[propertyValue doubleValue]];
			}
			
			[object setValue:propertyValue forKey:propertyName];
		}
	}
	return object;
}

@end
