//
//  VisitApplicationViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "VisitApplicationProfileViewController.h"
#import "TestSensibleTableViewController.h"

@interface VisitApplicationViewController : DetailViewController {
	
	UIView *activeVisitFormView;
	UINavigationController *profileNavigationController;
	VisitApplicationProfileViewController *profileApplicationViewController;
	TestSensibleTableViewController *testViewController;

}

@property (nonatomic, strong) IBOutlet UIView *activeVisitFormView;

@property (nonatomic, strong) IBOutlet UINavigationController *profileNavigationController;

@property (nonatomic, strong) IBOutlet VisitApplicationProfileViewController *profileApplicationViewController;

- (IBAction)loadApplicationForm:(id)sender;

- (IBAction)submitApplicationForm:(id)sender;


@end
