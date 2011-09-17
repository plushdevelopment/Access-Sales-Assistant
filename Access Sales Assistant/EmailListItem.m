#import "EmailListItem.h"

@implementation EmailListItem

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter managedObjectContext:(NSManagedObjectContext *)context
{
	if ([keyedValues valueForKey:@"address"]) {
		[super safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter managedObjectContext:context];
	} else {
		[self deleteInContext:context];
	}
}

@end
