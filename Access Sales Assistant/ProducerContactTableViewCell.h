//
//  ProducerContactTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProducerContactTableViewCell : UITableViewCell


@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UITextField *faxTextField;
@property (nonatomic, strong) IBOutlet UITextField *mobilePhoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *socialSecurityNumberTextField;
@property (nonatomic, strong) IBOutlet UITextField *numberOfEmployeesTextField;
@property (nonatomic, strong) IBOutlet UIButton *titleButton;
@property (nonatomic, strong) IBOutlet UIButton *numberOfEmployeesButton;

@end
