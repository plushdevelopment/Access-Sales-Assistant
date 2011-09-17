#import "Producer.h"

@implementation Producer

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter managedObjectContext:(NSManagedObjectContext *)context
{
	[super safeSetValuesForKeysWithDictionary:keyedValues dateFormatter:dateFormatter managedObjectContext:context];
	QuestionListItem *question = self.questions.anyObject;
	NSDictionary *dict = [[keyedValues valueForKeyPath:@"questions"] lastObject];
	[question safeSetValuesForKeysWithDictionary:dict dateFormatter:nil managedObjectContext:context];
}

@end
