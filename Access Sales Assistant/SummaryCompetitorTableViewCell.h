//
//  SummaryCompetitorTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummaryCompetitorTableViewCell : PRPNibBasedTableViewCell


@property (nonatomic, strong) IBOutlet UITextField *competitorNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *appsPerMonthTextField;
@property (nonatomic, strong) IBOutlet UITextField *commissionStructureTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentNewTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentRenewalTextField;
@property (nonatomic, strong) IBOutlet UIButton *competitorNameButton;
@property (nonatomic, strong) IBOutlet UIButton *commissionStructureButton;

@end
