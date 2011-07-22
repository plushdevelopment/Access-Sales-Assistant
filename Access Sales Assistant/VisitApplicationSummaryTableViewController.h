//
//  VisitApplicationSummaryTableViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
#import "PickerViewController.h"

@class DailySummary;

@interface VisitApplicationSummaryTableViewController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DatePickerViewControllerDelegate>


@property (nonatomic, strong) DailySummary *detailItem;
@property (nonatomic, strong) UINib *summaryGeneralTableViewCellNib;
@property (nonatomic, strong) UINib *summarySpokeWithTableViewCellNib;
@property (nonatomic, strong) UINib *summaryCompetitorTableViewCellNib;
@property (nonatomic, strong) UINib *summaryBarriersToBusinessTableViewCellNib;
@property (nonatomic, strong) UINib *summaryStatsTableViewCellNib;
@property (nonatomic, strong) IBOutlet PickerViewController *pickerViewController;
@property (nonatomic, strong) IBOutlet DatePickerViewController *datePickerViewController;
@property (nonatomic, strong) UIPopoverController *aPopoverController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)configureView;
- (IBAction)showPickerView:(id)sender;
- (IBAction)showDatePickerView:(id)sender;

@end
