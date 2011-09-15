#import "Producer.h"

@implementation Producer

- (void)awakeFromInsert
{
	QuestionListItem *question = [QuestionListItem createEntity];
	[self addQuestionsObject:question];
}

@end
