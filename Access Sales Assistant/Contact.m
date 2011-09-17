#import "Contact.h"

@implementation Contact

- (NSString *)producerId
{
	return self.producer.uid;
}

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter managedObjectContext:(NSManagedObjectContext *)context
{
	[super safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter managedObjectContext:context];
	self.type = [ContactType findFirstByAttribute:@"uid" withValue:[keyedValues valueForKeyPath:@"type.uid"] inContext:context];
}

- (PhoneListItem *)mobilePhoneInManagedObjectContext:(NSManagedObjectContext *)context
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = 5"];
	PhoneListItem *phone = [[self.phoneNumbers.allObjects filteredArrayUsingPredicate:predicate] lastObject];
	if (!phone) {
		phone = [PhoneListItem createInContext:context];
		phone.typeValue = 5;
	}
	return phone;
}

@end
