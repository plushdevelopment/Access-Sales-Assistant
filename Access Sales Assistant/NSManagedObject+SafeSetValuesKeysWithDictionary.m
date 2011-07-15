//
//  NSManagedObject+SafeSetValuesKeysWithDictionary.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSManagedObject+SafeSetValuesKeysWithDictionary.h"
#import "AddressListItem.h"
#import "Contact.h"

@implementation NSManagedObject (NSManagedObject_SafeSetValuesKeysWithDictionary)

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for (NSString *attribute in attributes) {
        id value = [keyedValues objectForKey:attribute];
        if (value == nil) {
            // Don't attempt to set nil, or you'll overwite values in self that aren't present in keyedValues
            continue;
        }
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value  integerValue]];
        } else if ((attributeType == NSFloatAttributeType) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        }
        [self setValue:value forKey:attribute];
    }
}

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for (NSString *attribute in attributes) {
        id value = [keyedValues objectForKey:attribute];
        if (value == nil) {
            continue;
        }
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
            value = [dateFormatter dateFromString:value];
        }
        [self setValue:value forKey:attribute];
    }
	
	NSDictionary *relationships = [[self entity] relationshipsByName];
	for (NSString *relationship in [relationships allKeys]) {
		id value = [keyedValues objectForKey:relationship];
		if (value == nil) {
			continue;
		}
		
		NSManagedObjectModel *model = [NSManagedObjectModel managedObjectModelNamed:@"Access_Sales_Assistant.momd"];
		NSArray *entities = [model entities];
		
		for (NSEntityDescription *entityDescription in entities) {
			if ([[[[relationships objectForKey:relationship] destinationEntity] name] isEqualToString:[entityDescription name]]) {
				
				if (![[relationships objectForKey:relationship] isToMany]) {
					NSManagedObject *object = [[NSClassFromString([entityDescription name]) class] findFirstByAttribute:@"uid" withValue:[value valueForKey:@"uid"]];
					
					[object safeSetValuesForKeysWithDictionary:value dateFormatter:nil];
					[self setValue:object forKey:relationship];
					continue;
				}
				
				NSMutableSet *relationshipSet = [self mutableSetValueForKey:relationship];
				for (id subValue in value) {
					NSManagedObject *object;
					Class aClass = [NSClassFromString([entityDescription name]) class];
					if ([[[aClass entityDescription] attributesByName] respondsToSelector:@selector(uid)]) {
						object = [[NSClassFromString([entityDescription name]) class] findFirstByAttribute:@"uid" withValue:[subValue valueForKey:@"uid"]];
					} else {
						object = [aClass createEntity];
					}
					
					[object safeSetValuesForKeysWithDictionary:subValue dateFormatter:nil];
					[relationshipSet addObject:object];
				}
			}
		}
	}
}

@end
