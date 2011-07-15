//
//  SummaryStatsTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummaryStatsTableViewCell : PRPNibBasedTableViewCell


@property (nonatomic, strong) IBOutlet UITextField *totalAppsPerMonthTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentLiabTextField;
@property (nonatomic, strong) IBOutlet UITextField *producerAddOnTextField;
@property (nonatomic, strong) IBOutlet UITextField *rdFollowUpTextField;
@property (nonatomic, strong) IBOutlet UITextField *monthlyGoalTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentFDLTextField;
@property (nonatomic, strong) IBOutlet UIButton *rdFollowUpButton;
@property (nonatomic, strong) IBOutlet UIButton *producerAddOnButton;

@end
