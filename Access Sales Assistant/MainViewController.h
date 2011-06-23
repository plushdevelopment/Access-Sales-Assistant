//
//  MainViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController <UITabBarDelegate, UIScrollViewDelegate> {
    IBOutlet UITabBar *tabBar;
	IBOutlet UIButton *phasesButton, *callsButton;
	IBOutlet UIView *pageView, *sidebarView, *totalAccessView;
	IBOutlet UIViewController *pageViewController;
	
	IBOutlet UIButton *phase1Button, *phase2Button, *phase3Button, *phase4Button;
	IBOutlet UIButton *prospectCallButton, *suspendedCallButton, *zeroProducerCallButton, *producerCallButton;
	
	BOOL inPhases;	// True if showing Phases, false if showing Calls
	int currentViewIndex; // Index of the view that should be shown in the array
	
	NSMutableArray *phaseTableData;
	NSMutableArray *callTableData;
}

-(IBAction) phaseCallSwap:(id)sender;
-(IBAction) pageViewSelection:(id)sender;
-(IBAction) totalAccessToggle:(id)sender;

-(void) updatePageView;

@end
