//
//  Access_Sales_AssistantAppDelegate.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@class ASIHTTPRequest;

@interface Access_Sales_AssistantAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UISplitViewController *splitViewController;
@property (nonatomic,strong) LoginViewController* loginController;

- (void)loginFailed:(ASIHTTPRequest *)request;
- (void)showError:(id)notification;

void uncaughtExceptionHandler(NSException *exception);

@end
