//
//  LoginFormViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginFormViewController.h"


@implementation LoginFormViewController

- (IBAction)submitLoginInfo:(id)sender {
	
	if ([usernameField.text isEqualToString:@""] && [passwordField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information Required" message:@"Please provide your Active Directory login credentials to continue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[alert release];
		return;
	} else if ([usernameField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information Required" message:@"Please provide your Active Directory Username to continue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[alert release];
		return;
	} else if ([passwordField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information Required" message:@"Please provide your Active Directory Password to continue." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[alert release];
		return;
	}
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setValue:usernameField.text forKey:@"Username"];
	[defaults setValue:passwordField.text forKey:@"Password"];
	
	[self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
	[usernameField release];
	[passwordField release];
	
	[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults valueForKey:@"Username"] != nil) {
		usernameField.text = [defaults valueForKey:@"Username"];
	}
	if ([defaults valueForKey:@"Password"] != nil) {
		passwordField.text = [defaults valueForKey:@"Password"];
	}
	
	[super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		return YES;
	}
	return NO;
}

@end
