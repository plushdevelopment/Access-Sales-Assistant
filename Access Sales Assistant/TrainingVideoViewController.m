//
//  TrainingVideoViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrainingVideoViewController.h"

#import "HTTPOperationController.h"
@implementation TrainingVideoViewController
@synthesize toolBar = _toolBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.baseToolbar = _toolBar;
     [[HTTPOperationController sharedHTTPOperationController]  getTrainingVideos];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
   
    //[[HTTPOperationController sharedHTTPOperationController] l];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
