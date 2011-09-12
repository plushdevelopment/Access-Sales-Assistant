//
//  VisitApplicationAUNTKViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationAUNTKViewController.h"

#import "DailySummary.h"

#import "Producer.h"

#import "AUNTK.h"

#import "HTTPOperationController.h"

#import "LossRatioTrendReportData.h"

#import "AUNTKProductionTableViewCell.h"

#import "AUNTKLossRatioTableViewCell1.h"

#import "AUNTKLossRatioTableViewCell2.h"

#import "PolicyCountReportData.h"

#import "ProductionReportData.h"

#import "LossRatioTrendReportData.h"

#import "ClaimFrequecyTrendReportData.h"

@implementation VisitApplicationAUNTKViewController

@synthesize detailItem=_detailItem;
@synthesize auntk=_auntk;
@synthesize productionTableView=_productionTableView;
@synthesize lossRatioTableView1 = _lossRatioTableView;
@synthesize lossRatioLineChartView = _lossRatioLineChartView;
@synthesize lossRatioTrendLabel = _lossRatioTrendLabel;
@synthesize claimFrequencyLineChartView = _claimFrequencyLineChartView;
@synthesize claimFrequencyTrendLabel = _claimFrequencyTrendLabel;
@synthesize dismissButton=_dismissButton;
@synthesize aPopoverController=_aPopoverController;
@synthesize managedObjectContext=_managedObjectContext;
@synthesize lossRatioTableView2 = _lossRatioTableView2;
@synthesize productionTableViewCellNib=_productionTableViewCellNib;
@synthesize lossRatioTableViewCell1Nib=_lossRatioTableViewCell1Nib;
@synthesize lossRatioTableViewCell2Nib=_lossRatioTableViewCell2Nib;
@synthesize toggleAUNTKButton=_toggleAUNTKButton;
@synthesize scrollView = _scrollView;

#pragma mark -
#pragma mark Detail item

- (void)setDetailItem:(Producer *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:@"AUNTK" object:nil];
        [[HTTPOperationController sharedHTTPOperationController] getAUNTKsForProducer:self.detailItem.producerCode];
        // Update the view.
        [self configureView];
    }
	
	if (self.aPopoverController != nil) {
        [self.aPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)setAuntk:(AUNTK *)auntk
{
    if (_auntk != auntk) {
        _auntk = auntk;
        // Update the view.
        [self configureView];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)toggleAUNTK:(id)sender
{
	if ([self.auntk isEqual:self.detailItem.auntk]) {
		[self setAuntk:self.detailItem.chainAuntk];
		self.toggleAUNTKButton.title = @"Switch to AUNTK";
	} else {
		[self setAuntk:self.detailItem.auntk];
		self.toggleAUNTKButton.title = @"Switch to Chain";
	}
}


- (void)configureView
{
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"monthYear" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
	// Loss Ratio Line Chart
	[self.lossRatioLineChartView setTitle:self.lossRatioTrendLabel];
	[self.lossRatioLineChartView setPointDistance:20];
	[self.lossRatioLineChartView setTouchIndicatorEnabled:YES];
	[self.lossRatioLineChartView setGoalValue:[NSNumber numberWithFloat:30.0]];
	[self.lossRatioLineChartView setGoalShown:NO];
	NSArray *lossRatioData = [self.auntk.lossRatioTrendReportData.allObjects sortedArrayUsingDescriptors:sortDescriptors];
	NSLog(@"lossRatioData: %@", lossRatioData);
	if ((lossRatioData != nil) && (lossRatioData.count > 0)) {
		[self.lossRatioLineChartView setGraphWithDataPoints:lossRatioData];
	}
	//[self.lossRatioLineChartView reload];
	
	// Claim Frequency Line Chart
	[self.claimFrequencyLineChartView setTitle:self.claimFrequencyTrendLabel];
	[self.claimFrequencyLineChartView setPointDistance:20];
	[self.claimFrequencyLineChartView setTouchIndicatorEnabled:YES];
	[self.claimFrequencyLineChartView setGoalValue:[NSNumber numberWithFloat:30.0]];
	[self.claimFrequencyLineChartView setGoalShown:NO];
	NSArray *claimFrequencyData = [self.auntk.claimFrequecyTrendReportData.allObjects sortedArrayUsingDescriptors:sortDescriptors];
	NSLog(@"claimFrequencyData: %@", claimFrequencyData);
	
	if ((claimFrequencyData != nil) && (claimFrequencyData.count > 0)) {
		[self.claimFrequencyLineChartView setGraphWithDataPoints:claimFrequencyData];
	}
	//[self.claimFrequencyLineChartView reload];
	//[self.claimFrequencyLineChartView scrollToPoint:0 animated:YES];
	/*
	// Loss Ratio Line Chart
	[self.lossRatioLineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	self.lossRatioLineChartView.minValue = 0;
	self.lossRatioLineChartView.maxValue = 30.0;
	
	NSArray *lossRatioPointsArray = [self.auntk.lossRatioTrendReportData.allObjects valueForKeyPath:@"lossRatio"];
	PCLineChartViewComponent *lossRatioComponent = [[PCLineChartViewComponent alloc] init];
	
	[lossRatioComponent setTitle:@"Loss Ratio Trend"];
	[lossRatioComponent setPoints:lossRatioPointsArray];
	[lossRatioComponent setShouldLabelValues:NO];
	[lossRatioComponent setColour:PCColorGreen];
	NSMutableArray *lossRatioComponents = [NSMutableArray arrayWithObject:lossRatioComponent];
	[self.lossRatioLineChartView setComponents:lossRatioComponents];
	NSArray *xLabels = [self.auntk.lossRatioTrendReportData.allObjects valueForKeyPath:@"monthYear"];
	[self.lossRatioLineChartView setXLabels:[NSMutableArray arrayWithArray:xLabels]];
	
	
	// Claim Frequency Line Chart
	[self.claimFrequencyLineChartView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	
	NSArray *claimFrequencyPointsArray = [self.auntk.claimFrequecyTrendReportData.allObjects valueForKeyPath:@"claimsFrequency"];
	PCLineChartViewComponent *claimFrequencyComponent = [[PCLineChartViewComponent alloc] init];
	[claimFrequencyComponent setTitle:@"Claim Frequency Trend"];
	[claimFrequencyComponent setPoints:claimFrequencyPointsArray];
	[claimFrequencyComponent setShouldLabelValues:YES];
	[claimFrequencyComponent setColour:PCColorBlue];
	[self.claimFrequencyLineChartView setComponents:[NSMutableArray arrayWithObject:claimFrequencyComponent]];
	[self.claimFrequencyLineChartView setXLabels:[NSMutableArray arrayWithArray:[self.auntk.claimFrequecyTrendReportData.allObjects valueForKeyPath:@"monthYear"]]];
	[self.claimFrequencyLineChartView setNeedsDisplay];
	*/
	 
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
	_lossRatioLineChartView = [[TKGraphView alloc] initWithFrame:CGRectMake(30, 677, 360, 224)];
	[self.view addSubview:self.lossRatioLineChartView];
	_claimFrequencyLineChartView = [[TKGraphView alloc] initWithFrame:CGRectMake(394, 677, 360, 224)];
	[self.view addSubview:self.claimFrequencyLineChartView];
}

- (void)viewWillAppear:(BOOL)animated
{
	self.auntk = self.detailItem.chainAuntk;
	[self configureView];
}

- (void)viewDidUnload
{
    [self setProductionTableView:nil];
	[self setLossRatioTableView1:nil];
	[self setLossRatioLineChartView:nil];
	[self setClaimFrequencyLineChartView:nil];
	[self setLossRatioTrendLabel:nil];
	[self setClaimFrequencyTrendLabel:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self setLossRatioTableView2:nil];
	[self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //[_lossRatioLineChartView setNeedsDisplay];
	//[_claimFrequencyLineChartView setNeedsDisplay];
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
		rows = self.auntk.policyCountReportData.count;
	} else if (tableView == self.lossRatioTableView1) {
		rows = self.auntk.productionReportData.count;
	} else if (tableView == self.lossRatioTableView2) {
		rows = self.auntk.productionReportData.count;
	}
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.productionTableView) {
		AUNTKProductionTableViewCell *customCell = [AUNTKProductionTableViewCell cellForTableView:tableView fromNib:self.productionTableViewCellNib];
		customCell.dateLabel.text = [(PolicyCountReportData *)[self.auntk.policyCountReportData.allObjects objectAtIndex:indexPath.row] header];
		//customCell.valueLabel.text = [[(PolicyCountReportData *)[self.auntk.policyCountReportData.allObjects objectAtIndex:indexPath.row] count] stringValue];
		customCell.valueLabel.text = [(PolicyCountReportData *)[self.auntk.policyCountReportData.allObjects objectAtIndex:indexPath.row] count];
		return customCell;
	} else if (tableView == self.lossRatioTableView1) {
		AUNTKLossRatioTableViewCell1 *customCell = [AUNTKLossRatioTableViewCell1 cellForTableView:tableView fromNib:self.lossRatioTableViewCell1Nib];
		ProductionReportData *data = (ProductionReportData *)[self.auntk.productionReportData.allObjects objectAtIndex:indexPath.row];
		customCell.yearLabel.text = data.year.stringValue;
		customCell.monthLabel.text = data.month;
		customCell.brandnewPoliciesPerMonthLabel.text = data.currentPoliciesMonth.stringValue;
		customCell.policiesWrittenITDLabel.text = data.policiesWrittenITD.stringValue;
		customCell.policiesInForceLabel.text = data.policiesInForce.stringValue;
		customCell.wpTotalITDLabel.text = data.wpTotalITD.stringValue;
		customCell.averageWpITDLabel.text = data.avgWPITD.stringValue;
		customCell.epTotalITDLabel.text = data.epTotalITD.stringValue;
		customCell.lrTotalITDLabel.text = data.lrTotalITD.stringValue;
		return customCell;
	} else if (tableView == self.lossRatioTableView2) {
		AUNTKLossRatioTableViewCell2 *customCell = [AUNTKLossRatioTableViewCell2 cellForTableView:tableView fromNib:self.lossRatioTableViewCell2Nib];
		ProductionReportData *data = (ProductionReportData *)[self.auntk.productionReportData.allObjects objectAtIndex:indexPath.row];
		customCell.yearLabel.text = data.year.stringValue;
		customCell.monthLabel.text = data.month;
		customCell.percentLiabilityOnlyLabel.text = data.percentLiabilityOnlyITD.stringValue;
		customCell.thirtyDayCancelLabel.text = data.cancel30dMonth.stringValue;
		customCell.thirtyDayClaimsLabel.text = data.nbrClaims30dMonth.stringValue;
		customCell.numberOfClaimsPerMonthLabel.text = data.nbrClaimsMonth.stringValue;
		customCell.numberOfClaimsITDLabel.text = data.nbrClaimsITD.stringValue;
		customCell.frequencyITDLabel.text = data.frequencyITD.stringValue;
		customCell.averageIncLossLabel.text = data.avgIncLossITD.stringValue;
		customCell.percentFDLLabel.text = data.percentFDLMonth.stringValue;
		customCell.averageCarsPerDriverLabel.text = data.avgCarsDriver.stringValue;
		customCell.averageDriverAgeLabel.text = data.avgDriverAge.stringValue;
		return customCell;
	}
	
	return nil;
}

@end
