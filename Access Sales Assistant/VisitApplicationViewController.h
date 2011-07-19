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
#import "VisitApplicationNotesViewController.h"
#import "VisitApplicationPhotosViewController.h"

@interface VisitApplicationViewController : DetailViewController <UIImagePickerControllerDelegate> {
	
	UIView *activeVisitFormView;
	VisitApplicationProfileViewController *profileApplicationViewController;
	VisitApplicationSummaryTableViewController *summaryApplicationViewController;
	VisitApplicationNotesViewController *notesApplicationViewController;
	VisitApplicationPhotosViewController *photoApplicationViewController;

}

@property (nonatomic, strong) IBOutlet UIView *activeVisitFormView;

@property (nonatomic, strong) IBOutlet VisitApplicationProfileViewController *profileApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationSummaryTableViewController *summaryApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationNotesViewController *notesApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationPhotosViewController *photoApplicationViewController;

@property (nonatomic, strong) id detailItem;

@property (nonatomic, strong) UIViewController *currentController;

- (IBAction)loadApplicationForm:(id)sender;

- (IBAction)submitApplicationForm:(id)sender;

- (void)configureView;

@end
