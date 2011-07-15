//
//  SummarySpokeWithTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummarySpokeWithTableViewCell : PRPNibBasedTableViewCell



@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField;
@property (nonatomic, strong) IBOutlet UIButton *titleButton;

@end
