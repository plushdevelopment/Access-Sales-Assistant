//
//  VisitApplicationSummaryTableViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationSummaryTableViewController.h"

#import "UITableView+PRPSubviewAdditions.h"

#import "SummaryGeneralTableViewCell.h"

#import "SummarySpokeWithTableViewCell.h"

#import "SummaryCompetitorTableViewCell.h"

#import "SummaryBarriersToBusinessTableViewCell.h"

#import "SummaryStatsTableViewCell.h"

#import "DailySummary.h"

#import "Producer.h"

#import "PurposeOfCall.h"

#import "PersonSpokeWith.h"

#import "Competitor.h"

#import "BarrierToBusiness.h"

#import "Title.h"

#import "CommissionStructure.h"

#import "ProducerAddOn.h"

enum PRPTableSections {
    PRPTableSectionGeneral = 0,
    PRPTableSectionSpokeWith,
	PRPTableSectionCompetitor,
	PRPTableSectionBarriersToBusiness,
	PRPTableSectionStats,
    PRPTableNumSections
};

enum PRPTableGeneralTags {
    PRPTableGeneralProducerName = 1,
    PRPTableGeneralCallType,
	PRPTableGeneralReportDate
};

enum PRPTableSpokeWithTags {
    PRPTableSpokeWithFirstName = 1,
    PRPTableSpokeWithTitle,
	PRPTableSpokeWithLastName,
	PRPTableSpokeWithEmail
};

enum PRPTableCompetitorTags {
    PRPTableCompetitorName = 1,
    PRPTableCompetitorAppsPerMonth,
	PRPTableCompetitorCommissionStructure,
	PRPTableCompetitorPercentNew,
	PRPTableCompetitorPercentRenewal
};

enum PRPTableBarrierTags {
    PRPTableBarrierName = 1
};

enum PRPTableStatsTags {
    PRPTableStatsTotalAppsPerMonth = 1,
    PRPTableStatsMonthlyGoal,
	PRPTableStatsPercentLiab,
	PRPTableStatsPercentFDL,
	PRPTableStatsProducerAddOn,
	PRPTableStatsRDFollowUp
};

@implementation VisitApplicationSummaryTableViewController

@synthesize detailItem=_detailItem;

@synthesize summaryGeneralTableViewCellNib=_summaryGeneralTableViewCellNib;

@synthesize summarySpokeWithTableViewCellNib=_summarySpokeWithTableViewCellNib;

@synthesize summaryCompetitorTableViewCellNib=_summaryCompetitorTableViewCellNib;

@synthesize summaryBarriersToBusinessTableViewCellNib=_summaryBarriersToBusinessTableViewCellNib;

@synthesize summaryStatsTableViewCellNib=_summaryStatsTableViewCellNib;

@synthesize pickerViewController=_pickerViewController;

@synthesize aPopoverController=_aPopoverController;

@synthesize managedObjectContext=_managedObjectContext;

#pragma mark -
#pragma mark IBActions

- (IBAction)cellButtonTapped:(id)sender
{
	NSIndexPath *pathForButton = [self.tableView prp_indexPathForRowContainingView:sender];
}

// Show the pickerView inside of a popover
- (IBAction)showPickerView:(id)sender
{
	UIButton *button = (UIButton *)sender;
	
	self.pickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.pickerViewController.currentTag = button.tag;
	[self.pickerViewController setContentSizeForViewInPopover:CGSizeMake(344.0, 259.0)];
	_aPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.pickerViewController];
	[self.aPopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
	UIPickerView *pickerView = self.pickerViewController.pickerView;
	[pickerView setDelegate:self];
	[pickerView setDataSource:self];
	[pickerView setShowsSelectionIndicator:YES];
	[pickerView selectRow:0 inComponent:0 animated:NO];
	[pickerView reloadAllComponents];
}

// Show the Date picker in Date mode in a popover
- (IBAction)showDatePickerView:(id)sender
{
	
	UIButton *button = (UIButton *)sender;
	DatePickerViewController *viewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
	[viewController.datePicker setDate:[NSDate date]];
	viewController.delegate = self;
	viewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	viewController.currentTag = button.tag;
	[viewController setContentSizeForViewInPopover:viewController.view.frame.size];
	_aPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
	[self.aPopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[viewController.datePicker setDatePickerMode:UIDatePickerModeDate];
}

#pragma mark -
#pragma mark Accessors

- (UINib *)summaryGeneralTableViewCellNib
{
	if (_summaryGeneralTableViewCellNib == nil) {
		self.summaryGeneralTableViewCellNib = [SummaryGeneralTableViewCell nib];
	}
	return _summaryGeneralTableViewCellNib;
}

- (UINib *)summarySpokeWithTableViewCellNib
{
	if (_summarySpokeWithTableViewCellNib == nil) {
		self.summarySpokeWithTableViewCellNib = [SummarySpokeWithTableViewCell nib];
	}
	return _summarySpokeWithTableViewCellNib;
}

- (UINib *)summaryCompetitorTableViewCellNib
{
	if (_summaryCompetitorTableViewCellNib == nil) {
		self.summaryCompetitorTableViewCellNib = [SummaryCompetitorTableViewCell nib];
	}
	return _summaryCompetitorTableViewCellNib;
}

- (UINib *)summaryBarriersToBusinessTableViewCellNib
{
	if (_summaryBarriersToBusinessTableViewCellNib == nil) {
		self.summaryBarriersToBusinessTableViewCellNib = [SummaryBarriersToBusinessTableViewCell nib];
	}
	return _summaryBarriersToBusinessTableViewCellNib;
}

- (UINib *)summaryStatsTableViewCellNib
{
	if (_summaryStatsTableViewCellNib == nil) {
		self.summaryStatsTableViewCellNib = [SummaryStatsTableViewCell nib];
	}
	return _summaryStatsTableViewCellNib;
}

- (PickerViewController *)pickerViewController
{
	if (_pickerViewController == nil) {
		self.pickerViewController = [[PickerViewController alloc] initWithNibName:@"PickerViewController" bundle:nil];
	}
	return _pickerViewController;
}

- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext == nil) {
		self.managedObjectContext = [NSManagedObjectContext defaultContext];
	}
	return _managedObjectContext;
}

#pragma mark -
#pragma mark Detail item

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
	if (self.detailItem) {
		if ([self.detailItem valueForKey:@"editedValue"]) {
			[[NSManagedObjectContext defaultContext] save];
		}
	}
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
	
	if (self.aPopoverController != nil) {
        [self.aPopoverController dismissPopoverAnimated:YES];
    } 
}

- (void)configureView
{
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Memory Management

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.summaryGeneralTableViewCellNib = nil;
	self.summarySpokeWithTableViewCellNib = nil;
	self.summaryCompetitorTableViewCellNib = nil;
	self.summaryBarriersToBusinessTableViewCellNib = nil;
	self.summaryStatsTableViewCellNib = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return PRPTableNumSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *theTitle = @"";
	if (self.detailItem) {
		switch (section) {
			case PRPTableSectionGeneral:
				theTitle = @"General";
				break;
			case PRPTableSectionSpokeWith:
				theTitle = @"Who Did You Speak With";
				break;
			case PRPTableSectionCompetitor:
				theTitle = @"Competitors";
				break;
			case PRPTableSectionBarriersToBusiness:
				theTitle = @"Barriers to Business";
				break;
			case PRPTableSectionStats:
				theTitle = @"Non-Standard Business Stats";
				break;
			default:
				NSLog(@"Unexpected section (%d)", section);
				break;
		}
	}
    return theTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;
	if (self.detailItem) {
		switch (section) {
			case PRPTableSectionGeneral:
				rows = 1;
				break;
			case PRPTableSectionSpokeWith:
				if (self.detailItem.personsSpokeWith.allObjects.count == 0) {
					PersonSpokeWith *person = [PersonSpokeWith createEntity];
					[self.detailItem addPersonsSpokeWithObject:person];
					[self.managedObjectContext save];
				}
				rows = self.detailItem.personsSpokeWith.allObjects.count;
				break;
			case PRPTableSectionCompetitor:
				if (self.detailItem.competitors.allObjects.count == 0) {
					Competitor *competitor = [Competitor createEntity];
					[self.detailItem addCompetitorsObject:competitor];
					[self.managedObjectContext save];
				}
				rows = self.detailItem.competitors.allObjects.count;
				break;
			case PRPTableSectionBarriersToBusiness:
				if (self.detailItem.barriersToBusiness.allObjects.count == 0) {
					BarrierToBusiness *barrier = [BarrierToBusiness createEntity];
					[self.detailItem addBarriersToBusinessObject:barrier];
					[self.managedObjectContext save];
				}
				rows = self.detailItem.barriersToBusiness.allObjects.count;;
				break;
			case PRPTableSectionStats:
				rows = 1;
				break;
			default:
				NSLog(@"Unexpected section (%d)", section);
				break;
		}
	}
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	switch (indexPath.section) {
        case PRPTableSectionGeneral: {
            SummaryGeneralTableViewCell *customCell = [SummaryGeneralTableViewCell cellForTableView:tableView fromNib:self.summaryGeneralTableViewCellNib];
			
			customCell.producerNameTextField.text = self.detailItem.producerId.name;
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"MM-dd-yyyy"];
			customCell.reportDateTextField.text = [formatter stringFromDate:self.detailItem.reportDate];
			customCell.callTypeTextField.text = self.detailItem.purposeOfCall.name;
			
			[customCell.reportDateButton addTarget:self action:@selector(showDatePickerView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
        case PRPTableSectionSpokeWith: {
            SummarySpokeWithTableViewCell *customCell = [SummarySpokeWithTableViewCell cellForTableView:tableView fromNib:self.summarySpokeWithTableViewCellNib];
			
			PersonSpokeWith *person = (PersonSpokeWith *)[self.detailItem.personsSpokeWith.allObjects objectAtIndex:indexPath.row];
			
			customCell.firstNameTextField.text = [person firstName];
			customCell.lastNameTextField.text = [person lastName];
			customCell.titleTextField.text = [person.title name];
			customCell.emailAddressTextField.text = [person email];
			
			[customCell.titleButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
		case PRPTableSectionCompetitor: {
			SummaryCompetitorTableViewCell *customCell = [SummaryCompetitorTableViewCell cellForTableView:tableView fromNib:self.summaryCompetitorTableViewCellNib];
			
			Competitor *competitor = (Competitor *)[self.detailItem.competitors.allObjects objectAtIndex:indexPath.row];
			
			customCell.competitorNameTextField.text = competitor.name;
			customCell.appsPerMonthTextField.text = competitor.appsPerMonth.stringValue;
			customCell.commissionStructureTextField.text = self.detailItem.commissionStructure.name;
			customCell.percentNewTextField.text = self.detailItem.commissionPercentNew.stringValue;
			customCell.percentRenewalTextField.text = self.detailItem.commissionPercentRenewal.stringValue;
			
			[customCell.competitorNameButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			[customCell.commissionStructureButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
		case PRPTableSectionBarriersToBusiness: {
			SummaryBarriersToBusinessTableViewCell *customCell = [SummaryBarriersToBusinessTableViewCell cellForTableView:tableView fromNib:self.summaryBarriersToBusinessTableViewCellNib];
			
			BarrierToBusiness *barrier = (BarrierToBusiness *)[self.detailItem.barriersToBusiness.allObjects objectAtIndex:indexPath.row];
			
			customCell.barrierToBusinessTextField.text = barrier.name;
			
			[customCell.barrierToBusinessButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
		case PRPTableSectionStats: {
			SummaryStatsTableViewCell *customCell = [SummaryStatsTableViewCell cellForTableView:tableView fromNib:self.summaryStatsTableViewCellNib];
			
			customCell.totalAppsPerMonthTextField.text = self.detailItem.nsbsTotAppsPerMonth.stringValue;
			customCell.percentLiabTextField.text = self.detailItem.nsbsPercentLiab.stringValue;
			customCell.producerAddOnTextField.text = self.detailItem.producerAddOn.name;
			customCell.rdFollowUpTextField.text = self.detailItem.rdFollowUp.stringValue;
			customCell.monthlyGoalTextField.text = self.detailItem.nsbsMonthlyGoal.stringValue;
			customCell.percentFDLTextField.text = self.detailItem.nsbsFdl.stringValue;
			
			[customCell.rdFollowUpButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			[customCell.producerAddOnButton addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
        default:
            NSLog(@"Unexpected section (%d)", indexPath.section);
            break;
    }
	
	for (id subview in [cell subviews]) {
		if ([subview isKindOfClass:[UITextField class]]) {
			UITextField *textField = (UITextField *)subview;
			textField.delegate = self;
		}
	}
	
	return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
            height = 110.0;
			break;
        case PRPTableSectionSpokeWith:
            height = 110.0;
			break;
		case PRPTableSectionCompetitor:
			height = 44.0;
			break;
		case PRPTableSectionBarriersToBusiness:
			height = 44.0;
			break;
		case PRPTableSectionStats:
			height = 149.0;
			break;
        default:
            NSLog(@"Unexpected section (%d)", indexPath.section);
            break;
    }
    return height;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	DailySummary *summary = self.detailItem;
	if (!summary.editedValue) {
		summary.editedValue = YES;
		[self.managedObjectContext save];
	}
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSInteger rows = 0;
	switch (self.pickerViewController.currentIndexPath.section) {
		case PRPTableSectionGeneral:
			switch (self.pickerViewController.currentTag) {
				case PRPTableGeneralCallType:
					rows = [[PurposeOfCall numberOfEntities] integerValue];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionSpokeWith:
			switch (self.pickerViewController.currentTag) {
				case PRPTableSpokeWithTitle:
					rows = [[Title numberOfEntities] integerValue];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (self.pickerViewController.currentTag) {
				case PRPTableCompetitorName:
					rows = [[Competitor numberOfEntities] integerValue];
					break;
				case PRPTableCompetitorCommissionStructure:
					rows = [[CommissionStructure numberOfEntities] integerValue];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionBarriersToBusiness:
			switch (self.pickerViewController.currentTag) {
				case PRPTableBarrierName:
					rows = [[BarrierToBusiness numberOfEntities] integerValue];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionStats:
			switch (self.pickerViewController.currentTag) {
				case PRPTableStatsProducerAddOn:
					rows = [[ProducerAddOn numberOfEntities] integerValue];
					break;
				case PRPTableStatsRDFollowUp:
					rows = 100;
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	return rows;
}


#pragma mark -
#pragma mark UIPickerViewDelegate

// Set the appropriate value for a text field based on what the current tag is
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{	
	NSString *titleForRow = [pickerView.delegate
							 pickerView:pickerView
							 titleForRow:row
							 forComponent:component];
	
	NSIndexPath *indexPath = self.pickerViewController.currentIndexPath;
	
	switch (indexPath.section) {
		case PRPTableSectionGeneral:
			switch (self.pickerViewController.currentTag) {
				case PRPTableGeneralCallType:
					// Change value in model object
					self.detailItem.purposeOfCall = [PurposeOfCall findFirstByAttribute:@"name" withValue:titleForRow];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionSpokeWith:
			switch (self.pickerViewController.currentTag) {
				case PRPTableSpokeWithTitle: {
					// Change value in model object
					PersonSpokeWith *person = [self.detailItem.personsSpokeWith.allObjects objectAtIndex:indexPath.row];
					person.title = [Title findFirstByAttribute:@"name" withValue:titleForRow];
				}
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (self.pickerViewController.currentTag) {
				case PRPTableCompetitorName: {
					Competitor *competitor = [Competitor findFirstByAttribute:@"name" withValue:titleForRow];
					[[self.detailItem.competitorsSet.allObjects objectAtIndex:indexPath.row] removeIndex:indexPath.row];
					
				}
					break;
				case PRPTableCompetitorCommissionStructure:
					// Change value in model object
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionBarriersToBusiness:
			switch (self.pickerViewController.currentTag) {
				case PRPTableBarrierName:
					// Change value in model object
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionStats:
			switch (self.pickerViewController.currentTag) {
				case PRPTableStatsProducerAddOn:
					// Change value in model object
					break;
				case PRPTableStatsRDFollowUp:
					// Change value in model object
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	[self.managedObjectContext save];
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.pickerViewController.currentIndexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *theTitle = @"NOT SET";
	switch (self.pickerViewController.currentIndexPath.section) {
		case PRPTableSectionGeneral:
			switch (self.pickerViewController.currentTag) {
				case PRPTableGeneralCallType:
					theTitle = [[[PurposeOfCall findAll] objectAtIndex:row] name];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionSpokeWith:
			switch (self.pickerViewController.currentTag) {
				case PRPTableSpokeWithTitle:
					theTitle = [[[Title findAll] objectAtIndex:row] name];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (self.pickerViewController.currentTag) {
				case PRPTableCompetitorName:
					theTitle = [[[Competitor findAll] objectAtIndex:row] name];
					break;
				case PRPTableCompetitorCommissionStructure:
					theTitle = [[[CommissionStructure findAll] objectAtIndex:row] name];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionBarriersToBusiness:
			switch (self.pickerViewController.currentTag) {
				case PRPTableBarrierName:
					theTitle = [[[BarrierToBusiness findAll] objectAtIndex:row] name];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionStats:
			switch (self.pickerViewController.currentTag) {
				case PRPTableStatsProducerAddOn:
					theTitle = [[[ProducerAddOn findAll] objectAtIndex:row] name];
					break;
				case PRPTableStatsRDFollowUp:
					theTitle = [NSString stringWithFormat:@"%d", row];
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}

	return theTitle;
}

#pragma mark -
#pragma mark DatePickerViewControllerDelegate

- (void)datePickerViewController:(DatePickerViewController *)controller didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
	switch (controller.currentIndexPath.section) {
		case PRPTableSectionGeneral:
			switch (self.pickerViewController.currentTag) {
				case PRPTableGeneralReportDate:
					[formatter setDateFormat:@"MM-dd-yyyy"];
					// Change value in model object
					// Change value in textField
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	[[NSManagedObjectContext defaultContext] save];
}

- (void)nextField:(NSInteger)currentTag
{
	[self.aPopoverController dismissPopoverAnimated:YES];
	switch (currentTag) {
		case 0:
			break;
		default:
			break;
	}
}

- (void)previousField:(NSInteger)currentTag
{
	
}

@end
