//
//  UITableView+PRPSubviewAdditions.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (UITableView_PRPSubviewAdditions)

- (NSIndexPath *)prp_indexPathForRowContainingView:(UIView *)view;

@end
