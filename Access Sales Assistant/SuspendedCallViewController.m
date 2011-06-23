//
//  SuspendedCallViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuspendedCallViewController.h"


@implementation SuspendedCallViewController

- (IBAction)changeTab:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	// Tab selection
	insufficientFundsTab.selected = NO;
	errorsTab.selected = NO;
	button.selected = YES;
	
	// Hide all of the views
	[insufficientFundsView removeFromSuperview];
	[errorsView removeFromSuperview];
	
	switch (button.tag) {
		case 0:
			// Insufficient Funds
			[contentScrollView addSubview:insufficientFundsView];
			break;
		case 1:
			// Errors & Omissions
			[contentScrollView addSubview:errorsView];
			break;
		default:
			return;
	}
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
	[contentScrollView release];
	
	[insufficientFundsTab release];
	[errorsTab release];
	
	[insufficientFundsView release];
	[errorsView release];
	
	[insufficientFundsContent release];
	[errorsContent release];
	
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
	[super viewDidLoad];
	
	// load all content
	[insufficientFundsContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SuspendedInsufficientFundsContent" ofType:@"html"]isDirectory:NO]]];
	[errorsContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SuspendedErrorsContent" ofType:@"html"]isDirectory:NO]]];
	
	// Default tab selection and view load
	insufficientFundsTab.selected = YES;
	[contentScrollView addSubview:insufficientFundsView];
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
