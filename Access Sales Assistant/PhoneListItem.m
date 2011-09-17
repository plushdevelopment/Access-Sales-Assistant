#import "PhoneListItem.h"

@implementation PhoneListItem

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter managedObjectContext:(NSManagedObjectContext *)context
{
	if ([keyedValues valueForKey:@"number"]) {
		[super safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter managedObjectContext:context];
	} else {
		[self deleteInContext:context];
	}
}
   

@end
