//
//  NSManagedObjectExtras.m
//

#import "NSDictionary+BSJSONAdditions.h"
#import "NSArray+BSJSONAdditions.h"


@implementation NSManagedObject (NSObject)

- (NSDictionary *)propertiesAndRelationshipsDictionaryFromEntity:(NSEntityDescription *)entity
{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	
	for (id property in [[self entity] properties])
	{
		NSString *name;
		id value;
		if ([property isKindOfClass:[NSAttributeDescription class]])
		{
			NSAttributeDescription *attributeDescription = (NSAttributeDescription *)property;
			NSAttributeType attributeType = [attributeDescription attributeType];
			name = [attributeDescription name];
			value = [self valueForKey:name];
			if (attributeType == NSDateAttributeType) {
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
				value = [formatter stringFromDate:value];
			}
		}
		if (value && name) {
			[properties setValue:value forKey:name];
		}
		if ([property isKindOfClass:[NSRelationshipDescription class]])
		{
			NSRelationshipDescription *relationshipDescription = (NSRelationshipDescription *)property;
			if (![[relationshipDescription destinationEntity] isKindOfEntity:entity]) {
				NSString *name = [relationshipDescription name];
				
				if ([relationshipDescription isToMany])
				{
					NSMutableArray *arr = [properties valueForKey:name];
					if (!arr)
					{
						arr = [[NSMutableArray alloc] init];
						[properties setValue:arr forKey:name];
					}
					
					for (NSManagedObject *o in [self mutableSetValueForKey:name])
						[arr addObject:[o propertiesAndRelationshipsDictionaryFromEntity:[self entity]]];
				}
				else
				{
					NSManagedObject *o = [self valueForKey:name];
					[properties setValue:[o propertiesAndRelationshipsDictionaryFromEntity:[self entity]] forKey:name];
				}
			} else {
				
			}
		}
	}
	
	return properties;
}

- (NSDictionary *)propertiesDictionary
{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	for (id property in [[self entity] properties])
	{
		NSString *name;
		id value;
		if ([property isKindOfClass:[NSAttributeDescription class]])
		{
			NSAttributeDescription *attributeDescription = (NSAttributeDescription *)property;
			NSAttributeType attributeType = [attributeDescription attributeType];
			name = [attributeDescription name];
			value = [self valueForKey:name];
			if (attributeType == NSDateAttributeType) {
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
				value = [formatter stringFromDate:value];
			}
		}
		if (value && name) {
			[properties setValue:value forKey:name];
		}
	}
	return properties;
}

- (NSString *)jsonStringValue
{
	return [[self propertiesAndRelationshipsDictionaryFromEntity:nil] jsonStringValue];
}

@end