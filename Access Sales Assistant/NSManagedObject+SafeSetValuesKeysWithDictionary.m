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

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter managedObjectContext:(NSManagedObjectContext *)context
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
		if (value == nil) {
			continue;
		}
		if (([value isKindOfClass:[NSDictionary class]]) && ([(NSDictionary *)value count] == 0)) {
			continue;
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
					NSManagedObject *object;
					Class aClass = [NSClassFromString([entityDescription name]) class];
					for (NSAttributeDescription *desc in [[aClass entityDescription] attributesByName]) {
						if ([desc.description isEqualToString:@"uid"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"uid" value:[value valueForKey:@"uid"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"addressLine1"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"addressLine1" value:[value valueForKey:@"addressLine1"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"number"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"number" value:[value valueForKey:@"number"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"address"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"address" value:[value valueForKey:@"address"] managedObjectContext:context];
						}  else if ([desc.description isEqualToString:@"text"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"text" value:[value valueForKey:@"text"] managedObjectContext:context];
						}
					}
					if (!object) {
						object = [aClass createInContext:context];
					}
					[object safeSetValuesForKeysWithDictionary:value dateFormatter:dateFormatter managedObjectContext:context];
					[self setValue:object forKey:relationship];
					continue;
				}
				
				NSMutableSet *relationshipSet = [self mutableSetValueForKey:relationship];
				for (id subValue in value) {
					NSManagedObject *object;
					Class aClass = [NSClassFromString([entityDescription name]) class];
					for (NSAttributeDescription *desc in [[aClass entityDescription] attributesByName]) {
						if ([desc.description isEqualToString:@"uid"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"uid" value:[subValue valueForKey:@"uid"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"addressLine1"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"addressLine1" value:[subValue valueForKey:@"addressLine1"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"number"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"number" value:[subValue valueForKey:@"number"] managedObjectContext:context];
						} else if ([desc.description isEqualToString:@"address"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"address" value:[subValue valueForKey:@"address"] managedObjectContext:context];
						}  else if ([desc.description isEqualToString:@"text"]) {
							object = [[NSClassFromString([entityDescription name]) class] ai_objectForProperty:@"text" value:[subValue valueForKey:@"text"] managedObjectContext:context];
						}
					}
					if (!object) {
						object = [aClass createInContext:context];
					}
					
					[object safeSetValuesForKeysWithDictionary:subValue dateFormatter:dateFormatter managedObjectContext:context];
					[relationshipSet addObject:object];
				}
			}
		}
	}
}

@end
