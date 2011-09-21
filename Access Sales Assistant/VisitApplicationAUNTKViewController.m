//
//  VisitApplicationAUNTKViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationAUNTKViewController.h"
#import "HTTPOperationController.h"
#import "AUNTKProductionTableViewCell.h"
#import "AUNTKLossRatioTableViewCell1.h"
#import "AUNTKLossRatioTableViewCell2.h"

@implementation VisitApplicationAUNTKViewController

@synthesize detailItem=_detailItem;
@synthesize auntk=_auntk;
@synthesize productionData=_productionData;
@synthesize lossRatioData=_lossRatioData;
@synthesize productionTableView=_productionTableView;
@synthesize lossRatioTableView1 = _lossRatioTableView;
@synthesize dismissButton=_dismissButton;
@synthesize aPopoverController=_aPopoverController;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize lossRatioTableView2 = _lossRatioTableView2;
@synthesize productionTableViewCellNib=_productionTableViewCellNib;
@synthesize lossRatioTableViewCell1Nib=_lossRatioTableViewCell1Nib;
@synthesize lossRatioTableViewCell2Nib=_lossRatioTableViewCell2Nib;
@synthesize scrollView = _scrollView;
@synthesize titleLabel = _titleLabel;
@synthesize titleText;

#pragma mark -
#pragma mark Detail item

- (void)setDetailItem:(Producer *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:@"AUNTK" object:nil];
        
        // Update the view.
        [self configureView];
    }
	
	if (self.aPopoverController != nil) {
        [self.aPopoverController dismissPopoverAnimated:YES];
    }
    
    titleText = [[NSString alloc]initWithFormat:@"%@ - %@",newDetailItem.name,newDetailItem.producerCode];
}

- (void)setAuntk:(AUNTK *)auntk
{
    if (_auntk != auntk) {
        _auntk = auntk;
		NSSortDescriptor *headerSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
		NSArray *headerSortDescriptors = [NSArray arrayWithObjects:headerSortDescriptor, nil];
		self.productionData = [_auntk.policyCountReportData.allObjects sortedArrayUsingDescriptors:headerSortDescriptors];
		
		NSSortDescriptor *yearSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"monthEndDate" ascending:YES];
		NSArray *monthYearSortDescriptors = [NSArray arrayWithObjects:yearSortDescriptor, nil];
		self.lossRatioData = [_auntk.productionReportData.allObjects sortedArrayUsingDescriptors:monthYearSortDescriptors];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)configureView
{
	[self setAuntk:self.detailItem.auntk];
	// Table Views
	[self.productionTableView reloadData];
	[self.lossRatioTableView1 reloadData];
	[self.lossRatioTableView2 reloadData];
}

#pragma mark -
#pragma mark Accessors

- (UINib *)productionTableViewCellNib
{
	if (_productionTableViewCellNib == nil) {
		self.productionTableViewCellNib = [AUNTKProductionTableViewCell nib];
	}
	return _productionTableViewCellNib;
}

- (UINib *)lossRatioTableViewCell1Nib
{
	if (_lossRatioTableViewCell1Nib == nil) {
		self.lossRatioTableViewCell1Nib = [AUNTKLossRatioTableViewCell1 nib];
	}
	return _lossRatioTableViewCell1Nib;
}

- (UINib *)lossRatioTableViewCell2Nib
{
	if (_lossRatioTableViewCell2Nib == nil) {
		self.lossRatioTableViewCell2Nib = [AUNTKLossRatioTableViewCell2 nib];
	}
	return _lossRatioTableViewCell2Nib;
}

#pragma mark -
#pragma mark Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    // Do any additional setup after loading the view from its nib.
	[self.scrollView setContentSize:CGSizeMake(768, 1004)];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:@"AUNTK" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[[HTTPOperationController sharedHTTPOperationController] getAUNTKsForProducer:self.detailItem.producerCode];
	
	[self configureView];
    
    _titleLabel.text = titleText;
}

- (void)viewDidUnload
{
    [self setProductionTableView:nil];
	[self setLossRatioTableView1:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self setLossRatioTableView2:nil];
	[self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSInteger rows = 0;
	if (tableView == self.productionTableView) {
		rows = self.productionData.count;
	} else if (tableView == self.lossRatioTableView1) {
		rows = self.lossRatioData.count;
	} else if (tableView == self.lossRatioTableView2) {
		rows = self.lossRatioData.count;
	}
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.productionTableView) {
		AUNTKProductionTableViewCell *customCell = [AUNTKProductionTableViewCell cellForTableView:tableView fromNib:self.productionTableViewCellNib];
		PolicyCountReportData *data = (PolicyCountReportData *)[self.productionData objectAtIndex:indexPath.row];
		if ([data.header isEqualToString:@"Current Month"]) {
			customCell.dateLabel.text = [NSString stringWithFormat:@"Total for %@", data.header];
		} else {
			customCell.dateLabel.text = [NSString stringWithFormat:@"Week Ending %@", data.header];
		}
		
		//customCell.valueLabel.text = [[(PolicyCountReportData *)[self.auntk.policyCountReportData.allObjects objectAtIndex:indexPath.row] count] stringValue];
		customCell.valueLabel.text = data.count;
		return customCell;
	} else if (tableView == self.lossRatioTableView1) {
		AUNTKLossRatioTableViewCell1 *customCell = [AUNTKLossRatioTableViewCell1 cellForTableView:tableView fromNib:self.lossRatioTableViewCell1Nib];
		ProductionReportData *data = (ProductionReportData *)[self.lossRatioData objectAtIndex:indexPath.row];
		customCell.yearLabel.text = data.year.stringValue;
		customCell.monthLabel.text = data.month;
		customCell.brandnewPoliciesPerMonthLabel.text = data.currentPoliciesMonth.stringValue;
		customCell.policiesWrittenITDLabel.text = data.policiesWrittenITD.stringValue;
		customCell.policiesInForceLabel.text = data.policiesInForce.stringValue;
		customCell.wpTotalITDLabel.text = data.wpTotalITD.stringValue;
		customCell.averageWpITDLabel.text = data.avgWPITD.stringValue;
		customCell.epTotalITDLabel.text = data.epTotalITD.stringValue;
		customCell.lrTotalITDLabel.text = [NSString stringWithFormat:@"%@ %%", data.lrTotalITD.stringValue];
		return customCell;
	} else if (tableView == self.lossRatioTableView2) {
		AUNTKLossRatioTableViewCell2 *customCell = [AUNTKLossRatioTableViewCell2 cellForTableView:tableView fromNib:self.lossRatioTableViewCell2Nib];
		ProductionReportData *data = (ProductionReportData *)[self.lossRatioData objectAtIndex:indexPath.row];
		customCell.yearLabel.text = data.year.stringValue;
		customCell.monthLabel.text = data.month;
		customCell.percentLiabilityOnlyLabel.text = [NSString stringWithFormat:@"%@ %%", data.percentLiabilityOnlyITD.stringValue];
		customCell.thirtyDayCancelLabel.text = [NSString stringWithFormat:@"%@ %%", data.cancel30dMonth.stringValue];
		customCell.thirtyDayClaimsLabel.text = data.nbrClaims30dMonth.stringValue;
		customCell.numberOfClaimsPerMonthLabel.text = data.nbrClaimsMonth.stringValue;
		customCell.numberOfClaimsITDLabel.text = data.nbrClaimsITD.stringValue;
		customCell.frequencyITDLabel.text = data.frequencyITD.stringValue;
		customCell.averageIncLossLabel.text = data.avgIncLossITD.stringValue;
		customCell.percentFDLLabel.text = [NSString stringWithFormat:@"%@ %%", data.percentFDLMonth.stringValue];
		customCell.averageCarsPerDriverLabel.text = data.avgCarsDriver.stringValue;
		customCell.averageDriverAgeLabel.text = data.avgDriverAge.stringValue;
		return customCell;
	}
	
	return nil;
}

@end
