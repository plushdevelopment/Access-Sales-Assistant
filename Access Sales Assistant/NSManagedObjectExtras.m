//
//  NSManagedObjectExtras.m
//

#import "NSDictionary+BSJSONAdditions.h"
#import "NSArray+BSJSONAdditions.h"


@implementation NSManagedObject (NSObject)

- (NSDictionary *)propertiesAndRelationshipsDictionary
{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	
	for (id property in [[self entity] properties])
	{
		if ([property isKindOfClass:[NSAttributeDescription class]])
		{
			NSAttributeDescription *attributeDescription = (NSAttributeDescription *)property;
			NSAttributeType attributeType = [attributeDescription attributeType];
			NSString *name = [attributeDescription name];
			id value = [self valueForKey:name];
			if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSDate class]])) {
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
				value = [formatter stringFromDate:value];
			}
			[properties setValue:value forKey:name];
		}
		
		if ([property isKindOfClass:[NSRelationshipDescription class]])
		{
			NSRelationshipDescription *relationshipDescription = (NSRelationshipDescription *)property;
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
					[arr addObject:[o propertiesDictionary]];
			}
			else
			{
				NSManagedObject *o = [self valueForKey:name];
				[properties setValue:[o propertiesDictionary] forKey:name];
			}
		}
	}
	
	return properties;
}

- (NSDictionary *)propertiesDictionary
{
	NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
	NSLog(@"%@", [[self entity] properties]);
	NSLog(@"%@", [[self entity] propertiesByName]);
	for (id property in [[self entity] properties])
	{
		if ([property isKindOfClass:[NSAttributeDescription class]])
		{
			NSAttributeDescription *attributeDescription = (NSAttributeDescription *)property;
			NSString *name = [attributeDescription name];
			[properties setValue:[self valueForKey:name] forKey:name];
		}
	}
	return properties;
}

- (NSString *)jsonStringValue
{
	return [[self propertiesAndRelationshipsDictionary] jsonStringValue];
}

@end