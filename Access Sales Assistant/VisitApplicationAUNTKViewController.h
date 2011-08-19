//
//  VisitApplicationAUNTKViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCLineChartView.h"

@interface VisitApplicationAUNTKViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *productionTableView;
@property (strong, nonatomic) IBOutlet UITableView *lossRatioTableView;
@property (strong, nonatomic) IBOutlet PCLineChartView *lossRatioLineChartView;
@property (strong, nonatomic) IBOutlet PCLineChartView *claimFrequencyLineChartView;

@end
