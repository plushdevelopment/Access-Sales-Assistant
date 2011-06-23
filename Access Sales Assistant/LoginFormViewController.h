//
//  LoginFormViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginFormViewController : UIViewController  {
    IBOutlet UITextField *usernameField, *passwordField;
}

- (IBAction)submitLoginInfo:(id)sender;

@end
