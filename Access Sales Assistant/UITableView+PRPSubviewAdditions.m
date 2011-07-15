//
//  UITableView+PRPSubviewAdditions.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableView+PRPSubviewAdditions.h"

@implementation UITableView (UITableView_PRPSubviewAdditions)

- (NSIndexPath *)prp_indexPathForRowContainingView:(UIView *)view
{
    CGPoint correctedPoint = [view convertPoint:view.bounds.origin
										 toView:self];
    return [self indexPathForRowAtPoint:correctedPoint];	
}

@end
