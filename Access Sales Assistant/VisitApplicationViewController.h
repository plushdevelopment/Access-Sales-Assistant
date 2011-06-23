//
//  VisitApplicationViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitApplicationProfileViewController.h"

@interface VisitApplicationViewController : UIViewController <UISplitViewControllerDelegate> {
	
	UIView *activeVisitFormView;
	VisitApplicationProfileViewController *profileApplicationViewController;
}

@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) UIPopoverController *popoverController;

@property (nonatomic, strong) IBOutlet UIView *activeVisitFormView;

@property (nonatomic, strong) IBOutlet VisitApplicationProfileViewController *profileApplicationViewController;

- (IBAction)loadApplicationForm:(id)sender;

- (IBAction)submitApplicationForm:(id)sender;


@end
