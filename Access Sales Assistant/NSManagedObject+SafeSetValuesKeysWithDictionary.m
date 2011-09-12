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
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"number" value:[value valueForKey:@"number"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"address"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"address" value:[value valueForKey:@"address"] managedObjectContext:context];
				}  else if ([desc.description isEqualToString:@"text"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"text" value:[value valueForKey:@"text"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"header"] || [desc.description isEqualToString:@"monthYear"] || [desc.description isEqualToString:@"monthEndDate"]) {
					object = [[NSClassFromString([entityDesc name]) class] createEntity];
				}
			}
			/*
			if (!object) {
				object = [aClass createInContext:context];
			}
			 */
			if (value == nil) {
				continue;
			}
			if (([value isKindOfClass:[NSDictionary class]]) && ([(NSDictionary *)value count] == 0)) {
				continue;
			}
			if (object) {
				[object safeSetValuesForKeysWithDictionary:value dateFormatter:dateFormatter managedObjectContext:context];
				[self setValue:object forKey:relationship];
			}
			continue;
		}
		
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
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"number" value:[subValue valueForKey:@"number"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"address"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"address" value:[subValue valueForKey:@"address"] managedObjectContext:context];
				}  else if ([desc.description isEqualToString:@"text"]) {
					object = [[NSClassFromString([entityDesc name]) class] ai_objectForProperty:@"text" value:[subValue valueForKey:@"text"] managedObjectContext:context];
				} else if ([desc.description isEqualToString:@"header"] || [desc.description isEqualToString:@"monthYear"] || [desc.description isEqualToString:@"monthEndDate"]) {
					object = [[NSClassFromString([entityDesc name]) class] createEntity];
				}
			}
			/*
			if (!object) {
				object = [aClass createInContext:context];
			}
			*/
			if (value == nil) {
				continue;
			}
			if (([value isKindOfClass:[NSDictionary class]]) && ([(NSDictionary *)value count] == 0)) {
				continue;
			}
			
			if (object) {
				[object safeSetValuesForKeysWithDictionary:subValue dateFormatter:dateFormatter managedObjectContext:context];
				[relationshipSet addObject:object];
			}
		}
		/*
		NSManagedObjectModel *model = [NSManagedObjectModel newManagedObjectModelNamed:@"Access_Sales_Assistant.momd"];
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
		 */
	}
}

- (NSDictionary*)dataStructureFromManagedObject:(NSManagedObject*)managedObject
{
	NSDictionary *attributesByName = [[managedObject entity] attributesByName];
	NSDictionary *relationshipsByName = [[managedObject entity] relationshipsByName];
	NSMutableDictionary *valuesDictionary = [[managedObject dictionaryWithValuesForKeys:[attributesByName allKeys]] mutableCopy];
	[valuesDictionary setObject:[[managedObject entity] name] forKey:@"ManagedObjectName"];
	for (NSString *relationshipName in [relationshipsByName allKeys]) {
		NSRelationshipDescription *description = [[[managedObject entity] relationshipsByName] objectForKey:relationshipName];
		if (![description isToMany]) {
			//[valuesDictionary setValue:[managedObject dataStructureFromManagedObject:[self valueForKey:relationshipName] forKey:relationshipName]];
			continue;
		}
		NSSet *relationshipObjects = [[[managedObject entity] relationshipsByName] objectForKey:relationshipName];
		NSMutableArray *relationshipArray = [[NSMutableArray alloc] init];
		for (NSManagedObject *relationshipObject in relationshipObjects) {
			[relationshipArray addObject:[self dataStructureFromManagedObject:relationshipObject]];
		}
		[valuesDictionary setObject:relationshipArray forKey:relationshipName];
	}
	return valuesDictionary;
}

- (NSArray*)dataStructuresFromManagedObjects:(NSArray*)managedObjects
{
	NSMutableArray *dataArray = [[NSMutableArray alloc] init];
	for (NSManagedObject *managedObject in managedObjects) {
		[dataArray addObject:[self dataStructureFromManagedObject:managedObject]];
	}
	return dataArray;
}

- (NSString*)jsonStructureFromManagedObjects:(NSArray*)managedObjects
{
	NSArray *objectsArray = [self dataStructuresFromManagedObjects:managedObjects];
	NSString *jsonString = [objectsArray JSONString];
	return jsonString;
}

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
	NSArray *structureArray = [json objectFromJSONString];
	NSAssert2(error == nil, @"Failed to deserialize\n%@\n%@", [error localizedDescription], json);
	NSMutableArray *objectArray = [[NSMutableArray alloc] init];
	for (NSDictionary *structureDictionary in structureArray) {
		[objectArray addObject:[self managedObjectFromStructure:structureDictionary withManagedObjectContext:moc]];
	}
	return objectArray;
}

@end
