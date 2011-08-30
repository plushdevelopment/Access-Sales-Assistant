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

@property (nonatomic, strong) IBOutlet UITextField *domainField;
@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *organizationField;
@property (nonatomic, strong) IBOutlet UITextField *serviceKeyField;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)submitLogin:(id)sender;
- (void)loginFinished:(ASIHTTPRequest *)request;
- (void)showError:(NSString *)message;
-(NSString *) urlencode: (NSString *) url;

@end
