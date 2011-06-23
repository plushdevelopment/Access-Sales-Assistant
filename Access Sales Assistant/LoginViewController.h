//
//  LoginViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "ASIHTTPRequestDelegate.h"

@interface LoginViewController : UIViewController <ASIHTTPRequestDelegate>

@property (nonatomic, retain) IBOutlet UITextField *domainField;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UITextField *organizationField;
@property (nonatomic, retain) IBOutlet UITextField *serviceKeyField;

@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)submitLogin:(id)sender;
- (void)showError:(NSString *)message;

@end
