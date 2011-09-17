//
//  SummaryGeneralTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummaryGeneralTableViewCell : PRPNibBasedTableViewCell

@property (nonatomic, strong) IBOutlet UITextField *producerNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *reportDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *callTypeTextField;
@property (nonatomic, strong) IBOutlet UIButton *reportDateButton;
@property (nonatomic, strong) IBOutlet UIButton *reasonNotSeen;
@property (nonatomic, strong) IBOutlet UITextField *reasonNotSeenTextField;

@property (nonatomic, strong) IBOutlet UITextField *commissionStructureTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentNewTextField;
@property (nonatomic, strong) IBOutlet UITextField *percentRenewalTextField;
@property (nonatomic, strong) IBOutlet UIButton *commissionStructureButton;

@end
