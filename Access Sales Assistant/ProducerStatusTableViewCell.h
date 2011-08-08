//
//  ProducerStatusTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRPNibBasedTableViewCell.h"
@interface ProducerStatusTableViewCell : PRPNibBasedTableViewCell


@property (nonatomic, strong) IBOutlet UITextField *appointedDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *statusTextField;
@property (nonatomic, strong) IBOutlet UITextField *statusDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *reasonIneligibleTextField;
@property (nonatomic, strong) IBOutlet UITextField *suspensionReasonTextField;
@property (nonatomic, strong) IBOutlet UITextField *eligibleTextField;
@property (nonatomic, strong) IBOutlet UIButton *statusButton;
@property (nonatomic, strong) IBOutlet UIButton *suspensionReasonButton;
@property (nonatomic, strong) IBOutlet UIButton *eligibleButton;
@property (nonatomic, strong) IBOutlet UIButton *reasonIneligibleButton;
@property (nonatomic, strong) IBOutlet UIButton *statusDateButton;
@property (nonatomic, strong) IBOutlet UIButton *appointedDateButton;



@end
