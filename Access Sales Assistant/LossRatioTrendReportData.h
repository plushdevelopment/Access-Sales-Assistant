#import "_LossRatioTrendReportData.h"
#import "TKGraphView.h"

@interface LossRatioTrendReportData : _LossRatioTrendReportData <TKGraphViewPoint> {}
// Custom logic goes here.

- (NSNumber*)yValue;
- (NSString*)xLabel;
- (NSString*)yLabel;
@end
