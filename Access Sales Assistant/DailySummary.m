#import "DailySummary.h"
#import "PersonSpokeWith.h"
#import "Competitor.h"

@implementation DailySummary

- (void)awakeFromFetch
{
	if ([self.personsSpokeWith count] == 0) {
		PersonSpokeWith *person = [PersonSpokeWith createEntity];
		[self addPersonsSpokeWithObject:person];
	}
	
	if ([self.competitors count] == 0) {
		Competitor *competitor = [Competitor createEntity];
		[self addCompetitorsObject:competitor];
	}
}

@end
