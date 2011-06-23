//
//  ProducerCallViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerCallViewController.h"


@implementation ProducerCallViewController

- (IBAction)changeTab:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	// Tab selection
	overviewTab.selected = NO;
	salesPitchTab.selected = NO;
	closeTab.selected = NO;
	button.selected = YES;
	
	// Hide all of the views
	[overviewView removeFromSuperview];
	[salesPitchView removeFromSuperview];
	[closeView removeFromSuperview];
	
	switch (button.tag) {
		case 0:
			// Overview
			[contentScrollView addSubview:overviewView];
			break;
		case 1:
			// Sales Pitch
			[contentScrollView addSubview:salesPitchView];
			break;
		case 2:
			// Close
			[contentScrollView addSubview:closeView];
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
	
	[overviewTab release];
	[salesPitchTab release];
	[closeTab release];
	
	[overviewView release];
	[salesPitchView release];
	[closeView release];
	
	[overviewContent release];
	[salesPitchContent release];
	[closeContent release];
	
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
	
	[overviewContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProducerOverviewContent" ofType:@"html"]isDirectory:NO]]];
	[salesPitchContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProducerSalesPitchContent" ofType:@"html"]isDirectory:NO]]];
	[closeContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProducerCloseContent" ofType:@"html"]isDirectory:NO]]];
	
	// Default tab selection and view load
	overviewTab.selected = YES;
	[contentScrollView addSubview:overviewView];
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
