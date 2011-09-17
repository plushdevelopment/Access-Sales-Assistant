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

@end
