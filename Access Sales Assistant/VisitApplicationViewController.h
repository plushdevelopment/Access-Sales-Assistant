//
//  VisitApplicationViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"
#import "VisitApplicationProfileViewController.h"
#import "VisitApplicationSummaryTableViewController.h"
#import "VisitApplicationNotesViewController.h"
#import "VisitApplicationPhotosViewController.h"

@interface VisitApplicationViewController : BaseDetailViewController <UIImagePickerControllerDelegate> {
}

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutlet UIView *activeVisitFormView;

@property (nonatomic, strong) IBOutlet VisitApplicationProfileViewController *profileApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationSummaryTableViewController *summaryApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationNotesViewController *notesApplicationViewController;
@property (nonatomic, strong) IBOutlet VisitApplicationPhotosViewController *photoApplicationViewController;

@property (nonatomic, strong) id detailItem;

@property (nonatomic, strong) UIViewController *currentController;

@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

- (IBAction)loadApplicationForm:(id)sender;

- (IBAction)submitApplicationForm:(id)sender;

- (void)configureView;

@end
