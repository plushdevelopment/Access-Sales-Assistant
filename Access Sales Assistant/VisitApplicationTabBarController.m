//
//  VisitApplicationTabBarController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationTabBarController.h"

#import "VisitApplicationSummaryTableViewController.h"

#import "VisitApplicationNotesViewController.h"

@implementation VisitApplicationTabBarController

@synthesize detailItem=_detailItem;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        //[self.pc dismissPopoverAnimated:YES];
    }
	
}

- (void)configureView
{
    // Update the user interface for the detail item.
	
	if (self.detailItem) {
		for (id<DetailViewController> viewController in self.viewControllers) {
			[viewController setDetailItem:self.detailItem];
		}
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
    // Do any additional setup after loading the view from its nib.
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
	return YES;
}

@end
