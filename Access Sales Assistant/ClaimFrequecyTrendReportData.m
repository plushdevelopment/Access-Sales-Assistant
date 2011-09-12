#import "ClaimFrequecyTrendReportData.h"

@implementation ClaimFrequecyTrendReportData

// Custom logic goes here.
- (NSNumber*)yValue
{
	NSLog(@"yValue: %@", self.claimsFrequency.stringValue);
	return self.claimsFrequency;
}

- (NSString*)xLabel
{
	return self.monthYear;
}

- (NSString*)yLabel
{
	return self.claimsFrequency.stringValue;
}

@end
