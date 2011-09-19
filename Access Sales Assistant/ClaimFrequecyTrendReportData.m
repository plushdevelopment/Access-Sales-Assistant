#import "ClaimFrequecyTrendReportData.h"

@implementation ClaimFrequecyTrendReportData

// Custom logic goes here.
- (NSNumber*)yValue
{
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
