//
//  AddRowTableViewCell.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddRowTableViewCell.h"

@implementation AddRowTableViewCell

@synthesize addRowType = _addRowType;
@synthesize delRowType = _delRowType;
@synthesize addButton = _addButton;
@synthesize editButton = _editButton;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
