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

@implementation VisitApplicationAUNTKViewController

@synthesize detailItem=_detailItem;
@synthesize productionTableView=_productionTableView;
@synthesize lossRatioTableView = _lossRatioTableView;
@synthesize lossRatioLineChartView = _lossRatioLineChartView;
@synthesize claimFrequencyLineChartView = _claimFrequencyLineChartView;
@synthesize dismissButton=_dismissButton;
@synthesize aPopoverController=_aPopoverController;
@synthesize managedObjectContext=_managedObjectContext;

#pragma mark -
#pragma mark IBActions

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

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

- (void)configureView
{
	//[self.tableView reloadData];
}

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
}

- (void)viewWillAppear:(BOOL)animated
{
	[self configureView];
}

- (void)viewDidUnload
{
    [self setProductionTableView:nil];
	[self setLossRatioTableView:nil];
	[self setLossRatioLineChartView:nil];
	[self setClaimFrequencyLineChartView:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

@end
