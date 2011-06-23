//
//  MainViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "DailySummaryViewController.h"
#import "AppointmentApplicationViewController.h"
#import "ContactsViewController.h"

@implementation MainViewController

#pragma mark - View Actions
-(IBAction) phaseCallSwap:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	// deselect all buttons
	phase1Button.selected = NO;
	phase2Button.selected = NO;
	phase3Button.selected = NO;
	phase4Button.selected = NO;
	prospectCallButton.selected = NO;
	suspendedCallButton.selected = NO;
	zeroProducerCallButton.selected = NO;
	producerCallButton.selected = NO;
	
	switch (button.tag) {
		case 0:
			inPhases = YES;
			phasesButton.selected = YES;
			callsButton.selected = NO;
			
			phase1Button.selected = YES;
			
			phase1Button.hidden = NO;
			phase2Button.hidden = NO;
			phase3Button.hidden = NO;
			phase4Button.hidden = NO;
			prospectCallButton.hidden = YES;
			suspendedCallButton.hidden = YES;
			zeroProducerCallButton.hidden = YES;
			producerCallButton.hidden = YES;
			break;
		case 1:
			inPhases = NO;
			phasesButton.selected = NO;
			callsButton.selected = YES;
			
			prospectCallButton.selected = YES;
			
			phase1Button.hidden = YES;
			phase2Button.hidden = YES;
			phase3Button.hidden = YES;
			phase4Button.hidden = YES;
			prospectCallButton.hidden = NO;
			suspendedCallButton.hidden = NO;
			zeroProducerCallButton.hidden = NO;
			producerCallButton.hidden = NO;
			break;
		default:
			NSLog(@"Invalid Phase/Call change button.");
			return;
	}
	
	// Change page view
	currentViewIndex = 0;
	
	[self updatePageView];
}

-(IBAction) pageViewSelection:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	// deselect all buttons
	phase1Button.selected = NO;
	phase2Button.selected = NO;
	phase3Button.selected = NO;
	phase4Button.selected = NO;
	prospectCallButton.selected = NO;
	suspendedCallButton.selected = NO;
	zeroProducerCallButton.selected = NO;
	producerCallButton.selected = NO;
	
	button.selected = YES;
	
	currentViewIndex = button.tag;
	
	[self updatePageView];
}

-(IBAction) totalAccessToggle:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	CGRect frame = totalAccessView.frame;
	if (frame.origin.y == sidebarView.frame.size.height - 35) {
		frame.origin.y = sidebarView.frame.size.height - frame.size.height;
	} else {
		frame.origin.y = sidebarView.frame.size.height - 35;
	}
	[UIView animateWithDuration:0.5 animations:^{totalAccessView.frame = frame;} completion:^(BOOL finished){button.selected = !button.selected;}];
}

-(void) updatePageView {
	NSDictionary *dict;
	NSString *controllerClass, *viewNib;
	
	// Determine whether to check phases or calls
	if (inPhases) {
		dict = [phaseTableData objectAtIndex:currentViewIndex];
	} else {
		dict = [callTableData objectAtIndex:currentViewIndex];
	}
	
	controllerClass = [dict objectForKey:@"Controller"];
	viewNib = [dict objectForKey:@"Nib"];
	if (controllerClass != nil) {
		[pageViewController.view removeFromSuperview];
		[pageViewController release];
		if(viewNib != nil) {
			pageViewController = [[NSClassFromString(controllerClass) alloc] initWithNibName:viewNib bundle:nil];
		} else {
			pageViewController = [[NSClassFromString(controllerClass) alloc] init];
		}
		pageViewController.view.frame = CGRectMake(0, 0, 827, 655);
		[pageView addSubview:pageViewController.view];
	}
	
	// If in a phase, set the scrollview delegate to this object
	if(inPhases) {
		UIScrollView *scrollView = (UIScrollView *)pageViewController.view;
		scrollView.delegate = self;
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self == [super initWithCoder:aDecoder]) {
		// Custom initialization
		
		// Set to Phases by default
		inPhases = YES;
		
		// Set up table data
		phaseTableData = [[NSMutableArray alloc] initWithCapacity:4];
		callTableData = [[NSMutableArray alloc] initWithCapacity:4];
		NSMutableDictionary *dict;
		
		// Phase buildout
		// Phase 1
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"PhasesViewController" forKey:@"Controller"];
		[dict setObject:@"Phase1View" forKey:@"Nib"];
		[phaseTableData addObject:dict];
		[dict release];
		
		// Phase 2
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"PhasesViewController" forKey:@"Controller"];
		[dict setObject:@"Phase2View" forKey:@"Nib"];
		[phaseTableData addObject:dict];
		[dict release];
		
		// Phase 3
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"PhasesViewController" forKey:@"Controller"];
		[dict setObject:@"Phase3View" forKey:@"Nib"];
		[phaseTableData addObject:dict];
		[dict release];
		
		// Phase 4
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"PhasesViewController" forKey:@"Controller"];
		[dict setObject:@"Phase4View" forKey:@"Nib"];
		[phaseTableData addObject:dict];
		[dict release];
		
		// Call buildout
		// Prospect Call
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"ProspectCallViewController" forKey:@"Controller"];
		[dict setObject:@"ProspectCallView" forKey:@"Nib"];
		[callTableData addObject:dict];
		[dict release];
		
		// Suspended Call
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"SuspendedCallViewController" forKey:@"Controller"];
		[dict setObject:@"SuspendedCallView" forKey:@"Nib"];
		[callTableData addObject:dict];
		[dict release];
		
		// Zero Producer Call
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"ZeroProducerCallViewController" forKey:@"Controller"];
		[dict setObject:@"ZeroProducerCallView" forKey:@"Nib"];
		[callTableData addObject:dict];
		[dict release];
		
		// Producer Call
		dict = [[NSMutableDictionary alloc] init];
		[dict setObject:@"ProducerCallViewController" forKey:@"Controller"];
		[dict setObject:@"ProducerCallView" forKey:@"Nib"];
		[callTableData addObject:dict];
		[dict release];
	}
	return self;
}

- (void)dealloc
{
	[tabBar release];
	[phasesButton release];
	[callsButton release];
	[pageView release];
	[sidebarView release];
	[totalAccessView release];
	[pageViewController release];
	
	[phase1Button release];
	[phase2Button release];
	[phase3Button release];
	[phase4Button release];
	
	[prospectCallButton release];
	[suspendedCallButton release];
	[zeroProducerCallButton release];
	[producerCallButton release];
	
	[prospectCallButton release];
	
	[phaseTableData release];
	[callTableData release];
	
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView {
}*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	tabBar.delegate = self;
	
	// set up sidebar background tiling
	[sidebarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"sidebar-background.png"]]];
	[sidebarView setOpaque:NO];
	[[sidebarView layer] setOpaque:NO];
	
	// Set up main view background tiling
	[pageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"little-gray-box.png"]]];
	[pageView setOpaque:NO];
	
	// Load default view
	pageViewController = [[UIViewController alloc] initWithNibName:@"BaseView" bundle:nil];
	pageViewController.view.frame = CGRectMake(0, 0, 827, 655);
	[pageView addSubview:pageViewController.view];
	
	// Select the phases button by default
	phasesButton.selected = YES;
	
	// Add the total access view
	CGRect frame = totalAccessView.frame;
	frame.origin = CGPointMake(0, sidebarView.frame.size.height - 35);
	totalAccessView.frame = frame;
	[sidebarView addSubview:totalAccessView];
	
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

#pragma mark - Scroll View Delegate -- Meant for Phase screens
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSDictionary *dict;
	NSString *controllerClass, *viewNib;
	UIViewController *oldController;
	
	if (scrollView.contentOffset.y <= -66 && scrollView.tag!=1) {
		// Released above the header and not phase 1
		currentViewIndex -= 1;
		
		// Load new
		dict = [phaseTableData objectAtIndex:currentViewIndex];
		
		controllerClass = [dict objectForKey:@"Controller"];
		viewNib = [dict objectForKey:@"Nib"];
		if (controllerClass != nil) {
			oldController = pageViewController;
			if(viewNib != nil) {
				pageViewController = [[NSClassFromString(controllerClass) alloc] initWithNibName:viewNib bundle:nil];
			} else {
				pageViewController = [[NSClassFromString(controllerClass) alloc] init];
			}
			pageViewController.view.frame = CGRectMake(0, -655, 827, 655);
			[pageView addSubview:pageViewController.view];
			UIScrollView *scrollView = (UIScrollView *)pageViewController.view;
			scrollView.delegate = self;
			
			// animate swap
			[UIView animateWithDuration:0.5
					 animations:^{pageViewController.view.frame = CGRectMake(0, 0, 827, 655); oldController.view.frame = CGRectMake(0, 655, 827, 655);}
					 completion:^(BOOL finished){[oldController.view removeFromSuperview]; [oldController release];}
			];
		}
		
	} else if(scrollView.contentOffset.y >= scrollView.contentSize.height + 66 - 655 && scrollView.tag!=4) {
		// Released below the footer and not phase 4
		currentViewIndex += 1;
		
		// Load new
		dict = [phaseTableData objectAtIndex:currentViewIndex];
		
		controllerClass = [dict objectForKey:@"Controller"];
		viewNib = [dict objectForKey:@"Nib"];
		if (controllerClass != nil) {
			oldController = pageViewController;
			if(viewNib != nil) {
				pageViewController = [[NSClassFromString(controllerClass) alloc] initWithNibName:viewNib bundle:nil];
			} else {
				pageViewController = [[NSClassFromString(controllerClass) alloc] init];
			}
			pageViewController.view.frame = CGRectMake(0, 655, 827, 655);
			[pageView addSubview:pageViewController.view];
			UIScrollView *scrollView = (UIScrollView *)pageViewController.view;
			scrollView.delegate = self;
			
			// animate swap
			[UIView animateWithDuration:0.5
							 animations:^{pageViewController.view.frame = CGRectMake(0, 0, 827, 655); oldController.view.frame = CGRectMake(0, -655, 827, 655);}
							 completion:^(BOOL finished){[oldController.view removeFromSuperview]; [oldController release];}
			 ];
		}
		
	} else {
		// Neither, so end call
		return;
	}
	
	// Update button selection
	phase1Button.selected = NO;
	phase2Button.selected = NO;
	phase3Button.selected = NO;
	phase4Button.selected = NO;
	
	switch (currentViewIndex) {
		case 0:
			phase1Button.selected = YES;
			break;
		case 1:
			phase2Button.selected = YES;
			break;
		case 2:
			phase3Button.selected = YES;
			break;
		case 3:
			phase4Button.selected = YES;
			break;
		default:
			break;
	}
}

#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)methodTabBar didSelectItem:(UITabBarItem *)item {
	
	/*
	 Tags
	 0 = Daily Summary
	 1 = Features
	 2 = Access Academy
	 3 = Contacts
	 */
	UIViewController *modalView;
	CGRect frame = CGRectMake(0,0,0,0);
	
	switch (item.tag) {
		case 0:
			// Daily summary
			modalView = [[DailySummaryViewController alloc] initWithNibName:@"DailySummaryView" bundle:nil];
			frame = CGRectMake(0, 64, 1024, 704);
			break;
		case 2:
			// Appointment application
			modalView = [[AppointmentApplicationViewController alloc] initWithNibName:@"AppointmentApplicationView" bundle:nil];
			frame = CGRectMake(98, 74, 827, 600);
			break;
		case 4:
			modalView = [[ContactsViewController alloc] initWithNibName:@"ContactsView" bundle:nil];
			frame = CGRectMake(242, 184, 540, 400);
			break;
		default:
			methodTabBar.selectedItem = nil;
			return;
			break;
	}
	
	modalView.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentModalViewController:modalView animated:YES];
	if (frame.size.height != 0) {
		modalView.view.superview.frame = frame;
	}
	
	[modalView release];
	
	methodTabBar.selectedItem = nil;
}

@end
