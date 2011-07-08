//
//  ProducerContactTableViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerContactTableViewCell.h"

@implementation ProducerContactTableViewCell
@synthesize titleTextField=_titleTextField;
@synthesize faxTextField = _faxTextField;
@synthesize mobilePhoneTextField = _mobilePhoneTextField;
@synthesize lastNameTextField = _lastNameTextField;
@synthesize emailAddressTextField = _emailAddressTextField;
@synthesize firstNameTextField = _firstNameTextField;
@synthesize socialSecurityNumberTextField = _socialSecurityNumberTextField;
@synthesize numberOfEmployeesTextField = _numberOfEmployeesTextField;
@synthesize titleButton = _titleButton;
@synthesize numberOfEmployeesButton = _numberOfEmployeesButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
