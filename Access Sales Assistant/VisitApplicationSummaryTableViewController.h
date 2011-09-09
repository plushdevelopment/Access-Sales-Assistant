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
#import "VisitApplicationTabBarController.h"
#import "SmartTableView.h"
#import "BaseDetailViewController.h"

@class DailySummary;

@interface VisitApplicationSummaryTableViewController : BaseDetailViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DatePickerViewControllerDelegate, DetailViewController, UITableViewDelegate, UITableViewDataSource> {
	SmartTableView *_tableView;
    NSInteger currentSection;
}



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
@property (strong, nonatomic) IBOutlet SmartTableView *tableView;
@property (nonatomic) BOOL isCompetetorEdited;
@property (nonatomic) BOOL isPersonEdited;
@property (nonatomic) BOOL isBarrierEdited;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *submitButton;

@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSString* titleText;
//@property ()

- (void)configureView;
- (IBAction)showPickerView:(id)sender;
- (IBAction)showDatePickerView:(id)sender;
- (IBAction)showSelectionTableView:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;

-(void) toggleSubmitButton:(BOOL)isEnable;
-(BOOL) isEnableSubmit;

@end
