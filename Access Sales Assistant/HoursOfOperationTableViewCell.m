//
//  HoursOfOperationTableViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HoursOfOperationTableViewCell.h"

@implementation HoursOfOperationTableViewCell
@synthesize aButton;
@synthesize imageView;

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
