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
@synthesize isVisitApp;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
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
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.view setNeedsDisplay];
}

@end
