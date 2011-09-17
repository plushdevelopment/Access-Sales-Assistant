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

#import "PersonSpokeWithTitle.h"

#import "CommissionStructure.h"

#import "ProducerAddOn.h"

#import "PRPSmartTableViewCell.h"

#import "HTTPOperationController.h"

#import "NSString-Validation.h"

#import "ProducerProfileConstants.h"

#import "AddRowTableViewCell.h"

#import "SelectionModelViewController.h"

#import "ReasonNotSeen.h"

#define VIEW_HIDDEN_FRAME CGRectMake(0.0, 20.0, 768.0, 1004.0)
#define VIEW_VISIBLE_FRAME CGRectMake(0.0, -239.0, 768.0, 1004.0)
#define PICKER_VISIBLE_FRAME	CGRectMake(0.0, 765.0, 768.0, 259.0)
#define PICKER_HIDDEN_FRAME		CGRectMake(0, 864.0, 768.0, 259.0)

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
	PRPTableGeneralReportDate,
    PRPTableGeneralReasonNotSeen
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

@synthesize datePickerViewController = _datePickerViewController;

@synthesize aPopoverController=_aPopoverController;

@synthesize managedObjectContext=_managedObjectContext;
@synthesize tableView = _tableView;

@synthesize isCompetetorEdited = _isCompetetorEdited;

@synthesize isPersonEdited = _isPersonEdited;

@synthesize isBarrierEdited = _isBarrierEdited;

@synthesize submitButton = _submitButton;

@synthesize titleLabel = _titleLabel;

@synthesize titleText;

#pragma mark -
#pragma mark IBActions

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender
{
	[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[self.detailItem jsonStringValue]];
	self.detailItem.producerId.submittedValue = YES;
    
    NSLog(@"%@",self.detailItem);
}

// Show the pickerView inside of a popover
- (IBAction)showPickerView:(id)sender
{
	[self nextField:0];
	UIButton *button = (UIButton *)sender;
	
	self.pickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.pickerViewController.currentTag = button.tag;
	
	UIPickerView *pickerView = self.pickerViewController.pickerView;
	[pickerView setDelegate:self];
	[pickerView setDataSource:self];
	[pickerView setShowsSelectionIndicator:YES];
	[pickerView selectRow:0 inComponent:0 animated:NO];
	[pickerView reloadAllComponents];
	[self pickerView:pickerView didSelectRow:0 inComponent:0];
	
	//Position the picker out of sight
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.pickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		//Position of the picker in sight
		if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME_LANDSCAPE];
		} else {
			[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		}
		
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.pickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Picker Did Show" object:userInfo];
	}];
	
}

// Show the Date picker in Date mode in a popover
- (IBAction)showDatePickerView:(id)sender
{
	[self nextField:0];
	
	UIButton *button = (UIButton *)sender;
	[self.datePickerViewController.datePicker setDate:[NSDate date]];
	self.datePickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.datePickerViewController.currentTag = button.tag;
	[self.datePickerViewController.datePicker setDatePickerMode:UIDatePickerModeDate];
	
	//Position the picker out of sight
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
	
	//Add the picker to the view
	//[self.view.superview addSubview:self.datePickerViewController.view];
	[self.parentViewController.view addSubview:self.datePickerViewController.view];
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME_LANDSCAPE];
		} else {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		}
		
	} completion:^(BOOL finished){
		NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
        NSLog(@"%@", pickerFrame);
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:UIKeyboardFrameEndUserInfoKey, pickerFrame, nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Picker Did Show" object:userInfo];
	}];
	[self datePickerViewController:self.datePickerViewController didChangeDate:self.datePickerViewController.datePicker.date forTag:button.tag];
}


-(IBAction)showSelectionTableView:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    
    
    SelectionModelViewController *selectionView = [[SelectionModelViewController alloc] initWithNibName:@"SelectionModelViewController" bundle:nil];
    
    selectionView.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
    
    selectionView.currentTag = button.tag;
    
    [selectionView  setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [selectionView  setModalPresentationStyle:UIModalPresentationFormSheet];
    selectionView.delegate = self;
    
    
    switch(selectionView.currentIndexPath.section)
    {
        case PRPTableSectionGeneral:
        {
           switch(selectionView.currentTag)
            {
                case PRPTableGeneralReasonNotSeen:
                {
                    [selectionView assignDataSource:[ReasonNotSeen findAllSortedBy:@"name" ascending:YES]];
                    [self presentModalViewController:selectionView  animated:YES];

                    break;
                }
            }
            break;
        }
        case PRPTableSectionSpokeWith:
        {
            switch(selectionView.currentTag)
            {
                case PRPTableSpokeWithTitle:
                {
                    [selectionView assignDataSource:[PersonSpokeWithTitle findAllSortedBy:@"name" ascending:YES]];
                     [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
            }
            break;
        }
        case PRPTableSectionCompetitor:
        {
            switch(selectionView.currentTag)
            {
                case PRPTableCompetitorName:
                {
                    
                    Competitor *competitor = [self.detailItem.competitors.allObjects objectAtIndex:selectionView.currentIndexPath.row];
                    [self.detailItem removeCompetitorsObject:competitor];
                    [selectionView assignDataSource:[Competitor findAllSortedBy:@"name" ascending:YES]];
                     [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
                case PRPTableCompetitorCommissionStructure:
                {
                    [selectionView assignDataSource:[CommissionStructure findAllSortedBy:@"name" ascending:YES]];
                     [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
                case 1001:
                {
                    [selectionView assignDataSource:[Competitor findAllSortedBy:@"name" ascending:YES]];
                    [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
            }
            break;
        }
        case PRPTableSectionBarriersToBusiness:
        {
            switch(selectionView.currentTag)
            {
                case PRPTableBarrierName:
                {
                    BarrierToBusiness *barrier = [self.detailItem.barriersToBusiness.allObjects objectAtIndex:selectionView.currentIndexPath.row];
                    [self.detailItem removeBarriersToBusinessObject:barrier];
                    [selectionView assignDataSource:[BarrierToBusiness findAllSortedBy:@"name" ascending:YES]];
                     [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
                case 1005:
                {
                    [selectionView assignDataSource:[BarrierToBusiness findAllSortedBy:@"name" ascending:YES]];
                    [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
            }
            break;
        }
        case PRPTableSectionStats:
        {
            switch(selectionView.currentTag)
            {
                case PRPTableStatsProducerAddOn:
                {
                    [selectionView assignDataSource:[ProducerAddOn findAllSortedBy:@"name" ascending:YES]];
                     [self presentModalViewController:selectionView  animated:YES];
                    break;
                }
                case PRPTableStatsRDFollowUp:
                {
             //       [selectionView assignDataSource:[]]
                    break;
                }
            }
            break;
        }
            
    }
}

- (IBAction)handleSwitch:(id)sender
{
    UISwitch *rdfollowup = (UISwitch*) sender;
    
    if(rdfollowup.isOn)
        _detailItem.rdFollowUpValue = 1;
    else
        _detailItem.rdFollowUpValue = 0;
       
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

- (void)setDetailItem:(id)newDetailItem
{
	if (self.detailItem) {
		if ([self.detailItem valueForKey:@"editedValue"]) {
			[[NSManagedObjectContext defaultContext] save];
            
		}
        
        
	}
	
	Producer *producer = (Producer *)newDetailItem;
	if (!producer.dailySummary) {
        DailySummary *dSummary = [DailySummary createEntity]; 
		producer.dailySummary = dSummary;//[DailySummary createEntity];
	}
    

    if (_detailItem != producer.dailySummary) {
        _detailItem = producer.dailySummary;
        
      
        
        // Update the view.
        [self configureView];
    }
    
   titleText = [[NSString alloc]initWithFormat:@"%@ - %@",producer.name,producer.producerCode];  
   // NSLog(titleText);
	
 
        
	if (self.aPopoverController != nil) {
        [self.aPopoverController dismissPopoverAnimated:YES];
    } 
    [self toggleSubmitButton:[self isEnableSubmit]];
}

- (void)configureView
{
	[self.tableView reloadData];
}


-(void) toggleSubmitButton:(BOOL) isEnable
{
    
    [_submitButton setEnabled:isEnable];
}
#pragma mark -
#pragma mark Memory Management

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
	
	self.tableView.allowsSelection = NO;
    [self toggleSubmitButton:NO];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	 self.tableView.backgroundColor = [UIColor clearColor];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setDatePickerViewController:nil];
	[self setTableView:nil];
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
	[self.tableView reloadData];
    
       _titleLabel.text = titleText;
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
				/*
				if (self.detailItem.personsSpokeWith.allObjects.count == 0) {
					PersonSpokeWith *person = [PersonSpokeWith createEntity];
					[self.detailItem addPersonsSpokeWithObject:person];
					[self.managedObjectContext save];
				}
				 */
				rows = self.detailItem.personsSpokeWith.allObjects.count + 1;
				break;
			case PRPTableSectionCompetitor:
				/*
				if (self.detailItem.competitors.allObjects.count == 0) {
					Competitor *competitor = [Competitor createEntity];
					[self.detailItem addCompetitorsObject:competitor];
					[self.managedObjectContext save];
				}
				 */
				rows = self.detailItem.competitors.allObjects.count + 1;
				break;
			case PRPTableSectionBarriersToBusiness:
				/*
				if (self.detailItem.barriersToBusiness.allObjects.count == 0) {
					BarrierToBusiness *barrier = [BarrierToBusiness createEntity];
					[self.detailItem addBarriersToBusinessObject:barrier];
					[self.managedObjectContext save];
				}
				 */
				rows = self.detailItem.barriersToBusiness.allObjects.count + 1;
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
            [self disableTextField:customCell.producerNameTextField :NO];
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"MM-dd-yyyy"];
			customCell.reportDateTextField.text = [formatter stringFromDate:self.detailItem.reportDate];
			customCell.callTypeTextField.text = self.detailItem.purposeOfCall.name;
            [self disableTextField:customCell.callTypeTextField :NO];
            customCell.reasonNotSeenTextField.text = self.detailItem.reasonNotSeen.name;
			
			customCell.producerNameTextField.delegate = self;
			customCell.reportDateTextField.delegate = self;
			customCell.callTypeTextField.delegate = self;
			
			[customCell.reportDateButton addTarget:self action:@selector(showDatePickerView:) forControlEvents:UIControlEventTouchUpInside];
            [customCell.reasonNotSeen addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
        case PRPTableSectionSpokeWith: {
			if (indexPath.row == self.detailItem.personsSpokeWith.allObjects.count) {
				/*PRPSmartTableViewCell *customCell = [PRPSmartTableViewCell cellForTableView:tableView];
				customCell.textLabel.text = @"Add a Person";
				customCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                 
                 */
                
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Person";
                
                
                UIButton *button = customCell.addButton;
                button.tag = 1003;
                
                [button addTarget:self action:@selector(AddPerson:) forControlEvents:UIControlEventTouchUpInside];
                
             //   UIButton *remBtn = customCell.editButton;
                
             //   remBtn.hidden = TRUE;
             //   customCell.delRowType.hidden = TRUE;
                
                    [button setEnabled:_isPersonEdited?FALSE:TRUE];
                 
                 customCell.delRowType.text = @"Delete Person";
                 UIButton *remBtn = customCell.editButton;
                 [remBtn setTitle:_isPersonEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                 [remBtn setEnabled:_isPersonEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
                 remBtn.tag = 1004;
                 
                 [remBtn addTarget:self action:@selector(AddPerson:) forControlEvents:UIControlEventTouchUpInside];
                
				cell = customCell;
			} else {
				SummarySpokeWithTableViewCell *customCell = [SummarySpokeWithTableViewCell cellForTableView:tableView fromNib:self.summarySpokeWithTableViewCellNib];
				
				PersonSpokeWith *person = (PersonSpokeWith *)[self.detailItem.personsSpokeWith.allObjects objectAtIndex:indexPath.row];
				
				customCell.firstNameTextField.text = [person firstName];
				customCell.lastNameTextField.text = [person lastName];
				customCell.titleTextField.text = [person.title name];
				customCell.emailAddressTextField.text = [person email];
				
				customCell.firstNameTextField.delegate = self;
				customCell.lastNameTextField.delegate = self;
				customCell.titleTextField.delegate = self;
				customCell.emailAddressTextField.delegate = self;
				
				[customCell.titleButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionCompetitor: {
			if (indexPath.row == self.detailItem.competitors.allObjects.count) {
				/*PRPSmartTableViewCell *customCell = [PRPSmartTableViewCell cellForTableView:tableView];
				customCell.textLabel.text = @"Add a Competitor";
				customCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                 */
				
				//cell = customCell;
                
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Competitor";
                
                
                UIButton *button = customCell.addButton;
                button.tag = 1001;
                
                [button addTarget:self action:@selector(AddCompetitor:) forControlEvents:UIControlEventTouchUpInside];
                
           
                
                [button setEnabled:_isCompetetorEdited?FALSE:TRUE];
                
                customCell.delRowType.text = @"Delete Competitor";
                UIButton *remBtn = customCell.editButton;
               [remBtn setTitle:_isCompetetorEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                [remBtn setEnabled:_isCompetetorEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
                remBtn.tag = 1002;
                
                [remBtn addTarget:self action:@selector(AddCompetitor:) forControlEvents:UIControlEventTouchUpInside];
             
                cell = customCell;

			} else {
				SummaryCompetitorTableViewCell *customCell = [SummaryCompetitorTableViewCell cellForTableView:tableView fromNib:self.summaryCompetitorTableViewCellNib];
				
				Competitor *competitor = (Competitor *)[self.detailItem.competitors.allObjects objectAtIndex:indexPath.row];
				
				customCell.competitorNameTextField.text = competitor.name;
				customCell.appsPerMonthTextField.text = competitor.appsPerMonth.stringValue;
				customCell.commissionStructureTextField.text = self.detailItem.commissionStructure.name;
				customCell.percentNewTextField.text = self.detailItem.commissionPercentNew.stringValue;
				customCell.percentRenewalTextField.text = self.detailItem.commissionPercentRenewal.stringValue;
				
				customCell.competitorNameTextField.delegate = self;
				customCell.appsPerMonthTextField.delegate = self;
				customCell.commissionStructureTextField.delegate = self;
				customCell.percentNewTextField.delegate = self;
				customCell.percentRenewalTextField.delegate = self;
				
				[customCell.competitorNameButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
				[customCell.commissionStructureButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionBarriersToBusiness: {
			if (indexPath.row == self.detailItem.barriersToBusiness.allObjects.count) {
				/*PRPSmartTableViewCell *customCell = [PRPSmartTableViewCell cellForTableView:tableView];
				customCell.textLabel.text = @"Add a Barrier to Business";
				customCell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;*/
                
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Barrier";
                
                
                UIButton *button = customCell.addButton;
                button.tag = 1005;
                
                [button addTarget:self action:@selector(AddBarrier:) forControlEvents:UIControlEventTouchUpInside];
                
              //  UIButton *remBtn = customCell.editButton;
                
              //  remBtn.hidden = TRUE;
              //  customCell.delRowType.hidden = TRUE;
                
                
                [button setEnabled:_isBarrierEdited?FALSE:TRUE];
                
                customCell.delRowType.text = @"Delete Barrier";
                UIButton *remBtn = customCell.editButton;
                [remBtn setTitle:_isBarrierEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                [remBtn setEnabled:_isBarrierEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
                remBtn.tag = 1006;
                
                [remBtn addTarget:self action:@selector(AddBarrier:) forControlEvents:UIControlEventTouchUpInside];


				
				cell = customCell;
			} else {
				SummaryBarriersToBusinessTableViewCell *customCell = [SummaryBarriersToBusinessTableViewCell cellForTableView:tableView fromNib:self.summaryBarriersToBusinessTableViewCellNib];
				
				BarrierToBusiness *barrier = (BarrierToBusiness *)[self.detailItem.barriersToBusiness.allObjects objectAtIndex:indexPath.row];
				
				customCell.barrierToBusinessTextField.text = barrier.name;
				
				customCell.barrierToBusinessTextField.delegate = self;
				
				[customCell.barrierToBusinessButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionStats: {
			SummaryStatsTableViewCell *customCell = [SummaryStatsTableViewCell cellForTableView:tableView fromNib:self.summaryStatsTableViewCellNib];
			
			customCell.totalAppsPerMonthTextField.text = self.detailItem.nsbsTotAppsPerMonth.stringValue;
			customCell.percentLiabTextField.text = self.detailItem.nsbsPercentLiab.stringValue;
			customCell.producerAddOnTextField.text = self.detailItem.producerAddOn.name;
			//customCell.rdFollowUpTextField.text = self.detailItem.rdFollowUp.stringValue;
			customCell.monthlyGoalTextField.text = self.detailItem.nsbsMonthlyGoal.stringValue;
			customCell.percentFDLTextField.text = self.detailItem.nsbsFdl.stringValue;
			
			customCell.totalAppsPerMonthTextField.delegate = self;
			customCell.percentLiabTextField.delegate = self;
			customCell.producerAddOnTextField.delegate = self;
			customCell.rdFollowUpTextField.delegate = self;
			customCell.monthlyGoalTextField.delegate = self;
			customCell.percentFDLTextField.delegate = self;
          //  customCell.rdFollowUpTextField.delegate = self;
			
		//	[customCell.rdFollowUpButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
            
            if(_detailItem.rdFollowUpValue)
                customCell.rdFollowUpSwitch.on = YES;
            else
                customCell.rdFollowUpSwitch.on = NO;
            
            [customCell.rdFollowUpSwitch addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventTouchUpInside];
                
			[customCell.producerAddOnButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
			
			cell = customCell;
		}
			break;
        default:
            NSLog(@"Unexpected section (%d)", indexPath.section);
            break;
    }
	
	return cell;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(-15, 0, tableView.bounds.size.width+30, 25)];
    
    UIImageView* headerBg = [[UIImageView alloc] initWithFrame:headerView.frame];
    UIImage* hImg = [UIImage imageNamed:@"MenuButton.png"];
    headerBg.image = hImg;
    
    
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

    UILabel* headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, tableView.bounds.size.width-5, 20)];
    headerTitle.text = theTitle;
    headerTitle.font= [UIFont fontWithName:@"TrebuchetMS-Bold" size:16.0];
    headerTitle.textColor = [UIColor whiteColor];
    headerTitle.backgroundColor = [UIColor clearColor];
    [headerView addSubview:headerBg];
    [headerView addSubview:headerTitle];
    
    return headerView;
}
-(void) AddCompetitor:(id) sender
{
    UIButton* btn = (UIButton*) sender;
    
    if(btn.tag == 1001)
    {
     /*   Competitor* newCompetitor = [Competitor findFirst];
        [self.detailItem addCompetitorsObject:newCompetitor];
        [self.tableView reloadData];*/
        
         [self showSelectionTableView:btn];
    }
    else if(btn.tag == 1002)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
            [btn setTitle:@"Done" forState:UIControlStateNormal];
            self.isCompetetorEdited = TRUE;
            
            
            //   cell.addButton.enabled = FALSE;
            
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isCompetetorEdited = FALSE;
            
            
            // cell.addButton.enabled = TRUE;
        }
        //[super setEditing:editing animated:YES];
        currentSection = PRPTableSectionCompetitor;
        [self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}


-(void) AddPerson:(id) sender
{
    UIButton* btn = (UIButton*) sender;
    
    if(btn.tag == 1003)
    {
        PersonSpokeWith *person = [PersonSpokeWith createEntity];
        [self.detailItem addPersonsSpokeWithObject:person];
        [self.managedObjectContext save];
        [self.tableView reloadData];
    }
    else if(btn.tag == 1004)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
            [btn setTitle:@"Done" forState:UIControlStateNormal];
            self.isPersonEdited = TRUE;
            
            
            //   cell.addButton.enabled = FALSE;
            
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isPersonEdited = FALSE;
            
            
            // cell.addButton.enabled = TRUE;
        }
      //  [super setEditing:editing animated:YES];
         currentSection = PRPTableSectionSpokeWith;
        [self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}
-(void) AddBarrier:(id) sender
{
    UIButton* btn = (UIButton*) sender;
    
    if(btn.tag == 1005)
    {
      /*  BarrierToBusiness *barrier = [BarrierToBusiness findFirst];
        [self.detailItem addBarriersToBusinessObject:barrier];
        [self.managedObjectContext save];
        [self.tableView reloadData];*/
        
        [self showSelectionTableView:btn];
        
    }
    else if(btn.tag == 1006)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
            [btn setTitle:@"Done" forState:UIControlStateNormal];
            self.isBarrierEdited = TRUE;
            
            
            //   cell.addButton.enabled = FALSE;
            
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isBarrierEdited = FALSE;
            
            
            // cell.addButton.enabled = TRUE;
        }
         currentSection = PRPTableSectionBarriersToBusiness;
        //[super setEditing:editing animated:YES];
         [self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*switch (indexPath.section) {
        case PRPTableSectionSpokeWith:
			if (indexPath.row == self.detailItem.personsSpokeWith.allObjects.count) {
				PersonSpokeWith *person = [PersonSpokeWith createEntity];
				[self.detailItem addPersonsSpokeWithObject:person];
				[self.managedObjectContext save];
				[self.tableView reloadData];
			}
			break;
     
		case PRPTableSectionCompetitor:
			if (indexPath.row == self.detailItem.competitors.allObjects.count) {
				Competitor *competitor = [Competitor createEntity];
				[self.detailItem addCompetitorsObject:competitor];
				[self.managedObjectContext save];
				[self.tableView reloadData];
			}
			break;
     
		case PRPTableSectionBarriersToBusiness:
			if (indexPath.row == self.detailItem.barriersToBusiness.allObjects.count) {
				BarrierToBusiness *barrier = [BarrierToBusiness createEntity];
				[self.detailItem addBarriersToBusinessObject:barrier];
				[self.managedObjectContext save];
				[self.tableView reloadData];
			}
			break;
        default:
            break;
    }
	[self.tableView deselectRowAtIndexPath:indexPath animated:NO];*/
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
            height = 110.0;
			break;
        case PRPTableSectionSpokeWith:
			if (indexPath.row == self.detailItem.personsSpokeWith.allObjects.count) {
				height = 44.0;
			} else {
				height = 110.0;
			}
			break;
		case PRPTableSectionCompetitor:
			if (indexPath.row == self.detailItem.competitors.allObjects.count) {
				height = 44.0;
			} else {
				height = 149.0;
			}
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
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}*/

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(currentSection)
    {
        case PRPTableSectionSpokeWith:
        {
            if(indexPath.section == PRPTableSectionSpokeWith && indexPath.row < _detailItem.personsSpokeWith.allObjects.count)
                return YES;
            else
                return  NO;
        }
        case PRPTableSectionCompetitor:
        {
            if(indexPath.section == PRPTableSectionCompetitor && indexPath.row < _detailItem.competitors.allObjects.count)
                return YES;
            else
                return  NO;
        }
        case PRPTableSectionBarriersToBusiness:
        {
            if(indexPath.section == PRPTableSectionBarriersToBusiness && indexPath.row < _detailItem.barriersToBusiness.allObjects.count)
                return YES;
            else
                return  NO;
        }
        default:
            return NO;
            
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if(currentSection == PRPTableSectionCompetitor)
        {
        // Delete the row from the data source
        
        if(indexPath.section == PRPTableSectionCompetitor && indexPath.row < _detailItem.competitors.allObjects.count)
        {
            NSArray* arr = _detailItem.competitors.allObjects;
            
            Competitor* cToDel = [arr objectAtIndex:indexPath.row];
            
            [self.detailItem removeCompetitorsObject:cToDel];
            //[cToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
            //  UITableViewCellEditingStyleNone
            // [self.tableView set]
            [self.tableView reloadData];
            
        }
        }
        else if(currentSection == PRPTableSectionSpokeWith)
        {
            NSArray *arr = _detailItem.personsSpokeWith.allObjects;
            
            PersonSpokeWith *pToDel = [arr objectAtIndex:indexPath.row];
            
            [pToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
            //  UITableViewCellEditingStyleNone
            // [self.tableView set]
            [self.tableView reloadData];
            
        }
        else if(currentSection == PRPTableSectionBarriersToBusiness)
        {
            NSArray *arr = _detailItem.barriersToBusiness.allObjects;
            BarrierToBusiness* bToDel = [arr objectAtIndex:indexPath.row];
            [self.detailItem removeBarriersToBusinessObject:bToDel];
            //[bToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
            //  UITableViewCellEditingStyleNone
            // [self.tableView set]
            [self.tableView reloadData];
            
        }
        
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *replacementString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
	
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
             break;
        case PRPTableSectionSpokeWith: {
		
            switch (tag) {
                case PRPTableSpokeWithEmail:
                {
                    if([replacementString isValidEmail])
                    {
                       
                        [self changeTextFieldOutline:textField:YES];
                    }
                    else
                    {
                        [self changeTextFieldOutline:textField:NO];
                    }
                }
				default:
					break;
			}
		}
			break;
        default:
            break;
    }
	[self.managedObjectContext save];
    
    [self toggleSubmitButton:[self isEnableSubmit]];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  //  if([textField.text length]<=0)
   //     return;
	DailySummary *summary = self.detailItem;
	if (!summary.editedValue) {
		summary.editedValue = YES;
		[self.managedObjectContext save];
	}
	
	NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
	
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
            switch (tag) {
				case PRPTableGeneralProducerName:
					self.detailItem.producerId.name = textField.text;
					break;
				default:
					break;
			}
			break;
        case PRPTableSectionSpokeWith: {
			PersonSpokeWith *person = [self.detailItem.personsSpokeWith.allObjects objectAtIndex:indexPath.row];
            switch (tag) {
				case PRPTableSpokeWithFirstName:
					person.firstName = textField.text;
					break;
				case PRPTableSpokeWithLastName:
					person.lastName = textField.text;
                    break;
				case PRPTableSpokeWithEmail:
                {
                    if([textField.text isValidEmail])
                    {
                        person.email = textField.text;
                        [self changeTextFieldOutline:textField:YES];
                    }
                    else
                    {
                        [self showAlert:VALID_EMAIL_ALERT];
                        [self changeTextFieldOutline:textField:NO];
                    }
                    
                }
				default:
					break;
			}
		}
			break;
		case PRPTableSectionCompetitor: {
			Competitor *competitor = [self.detailItem.competitors.allObjects objectAtIndex:indexPath.row];
			switch (tag) {
				case PRPTableCompetitorAppsPerMonth:
					competitor.appsPerMonthValue = [textField.text integerValue];
					break;
				case PRPTableCompetitorPercentNew:
					self.detailItem.commissionPercentNewValue = [textField.text integerValue];
					break;
				case PRPTableCompetitorPercentRenewal:
					self.detailItem.commissionPercentRenewalValue = [textField.text integerValue];
					break;
				default:
					break;
			}
		}
			break;
		case PRPTableSectionBarriersToBusiness:
			
			break;
		case PRPTableSectionStats:
			switch (tag) {
				case PRPTableStatsTotalAppsPerMonth:
					self.detailItem.nsbsTotAppsPerMonthValue = [textField.text integerValue];
					break;
				case PRPTableStatsMonthlyGoal:
					self.detailItem.nsbsMonthlyGoalValue = [textField.text integerValue];
					break;
				case PRPTableStatsPercentLiab:
					self.detailItem.nsbsPercentLiabValue = [textField.text integerValue];
					break;
				case PRPTableStatsPercentFDL:
					self.detailItem.nsbsFdlValue = [textField.text integerValue];
					break;
				case PRPTableStatsProducerAddOn: {
					self.detailItem.producerAddOn = [ProducerAddOn findFirstByAttribute:@"name" withValue:textField.text];
				}
					break;
				case PRPTableStatsRDFollowUp:
					self.detailItem.rdFollowUpValue = [textField.text integerValue];
					break;
				default:
					break;
			}
			break;
        default:
            NSLog(@"Unexpected section (%d)", indexPath.section);
            break;
    }
	[self.managedObjectContext save];
    
    [self toggleSubmitButton:[self isEnableSubmit]];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{	
	[self nextField:0];
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
    [textField resignFirstResponder];
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
					rows = [[PersonSpokeWithTitle numberOfEntities] integerValue];
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
					person.title = [PersonSpokeWithTitle findFirstByAttribute:@"name" withValue:titleForRow];
				}
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (self.pickerViewController.currentTag) {
				case PRPTableCompetitorName: {
					Competitor *competitor = [self.detailItem.competitors.allObjects objectAtIndex:indexPath.row];//[Competitor findFirstByAttribute:@"name" withValue:titleForRow];
                    competitor.name = titleForRow;//[Competitor findFirstByAttribute:@"name" withValue:<#(id)#>]
					//[self.detailItem.competitorsSet.allObjects removeObjectAtIndex:indexPath.row];
					
				}
					break;
				case PRPTableCompetitorCommissionStructure: {
					CommissionStructure *structure = [CommissionStructure findFirstByAttribute:@"name" withValue:titleForRow];
					self.detailItem.commissionStructure = structure;
				}
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionBarriersToBusiness:
			switch (self.pickerViewController.currentTag) {
				case PRPTableBarrierName: {
					// Change value in model object
					BarrierToBusiness *barrier = [self.detailItem.barriersToBusiness.allObjects objectAtIndex:indexPath.row];//[BarrierToBusiness findFirstByAttribute:@"name" withValue:titleForRow];
                    barrier.name = titleForRow;
					[self.detailItem addBarriersToBusinessObject:barrier];
				}
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionStats:
			switch (self.pickerViewController.currentTag) {
				case PRPTableStatsProducerAddOn:
					self.detailItem.producerAddOn = [ProducerAddOn findFirstByAttribute:@"name" withValue:titleForRow];
					break;
				case PRPTableStatsRDFollowUp:
					self.detailItem.rdFollowUpValue = [titleForRow integerValue];
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	[self.managedObjectContext save];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    [self toggleSubmitButton:[self isEnableSubmit]];
	//[self.tableView reloadData];
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
					theTitle = [[[PersonSpokeWithTitle findAll] objectAtIndex:row] name];
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (self.pickerViewController.currentTag) {
				case PRPTableCompetitorName:
					theTitle = [[[Competitor findAllSortedBy:@"name" ascending:YES] objectAtIndex:row] name];
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
			switch (controller.currentTag) {
				case PRPTableGeneralReportDate:
					[formatter setDateFormat:@"MM-dd-yyyy"];
					self.detailItem.reportDate = toDate;
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	[[NSManagedObjectContext defaultContext] save];
	//[self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:controller.currentIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    [self toggleSubmitButton:[self isEnableSubmit]];
}

- (void)nextField:(NSInteger)currentTag
{	
	
	if (self.pickerViewController.view.superview != nil) {
		self.pickerViewController.currentIndexPath = nil;
		self.pickerViewController.currentTag = 0;
		//Position the picker out of sight
		[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		//This animation will work on iOS 4
		//For older iOS, use "beginAnimation:context"
		[UIView animateWithDuration:0.2 animations:^{[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME];} completion:^(BOOL finished){
			[[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
			[self.pickerViewController.view removeFromSuperview];}];
	} else if (self.datePickerViewController.view.superview != nil) {
		self.datePickerViewController.currentIndexPath = nil;
		self.datePickerViewController.currentTag = 0;
		//Position the picker out of sight
		[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		//This animation will work on iOS 4
		//For older iOS, use "beginAnimation:context"
		[UIView animateWithDuration:0.2 animations:^{[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];} completion:^(BOOL finished){
			[[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
			[self.datePickerViewController.view removeFromSuperview];}];
	}
}

- (void)previousField:(NSInteger)currentTag
{
	
}
-(BOOL) isEnableSubmit
{
    if(_detailItem.reasonNotSeen)
    {
        if(![_detailItem.reasonNotSeen.name isEqualToString:@" "])
            return TRUE;
    }
    
    if(!_detailItem.editedValue)
        return FALSE;
    
    for(int section =0; section < PRPTableNumSections; section++)
    {
        switch(section)
        {
            case PRPTableSectionGeneral:
            {
                if(/*_detailItem.purposeOfCall == nil ||*/
                   _detailItem.reportDate == nil)
                    return  FALSE;
            }
                break;
            case PRPTableSectionSpokeWith:
            {
                if([_detailItem.personsSpokeWith.allObjects count]<=0)
                    return FALSE;
                
                for(PersonSpokeWith *pSpokeWith in _detailItem.personsSpokeWith.allObjects)
                {
                    if([pSpokeWith.firstName length]<= 0 ||
                       [pSpokeWith.lastName length]<=0 ||
                       pSpokeWith.title == nil ||
                       [pSpokeWith.email length]<=0)
                        return FALSE;
                }
            }
                break;
            case PRPTableSectionStats:
            {
                if(_detailItem.producerAddOn == nil||
                   _detailItem.nsbsFdl == nil ||
                   _detailItem.nsbsMonthlyGoal == nil ||
                   _detailItem.nsbsPercentLiab == nil ||
                   _detailItem.rdFollowUp == nil ||
                   _detailItem.nsbsTotAppsPerMonth == nil
                   )
                    return FALSE;
            }
                break;
            case PRPTableSectionCompetitor:
            {
                if([_detailItem.competitors.allObjects count]<=0)
                    return FALSE;
                
                for(Competitor *comptr in _detailItem.competitors.allObjects)
                {
                    if([comptr.name length]<=0 ||
                       comptr.appsPerMonth == nil ||
                       _detailItem.commissionStructure == nil ||
                       [_detailItem.commissionStructure.name  length]<=0 ||
                       _detailItem.commissionPercentNew == nil ||
                       _detailItem.commissionPercentRenewal == nil
                       )
                        return FALSE;
                }
            }
                break;
            case PRPTableSectionBarriersToBusiness:
            {
                if([_detailItem.barriersToBusiness.allObjects count]<=0)
                    return FALSE;
                
                for(BarrierToBusiness *bBusiness in _detailItem.barriersToBusiness.allObjects)
                {
                    if([bBusiness.name length]<=0)
                        return FALSE;
                }
            }
                break;
        }
    }
    
    return TRUE;
}

-(void) selectedOption:(NSString*) selectedString:(NSIndexPath*) forIndexPath:(NSInteger) forTag
{

    
    switch (forIndexPath.section) {
		case PRPTableSectionGeneral:
			switch (forTag) {
				case PRPTableGeneralCallType:
					// Change value in model object
					self.detailItem.purposeOfCall = [PurposeOfCall findFirstByAttribute:@"name" withValue:selectedString];
					break;
                case PRPTableGeneralReasonNotSeen:
                {
                    self.detailItem.reasonNotSeen = [ReasonNotSeen findFirstByAttribute:@"name" withValue:selectedString];
                    break;
                }
				default:
					break;
			}
			break;
		case PRPTableSectionSpokeWith:
			switch (forTag) {
				case PRPTableSpokeWithTitle: {
					// Change value in model object
					PersonSpokeWith *person = [self.detailItem.personsSpokeWith.allObjects objectAtIndex:forIndexPath.row];
					person.title = [PersonSpokeWithTitle findFirstByAttribute:@"name" withValue:selectedString];
				}
					break;
				default:
					break;
			}
			break;
		case PRPTableSectionCompetitor:
			switch (forTag) {
				case PRPTableCompetitorName: {
			//		Competitor *competitor = [self.detailItem.competitors.allObjects objectAtIndex:forIndexPath.row];//[Competitor findFirstByAttribute:@"name" withValue:titleForRow];
               //     competitor.name = selectedString;//[Competitor findFirstByAttribute:@"name" withValue:<#(id)#>]
					//[self.detailItem.competitorsSet.allObjects removeObjectAtIndex:indexPath.row];
                    
                    Competitor *competitor = [Competitor findFirstByAttribute:@"name" withValue:selectedString];
                    [self.detailItem addCompetitorsObject:competitor];

					
				}
					break;
				case PRPTableCompetitorCommissionStructure: {
					CommissionStructure *structure = [CommissionStructure findFirstByAttribute:@"name" withValue:selectedString];
					self.detailItem.commissionStructure = structure;
				}
					break;
                case 1001:
                {
                    Competitor *competitor = [Competitor findFirstByAttribute:@"name" withValue:selectedString];
                    [self.detailItem addCompetitorsObject:competitor];
                    break;
                }
				default:
					break;
			}
			break;
		case PRPTableSectionBarriersToBusiness:
			switch (forTag) {
				case PRPTableBarrierName: {
					// Change value in model object
					BarrierToBusiness *barrier = [BarrierToBusiness findFirstByAttribute:@"name" withValue:selectedString];//[self.detailItem.barriersToBusiness.allObjects objectAtIndex:forIndexPath.row];//[BarrierToBusiness findFirstByAttribute:@"name" withValue:titleForRow];
                   // barrier.name = selectedString;
					[self.detailItem addBarriersToBusinessObject:barrier];
				}
					break;
                case 1005:
                {
                    BarrierToBusiness *barrier = [BarrierToBusiness findFirstByAttribute:@"name" withValue:selectedString];
                    [self.detailItem addBarriersToBusinessObject:barrier];
                    break;
                }
				default:
					break;
			}
			break;
		case PRPTableSectionStats:
			switch (forTag) {
				case PRPTableStatsProducerAddOn:
					self.detailItem.producerAddOn = [ProducerAddOn findFirstByAttribute:@"name" withValue:selectedString];
					break;
				case PRPTableStatsRDFollowUp:
					self.detailItem.rdFollowUpValue = [selectedString integerValue];
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
    
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:forIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    
      [self toggleSubmitButton:[self isEnableSubmit]];

}
@end
