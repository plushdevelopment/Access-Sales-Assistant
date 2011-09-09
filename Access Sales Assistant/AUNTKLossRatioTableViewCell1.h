//
//  AUNTKLossRatioTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPNibBasedTableViewCell.h"

@interface AUNTKLossRatioTableViewCell1 : PRPNibBasedTableViewCell


@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UILabel *brandnewPoliciesPerMonthLabel;
@property (strong, nonatomic) IBOutlet UILabel *policiesWrittenITDLabel;
@property (strong, nonatomic) IBOutlet UILabel *policiesInForceLabel;
@property (strong, nonatomic) IBOutlet UILabel *wpTotalITDLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageWpITDLabel;
@property (strong, nonatomic) IBOutlet UILabel *epTotalITDLabel;
@property (strong, nonatomic) IBOutlet UILabel *lrTotalITDLabel;



@end
