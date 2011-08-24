//
//  VisitTableViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitTableViewCell.h"

@implementation VisitTableViewCell
@synthesize iconImageView=_iconImageView;
@synthesize visitNumberLabel = _visitNumberLabel;
@synthesize producerNameLabel = _producerNameLabel;
@synthesize iconButton = _iconButton;

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
