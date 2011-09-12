#import "_ClaimFrequecyTrendReportData.h"
#import "TKGraphView.h"

@interface ClaimFrequecyTrendReportData : _ClaimFrequecyTrendReportData <TKGraphViewPoint> {}
// Custom logic goes here.

- (NSNumber*)yValue;
- (NSString*)xLabel;
- (NSString*)yLabel;
@end
