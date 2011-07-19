#import "DailySummary.h"
#import "PersonSpokeWith.h"
#import "Competitor.h"
#import "Note.h"

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

- (void)awakeFromInsert
{
	Note *opportunityNote = [Note createEntity];
	[opportunityNote setTypeValue:1];
	Note *summaryNote = [Note createEntity];
	[summaryNote setTypeValue:2];
	Note *committmentNote = [Note createEntity];
	[committmentNote setTypeValue:3];
	Note *followUpNote = [Note createEntity];
	[followUpNote setTypeValue:4];
	[self setNotes:[NSSet setWithObjects:opportunityNote, summaryNote, committmentNote, followUpNote, nil]];
}

@end
