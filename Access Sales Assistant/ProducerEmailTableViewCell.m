//
//  ProducerEmailTableViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerEmailTableViewCell.h"

@implementation ProducerEmailTableViewCell
@synthesize emailAddressTextField=_emailAddressTextField;
@synthesize typeTextField = _typeTextField;
@synthesize typeButton = _typeButton;

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
