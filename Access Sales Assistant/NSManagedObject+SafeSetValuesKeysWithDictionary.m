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
		
		NSEntityDescription *entityDesc = [[[[self entity] relationshipsByName] objectForKey:relationship] destinationEntity];
		if (![[relationships objectForKey:relationship] isToMany]) {
			NSManagedObject *object = nil;
			Class aClass = [NSClassFromString([entityDesc name]) class];
			for (NSAttributeDescription *desc in [[aClass entityDescription] attributesByName]) {
				if ([desc.description isEqualToString:@"uid"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"uid" value:[value valueForKey:@"uid"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"addressLine1"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"addressLine1" value:[value valueForKey:@"addressLine1"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"number"]) {
					object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
				} else if ([desc.description isEqualToString:@"address"]) {
					object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
				}  else if ([desc.description isEqualToString:@"text"] && [self isKindOfClass:[Producer class]]) {
					Producer *producer = (Producer *)self;
					object = producer.questions.anyObject;
					//object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"text" value:[value valueForKey:@"text"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"header"] || [desc.description isEqualToString:@"monthYear"] || [desc.description isEqualToString:@"monthEndDate"]) {
					object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
				}
				if (([value isKindOfClass:[NSDictionary class]]) && ([(NSDictionary *)value count] == 0)) {
					continue;
				}
				if (!object) {
					//object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
				}
				if (object) {
					[object safeSetValuesForKeysWithDictionary:value dateFormatter:dateFormatter managedObjectContext:context];
					[self setValue:object forKey:relationship];
					continue;
				}
				
			}
		} else {
			NSMutableSet *relationshipSet = [self mutableSetValueForKey:relationship];
			for (id subValue in value) {
				NSManagedObject *object = nil;
				Class aClass = [NSClassFromString([entityDesc name]) class];
				for (NSAttributeDescription *desc in [[aClass entityDescription] attributesByName]) {
					if ([desc.description isEqualToString:@"uid"]) {
						object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"uid" value:[subValue valueForKey:@"uid"] managedObjectContext:context];
					} else if ([desc.description isEqualToString:@"addressLine1"]) {
						object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"addressLine1" value:[subValue valueForKey:@"addressLine1"] managedObjectContext:context];
					} else if ([desc.description isEqualToString:@"number"]) {
						object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
					} else if ([desc.description isEqualToString:@"address"]) {
						object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
					}  else if ([desc.description isEqualToString:@"text"] && [self isKindOfClass:[Producer class]]) {
						Producer *producer = (Producer *)self;
						object = producer.questions.anyObject;
						//object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"text" value:[subValue valueForKey:@"text"] managedObjectContext:context];
					} else if ([desc.description isEqualToString:@"header"] || [desc.description isEqualToString:@"monthYear"] || [desc.description isEqualToString:@"monthEndDate"] || [desc.description isEqualToString:@"fridayCloseTime"]) {
						object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
					}
				}
				if (([value isKindOfClass:[NSDictionary class]]) && ([(NSDictionary *)value count] == 0)) {
					continue;
				}
				if (!object) {
					object = [[NSClassFromString([entityDesc name]) class] createInContext:context];
				}
				if (object) {
					[object safeSetValuesForKeysWithDictionary:subValue dateFormatter:dateFormatter managedObjectContext:context];
					[relationshipSet addObject:object];
				}
			}
		}
	}
}

@end
