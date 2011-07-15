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
#import "VisitApplicationSummaryTableViewController.h"

@interface VisitApplicationViewController : DetailViewController {
	
	UIView *activeVisitFormView;
	VisitApplicationProfileViewController *profileApplicationViewController;
	VisitApplicationSummaryTableViewController *summaryApplicationViewController;

}

@property (nonatomic, strong) IBOutlet UIView *activeVisitFormView;

@property (nonatomic, strong) IBOutlet VisitApplicationProfileViewController *profileApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationSummaryTableViewController *summaryApplicationViewController;

@property (nonatomic, strong) id detailItem;

- (IBAction)loadApplicationForm:(id)sender;

- (IBAction)submitApplicationForm:(id)sender;

- (void)configureView;

@end
