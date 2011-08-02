//
//  DetailViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseDetailViewController.h"

#import "RootViewController.h"

@implementation BaseDetailViewController

@synthesize baseNavigationBar;

@synthesize baseToolbar;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if(orientation == 0)
        orientation = self.interfaceOrientation;
    
    if(UIDeviceOrientationIsPortrait(orientation))
    {
		//if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
		[self showRootPopoverButtonItem:[self.toolbarItems lastObject]];
		//}
    }
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Add the popover button to the left navigation item.
    //[baseNavigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
    
    /*NSMutableArray *items = [[self.baseToolbar items] mutableCopy];
    if([items count])
        [items removeObjectAtIndex:0];
    [self.baseToolbar setItems:items animated:YES];
    */
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    if(orientation == 0)
        orientation = self.interfaceOrientation;
    
  //  if(UIDeviceOrientationIsPortrait(orientation))

    
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
    NSMutableArray *items1 = [[self.baseToolbar items] mutableCopy];
    [items1 insertObject:barButtonItem atIndex:0];
    [self.baseToolbar setItems:items1 animated:YES];
    }
	
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Remove the popover button.
	// [baseNavigationBar.topItem setLeftBarButtonItem:nil animated:NO];
    
    NSMutableArray *items = [[self.baseToolbar items] mutableCopy];
    if([items count])
        [items removeObjectAtIndex:0];
    [self.baseToolbar setItems:items animated:YES];
    
}

-(void) showAlert:(NSString *)alertText
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information" message:alertText delegate:nil cancelButtonTitle:nil otherButtonTitles: @"OK", nil];
	[alertView show];
}
@end
