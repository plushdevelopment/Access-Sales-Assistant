//
//  DataManagementController.m
//  Sales Templates
//
//	This is the management controller for all stored data from the api. It also manages the display of the
//	User login form when the login data isn't present or is incorrect.
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataManagementController.h"
#import "LoginFormViewController.h"

@implementation DataManagementController

// Singleton Management
static DataManagementController* _sharedSingleton = nil;
+(DataManagementController*)sharedSingleton {
	@synchronized([DataManagementController class]) {
		if(!_sharedSingleton) {
			[[self alloc] init];
		}
		
		return _sharedSingleton;
	}
	
	return nil;
}

+(id)alloc {
	@synchronized([DataManagementController class]) {
		NSAssert(_sharedSingleton ==nil, @"Attempted to allocate a second DataManagementController");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
	
	return nil;
}

- (id)init {
	self = [super init];
	if(self != nil) {
		// initialize here
	}
	
	return self;
}

- (void)checkLoginCredentials:(UIViewController *)view {
	// Set some application defaults
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// If no username, ask for it
    if([defaults stringForKey:@"Username"]==nil) {
		[defaults setValue:@"access" forKey:@"Organization"];
		[defaults setValue:@"access" forKey:@"Domain"];
		[self displayLoginFormModalOnView:view];
    }
	
	[APICall checkTime];
}

// Disitems the modal login form on the specified view without the default delay
- (void)displayLoginFormModalOnView: (UIViewController *) view {
	
	LoginFormViewController *modalView = [[LoginFormViewController alloc] initWithNibName:@"LoginForm" bundle:nil];
	modalView.modalPresentationStyle = UIModalPresentationFormSheet;
	[view presentModalViewController:modalView animated:YES];
	modalView.view.superview.frame = CGRectMake(262, 221, 500, 325);
	
	
	[modalView release];
}

@end
