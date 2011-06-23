//
//  ProspectCallViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProspectCallViewController.h"


@implementation ProspectCallViewController

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
	callSurveyTab.selected = NO;
	closeTab.selected = NO;
	button.selected = YES;
	
	// Hide all of the views
	[overviewView removeFromSuperview];
	[salesPitchView removeFromSuperview];
	[callSurveyView removeFromSuperview];
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
			// Call Survey
			[contentScrollView addSubview:callSurveyView];
			break;
		case 3:
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
	
	[overviewView release];
	[salesPitchView release];
	[callSurveyView release];
	[closeView release];
	
	[overviewTab release];
	[salesPitchTab release];
	[callSurveyTab release];
	[closeTab release];
	
	[overviewContent release];
	[salesPitchContent release];
	[callSurveyContent release];
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
	
	// load all content
	[overviewContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProspectOverviewContent" ofType:@"html"]isDirectory:NO]]];
	[salesPitchContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProspectSalesPitchContent" ofType:@"html"]isDirectory:NO]]];
	[callSurveyContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProspectCallSurveyContent" ofType:@"html"]isDirectory:NO]]];
	[closeContent loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ProspectCloseContent" ofType:@"html"]isDirectory:NO]]];
	
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
