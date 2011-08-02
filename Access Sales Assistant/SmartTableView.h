//
//  SmartTableView.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmartTableView : UITableView

- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;

@end
