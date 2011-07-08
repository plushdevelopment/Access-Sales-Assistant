//
//  ProducerAddressTableViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerAddressTableViewCell.h"

@implementation ProducerAddressTableViewCell
@synthesize streetAddress1TextField=_streetAddress1TextField;
@synthesize streetAddress2TextField=_streetAddress2TextField;
@synthesize cityTextField=_cityTextField;
@synthesize stateTextField=_stateTextField;
@synthesize zipTextField=_zipTextField;
@synthesize stateButton=_stateButton;

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
