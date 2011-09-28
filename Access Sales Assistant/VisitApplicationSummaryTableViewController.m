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
#import "PRPSmartTableViewCell.h"
#import "HTTPOperationController.h"
#import "NSString-Validation.h"
#import "ProducerProfileConstants.h"
#import "AddRowTableViewCell.h"
#import "SelectionModelViewController.h"

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
    PRPTableNumSections,
    
};

enum PRPTableGeneralTags {
    PRPTableGeneralProducerName = 1,
    PRPTableGeneralCallType,
	PRPTableGeneralReportDate,
    PRPTableGeneralReasonNotSeen,
    PRPTableCompetitorCommissionStructure,
	PRPTableCompetitorPercentNew,
	PRPTableCompetitorPercentRenewal
	
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

@synthesize datePickerViewController = _datePickerViewController;

@synthesize aPopoverController=_aPopoverController;

@synthesize managedObjectContext=_managedObjectContext;

@synthesize tableView = _tableView;

@synthesize isCompetetorEdited = _isCompetetorEdited;

@synthesize isPersonEdited = _isPersonEdited;

@synthesize isBarrierEdited = _isBarrierEdited;

@synthesize isFormDisabled=_isFormDisabled;

@synthesize submitButton = _submitButton;

@synthesize titleLabel = _titleLabel;

@synthesize titleText;

@synthesize fields=_fields;

#pragma mark -
#pragma mark IBActions

- (void)disableForm
{
	self.isFormDisabled = YES;
	for (UIControl *control in self.fields) {
		if ([control isKindOfClass:[UITextField class]]) {
			UITextField *textField = (UITextField *)control;
			[textField setBackgroundColor:[UIColor lightGrayColor]];
		}
		[control setEnabled:NO];
	}
	[self.tableView reloadData];
}

- (void)enableForm
{
	self.isFormDisabled = NO;
	for (UIControl *control in self.fields) {
		if ([control isKindOfClass:[UITextField class]]) {
			UITextField *textField = (UITextField *)control;
			[textField setBackgroundColor:[UIColor whiteColor]];
		}
		[control setEnabled:YES];
	}
	[self.tableView reloadData];
}

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
					NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[ReasonNotSeen findAllSortedBy:@"name" ascending:YES]];
					NSDictionary *dict = [NSDictionary dictionaryWithObject:@"None" forKey:@"name"];
					[dataSource addObject:dict];
                    [selectionView assignDataSource:dataSource];
					
                    break;
                }
                case PRPTableCompetitorCommissionStructure:
                {
                    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[CommissionStructure findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
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
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[PersonSpokeWithTitle findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
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
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[Competitor findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
                case 1001:
                {
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[Competitor findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
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
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[BarrierToBusiness findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
                case 1005:
                {
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[BarrierToBusiness findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
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
                     NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[ProducerAddOn findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
                case PRPTableStatsRDFollowUp:
                {
                    break;
                }
            }
            break;
        }
            
    }
    
    [self dismissKeyboard];
    [self performSelector:@selector(showViewController:) withObject:selectionView afterDelay:0.0];
    
    
}


- (void)showViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController animated:YES];
}

- (void)dismissKeyboard
{
	[self.fields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

- (IBAction)handleSwitch:(id)sender
{
    self.detailItem.editedValue = YES;
	self.detailItem.producerId.editedValue = YES;
    UICustomSwitch * rdfollowup = (UICustomSwitch*) sender;
    if(rdfollowup.isOn)
        _detailItem.rdFollowUpValue = 1;
    else
        _detailItem.rdFollowUpValue = 0;
    
	[[NSManagedObjectContext defaultContext] save];
	
    [self toggleSubmitButton:[self isEnableSubmit]];
	
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
		producer.dailySummary = dSummary;
	}
    
	
    if (_detailItem != producer.dailySummary) {
        _detailItem = producer.dailySummary;
        
        // Update the view.
        [self configureView];
    }
    
	titleText = [[NSString alloc]initWithFormat:@"%@ - %@",producer.name,producer.producerCode];  
    
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
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.allowsSelection = NO;
    [self toggleSubmitButton:NO];
	self.tableView.backgroundColor = [UIColor clearColor];
	self.fields = [NSMutableSet set];
}

- (void)viewDidUnload
{
    [self setDatePickerViewController:nil];
	[self setTableView:nil];
    [super viewDidUnload];
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
	
	if (self.detailItem.reasonNotSeen) {
		[self disableForm];
	} else {
		[self enableForm];
	}
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
				rows = self.detailItem.personsSpokeWith.allObjects.count + 1;
				break;
			case PRPTableSectionCompetitor:
				rows = self.detailItem.competitors.allObjects.count + 1;
				break;
			case PRPTableSectionBarriersToBusiness:
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
            customCell.commissionStructureTextField.text = self.detailItem.commissionStructure.name;
            customCell.percentNewTextField.text = self.detailItem.commissionPercentNew.stringValue;
            customCell.percentRenewalTextField.text = self.detailItem.commissionPercentRenewal.stringValue;
			
			
			customCell.producerNameTextField.delegate = self;
			customCell.reportDateTextField.delegate = self;
			customCell.callTypeTextField.delegate = self;
            customCell.commissionStructureTextField.delegate = self;
            customCell.percentNewTextField.delegate = self;
            customCell.percentRenewalTextField.delegate = self;
			
			
			[customCell.reportDateButton addTarget:self action:@selector(showDatePickerView:) forControlEvents:UIControlEventTouchUpInside];
            [customCell.reasonNotSeen addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
            [customCell.commissionStructureButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
			
            [self.fields addObject:customCell.percentNewTextField];
            [self.fields addObject:customCell.percentRenewalTextField];
            [self.fields addObject:customCell.commissionStructureTextField];
            [self.fields addObject:customCell.commissionStructureButton];
            
            [self disableTextField:customCell.reportDateTextField :NO];
			[customCell.reportDateButton setEnabled:NO];
            
			customCell.producerNameTextField.enabled = NO;
			customCell.reportDateTextField.enabled = NO;
			customCell.callTypeTextField.enabled = NO;
			customCell.reasonNotSeenTextField.enabled = NO;
			customCell.commissionStructureTextField.enabled = NO;
			
			cell = customCell;
		}
			break;
        case PRPTableSectionSpokeWith: {
			if (indexPath.row == self.detailItem.personsSpokeWith.allObjects.count) {
				
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Person";
                
                UIButton *button = customCell.addButton;
                button.tag = 1003;
                [button addTarget:self action:@selector(AddPerson:) forControlEvents:UIControlEventTouchUpInside];
				customCell.delRowType.text = @"Delete Person";
				UIButton *remBtn = customCell.editButton;
				[remBtn setTitle:_isPersonEdited?@"Done":@"Edit" forState:UIControlStateNormal];
				
				remBtn.tag = 1004;
				[remBtn addTarget:self action:@selector(AddPerson:) forControlEvents:UIControlEventTouchUpInside];
                
				if (self.isFormDisabled) {
					[button setEnabled:NO];
					[remBtn setEnabled:NO];
				} else {
					[button setEnabled:_isPersonEdited?FALSE:TRUE];
					[remBtn setEnabled:_isPersonEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
				}
				
                [self.fields addObject: customCell.addButton];
                [self.fields addObject: customCell.editButton];
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
				
                [self.fields addObject: customCell.firstNameTextField];
                [self.fields addObject: customCell.lastNameTextField];
                [self.fields addObject: customCell.titleTextField];
                [self.fields addObject: customCell.emailAddressTextField];
                [self.fields addObject: customCell.titleButton];
				
				customCell.titleTextField.enabled = NO;
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionCompetitor: {
			if (indexPath.row == self.detailItem.competitors.allObjects.count) {
				
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Competitor";
				
                UIButton *button = customCell.addButton;
                button.tag = 1001;
                [button addTarget:self action:@selector(AddCompetitor:) forControlEvents:UIControlEventTouchUpInside];
                
                customCell.delRowType.text = @"Delete Competitor";
				
                UIButton *remBtn = customCell.editButton;
				[remBtn setTitle:_isCompetetorEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                remBtn.tag = 1002;
                [remBtn addTarget:self action:@selector(AddCompetitor:) forControlEvents:UIControlEventTouchUpInside];
				
				if (self.isFormDisabled) {
					[button setEnabled:NO];
					[remBtn setEnabled:NO];
				} else {
					[button setEnabled:_isCompetetorEdited?FALSE:TRUE];
					[remBtn setEnabled:_isCompetetorEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
				}
				
                [self.fields addObject: customCell.addButton];
                [self.fields addObject: customCell.editButton];
                cell = customCell;
				
			} else {
				SummaryCompetitorTableViewCell *customCell = [SummaryCompetitorTableViewCell cellForTableView:tableView fromNib:self.summaryCompetitorTableViewCellNib];
				
				Competitor *competitor = (Competitor *)[self.detailItem.competitors.allObjects objectAtIndex:indexPath.row];
				
				customCell.competitorNameTextField.text = competitor.name;
				customCell.appsPerMonthTextField.text = competitor.appsPerMonth.stringValue;
				
				customCell.competitorNameTextField.delegate = self;
				customCell.appsPerMonthTextField.delegate = self;
				
				[customCell.competitorNameButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
				
                [self.fields addObject: customCell.competitorNameTextField];
                [self.fields addObject: customCell.appsPerMonthTextField];
                [self.fields addObject: customCell.competitorNameButton];
                
				customCell.competitorNameTextField.enabled = NO;
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionBarriersToBusiness: {
			if (indexPath.row == self.detailItem.barriersToBusiness.allObjects.count) {
				
                AddRowTableViewCell* customCell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                customCell.addRowType.text = @"Add a Barrier";
                
                UIButton *button = customCell.addButton;
                button.tag = 1005;
                [button addTarget:self action:@selector(AddBarrier:) forControlEvents:UIControlEventTouchUpInside];
                
                customCell.delRowType.text = @"Delete Barrier";
                UIButton *remBtn = customCell.editButton;
                [remBtn setTitle:_isBarrierEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                remBtn.tag = 1006;
                
                [remBtn addTarget:self action:@selector(AddBarrier:) forControlEvents:UIControlEventTouchUpInside];
				
				if (self.isFormDisabled) {
					[button setEnabled:NO];
					[remBtn setEnabled:NO];
				} else {
					[button setEnabled:_isBarrierEdited?FALSE:TRUE];
					[remBtn setEnabled:_isBarrierEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
				}
				
                [self.fields addObject: customCell.addButton];
                [self.fields addObject: customCell.editButton];
				
				cell = customCell;
			} else {
				SummaryBarriersToBusinessTableViewCell *customCell = [SummaryBarriersToBusinessTableViewCell cellForTableView:tableView fromNib:self.summaryBarriersToBusinessTableViewCellNib];
				
				BarrierToBusiness *barrier = (BarrierToBusiness *)[self.detailItem.barriersToBusiness.allObjects objectAtIndex:indexPath.row];
				
				customCell.barrierToBusinessTextField.text = barrier.name;
				
				customCell.barrierToBusinessTextField.delegate = self;
				
				[customCell.barrierToBusinessButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
                
                [self.fields addObject: customCell.barrierToBusinessTextField];
                [self.fields addObject: customCell.barrierToBusinessButton];
				
				customCell.barrierToBusinessTextField.enabled = NO;
				
				cell = customCell;
			}
		}
			break;
		case PRPTableSectionStats: {
			SummaryStatsTableViewCell *customCell = [SummaryStatsTableViewCell cellForTableView:tableView fromNib:self.summaryStatsTableViewCellNib];
			
			customCell.totalAppsPerMonthTextField.text = self.detailItem.nsbsTotAppsPerMonth.stringValue;
			customCell.percentLiabTextField.text = self.detailItem.nsbsPercentLiab.stringValue;
			customCell.producerAddOnTextField.text = self.detailItem.producerAddOn.name;
			customCell.monthlyGoalTextField.text = self.detailItem.nsbsMonthlyGoal.stringValue;
			customCell.percentFDLTextField.text = self.detailItem.nsbsFdl.stringValue;
			customCell.totalAppsPerMonthTextField.delegate = self;
			customCell.percentLiabTextField.delegate = self;
			customCell.producerAddOnTextField.delegate = self;
			customCell.monthlyGoalTextField.delegate = self;
			customCell.percentFDLTextField.delegate = self;
            if(_detailItem.rdFollowUpValue)
                customCell.rdFollowUpCustomSwitch.on = YES;
            else
                customCell.rdFollowUpCustomSwitch.on = NO;
            
            [customCell.rdFollowUpCustomSwitch addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventTouchUpInside];
			
			[customCell.producerAddOnButton addTarget:self action:@selector(showSelectionTableView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.fields addObject: customCell.totalAppsPerMonthTextField];
            [self.fields addObject: customCell.percentLiabTextField];
            [self.fields addObject: customCell.producerAddOnTextField];
            [self.fields addObject: customCell.monthlyGoalTextField];
            [self.fields addObject: customCell.percentFDLTextField];
            [self.fields addObject: customCell.rdFollowUpCustomSwitch];
            [self.fields addObject: customCell.producerAddOnButton];
			
			customCell.producerAddOnTextField.enabled = NO;
			
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
		[self showSelectionTableView:btn];
    }
    else if(btn.tag == 1002)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
            [btn setTitle:@"Done" forState:UIControlStateNormal];
            self.isCompetetorEdited = TRUE;
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isCompetetorEdited = FALSE;
        }
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
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isPersonEdited = FALSE;
        }
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
        [self showSelectionTableView:btn];
        
    }
    else if(btn.tag == 1006)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
            [btn setTitle:@"Done" forState:UIControlStateNormal];
            self.isBarrierEdited = TRUE;
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            self.isBarrierEdited = FALSE;
        }
		currentSection = PRPTableSectionBarriersToBusiness;
		[self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
            height = 191.0;
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
				height = 72.0;
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
				[[NSManagedObjectContext defaultContext] save];
				[self.tableView reloadData];
				
			}
        }
        else if(currentSection == PRPTableSectionSpokeWith)
        {
            NSArray *arr = _detailItem.personsSpokeWith.allObjects;
            
            PersonSpokeWith *pToDel = [arr objectAtIndex:indexPath.row];
            
            [pToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
            [self.tableView reloadData];
            
        }
        else if(currentSection == PRPTableSectionBarriersToBusiness)
        {
            NSArray *arr = _detailItem.barriersToBusiness.allObjects;
            BarrierToBusiness* bToDel = [arr objectAtIndex:indexPath.row];
            [self.detailItem removeBarriersToBusinessObject:bToDel];
            [[NSManagedObjectContext defaultContext] save];
            [self.tableView reloadData];
        }
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
	self.detailItem.editedValue = YES;
	self.detailItem.producerId.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	
	NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
	
	switch (indexPath.section) {
        case PRPTableSectionGeneral:
            switch (tag) {
				case PRPTableGeneralProducerName:
					self.detailItem.producerId.name = textField.text;
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
#pragma mark DatePickerViewControllerDelegate

- (void)datePickerViewController:(DatePickerViewController *)controller didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	self.detailItem.editedValue = YES;
	self.detailItem.producerId.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	
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
	
    if (self.datePickerViewController.view.superview != nil) {
		self.datePickerViewController.currentIndexPath = nil;
		self.datePickerViewController.currentTag = 0;
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
	if (_detailItem.reportDate == nil) {
		return NO;
	}
    if(_detailItem.reasonNotSeen)
    {
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
                if(_detailItem.reportDate == nil||
                   _detailItem.commissionStructure == nil ||
                   [_detailItem.commissionStructure.name  length]<=0 ||
                   _detailItem.commissionPercentNew == nil ||
                   _detailItem.commissionPercentRenewal == nil)
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
                       comptr.appsPerMonth == nil
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

-(void) selectedOption:(NSString*)selectedString didSelectRowAtIndexPath:(NSIndexPath*)forIndexPath forTag:(NSInteger) forTag
{
	self.detailItem.editedValue = YES;
	self.detailItem.producerId.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	
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
					if (self.detailItem.reasonNotSeen) {
						[self disableForm];
					} else {
						[self enableForm];
					}
                    break;
                }
                case PRPTableCompetitorCommissionStructure: {
					CommissionStructure *structure = [CommissionStructure findFirstByAttribute:@"name" withValue:selectedString];
					self.detailItem.commissionStructure = structure;
				}
					break;
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
                    Competitor *competitor = [Competitor findFirstByAttribute:@"name" withValue:selectedString];
                    [self.detailItem addCompetitorsObject:competitor];
					
					
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
					BarrierToBusiness *barrier = [BarrierToBusiness findFirstByAttribute:@"name" withValue:selectedString];
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
