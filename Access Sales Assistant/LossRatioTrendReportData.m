#import "LossRatioTrendReportData.h"

@implementation LossRatioTrendReportData

// Custom logic goes here.
- (NSNumber*)yValue
{
	return self.lossRatio;
}

- (NSString*)xLabel
{
	return self.monthYear;
}

- (NSString*)yLabel
{
	return self.lossRatio.stringValue;
}

@end
