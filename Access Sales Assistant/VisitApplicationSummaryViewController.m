//
//  VisitApplicationSummaryViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationSummaryViewController.h"

@implementation VisitApplicationSummaryViewController
@synthesize generalView=_generalView;
@synthesize personSpokeWithView1 = _personSpokeWithView1;
@synthesize personSpokeWithView2 = _personSpokeWithView2;
@synthesize personSpokeWithView3 = _personSpokeWithView3;
@synthesize producerNameTextField = _producerNameTextField;
@synthesize reportDateTextField = _reportDateTextField;
@synthesize callTypeTextField = _callTypeTextField;
@synthesize reportDateButton = _reportDateButton;
@synthesize firstNameTextField1 = _firstNameTextField1;
@synthesize titleTextField1 = _titleTextField1;
@synthesize emailAddressTextField1 = _emailAddressTextField1;
@synthesize titleButton1 = _titleButton1;
@synthesize lastNameTextField1 = _lastNameTextField1;
@synthesize firstNameTextField2 = _firstNameTextField2;
@synthesize titleTextField2 = _titleTextField2;
@synthesize emailAddressTextField2 = _emailAddressTextField2;
@synthesize titleButton2 = _titleButton2;
@synthesize lastNameTextField2 = _lastNameTextField2;
@synthesize firstNameTextField3 = _firstNameTextField3;
@synthesize titleTextField3 = _titleTextField3;
@synthesize emailAddressTextField3 = _emailAddressTextField3;
@synthesize titleButton3 = _titleButton3;
@synthesize lastNameTextField3 = _lastNameTextField3;
@synthesize competitorNameTextField1 = _competitorNameTextField1;
@synthesize competitorAppsPerMonthTextField1 = _competitorAppsPerMonthTextField1;
@synthesize competitorCommissionStructureTextField1 = _competitorCommissionStructureTextField1;
@synthesize competitorPercentNewTextField1 = _competitorPercentNewTextField1;
@synthesize competitorPercentRenewalTextField1 = _competitorPercentRenewalTextField1;
@synthesize competitorNameButton1 = _competitorNameButton1;
@synthesize competitorCommissionStructureButton1 = _competitorCommissionStructureButton1;
@synthesize competitorNameTextField2 = _competitorNameTextField2;
@synthesize competitorAppsPerMonthTextField2 = _competitorAppsPerMonthTextField2;
@synthesize competitorCommissionStructureTextField2 = _competitorCommissionStructureTextField2;
@synthesize competitorPercentNewTextField2 = _competitorPercentNewTextField2;
@synthesize competitorPercentRenewalTextField2 = _competitorPercentRenewalTextField2;
@synthesize competitorNameButton2 = _competitorNameButton2;
@synthesize competitorCommissionStructureButton2 = _competitorCommissionStructureButton2;
@synthesize competitorNameTextField3 = _competitorNameTextField3;
@synthesize competitorAppsPerMonthTextField3 = _competitorAppsPerMonthTextField3;
@synthesize competitorCommissionStructureTextField3 = _competitorCommissionStructureTextField3;
@synthesize competitorPercentNewTextField3 = _competitorPercentNewTextField3;
@synthesize competitorPercentRenewalTextField3 = _competitorPercentRenewalTextField3;
@synthesize competitorNameButton3 = _competitorNameButton3;
@synthesize competitorCommissionStructureButton3 = _competitorCommissionStructureButton3;
@synthesize barrierToBusinessTextField1 = _barrierToBusinessTextField1;
@synthesize barrierToBusinessButton1 = _barrierToBusinessButton1;
@synthesize barrierToBusinessTextField2 = _barrierToBusinessTextField2;
@synthesize barrierToBusinessButton2 = _barrierToBusinessButton2;
@synthesize barrierToBusinessTextField3 = _barrierToBusinessTextField3;
@synthesize barrierToBusinessButton3 = _barrierToBusinessButton3;
@synthesize nsbsTotalAppsPerMonthTextField = _nsbsTotalAppsPerMonthTextField;
@synthesize nsbsPercentLiabTextField = _nsbsPercentLiabTextField;
@synthesize producerAddOnTextField = _producerAddOnTextField;
@synthesize rdFollowUpTextField = _rdFollowUpTextField;
@synthesize nsbsMonthlyGoalTextField = _nsbsMonthlyGoalTextField;
@synthesize nsbsPercentFDLTextField = _nsbsPercentFDLTextField;
@synthesize rdFollowUpButton = _rdFollowUpButton;
@synthesize producerAddOnButton = _producerAddOnButton;
@synthesize addPersonButton = _addPersonButton;
@synthesize addCompetitorButton = _addCompetitorButton;
@synthesize addBarrierButton = _addBarrierButton;
@synthesize nsbsLabel = _nsbsLabel;
@synthesize barriersToBusinessLabel = _barriersToBusinessLabel;
@synthesize competitorsLabel = _competitorsLabel;
@synthesize personSpokeWithLabel = _personSpokeWithLabel;
@synthesize generalLabel = _generalLabel;
@synthesize addPersonPlusSignButton = _addPersonPlusSignButton;
@synthesize addCompetitorPlusSignButton = _addCompetitorPlusSignButton;
@synthesize addBarrierPlusSignButton = _addBarrierPlusSignButton;
@synthesize addPersonLabel = _addPersonLabel;
@synthesize addCompetitorLabel = _addCompetitorLabel;
@synthesize addBarrierLabel = _addBarrierLabel;


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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)viewDidUnload {
    [self setCompetitorNameTextField1:nil];
    [self setCompetitorAppsPerMonthTextField1:nil];
    [self setCompetitorCommissionStructureTextField1:nil];
    [self setCompetitorPercentNewTextField1:nil];
    [self setCompetitorPercentRenewalTextField1:nil];
    [self setCompetitorNameButton1:nil];
    [self setCompetitorCommissionStructureButton1:nil];
    [self setBarrierToBusinessTextField1:nil];
    [self setBarrierToBusinessButton1:nil];
	[self setNsbsTotalAppsPerMonthTextField:nil];
	[self setNsbsPercentLiabTextField:nil];
	[self setProducerAddOnTextField:nil];
	[self setRdFollowUpTextField:nil];
	[self setNsbsMonthlyGoalTextField:nil];
	[self setNsbsPercentFDLTextField:nil];
	[self setRdFollowUpButton:nil];
	[self setProducerAddOnButton:nil];
	[self setAddPersonButton:nil];
	[self setAddCompetitorButton:nil];
	[self setAddBarrierButton:nil];
	[self setNsbsLabel:nil];
	[self setBarriersToBusinessLabel:nil];
	[self setCompetitorsLabel:nil];
	[self setPersonSpokeWithLabel:nil];
	[self setGeneralLabel:nil];
	[self setAddPersonPlusSignButton:nil];
	[self setAddCompetitorPlusSignButton:nil];
	[self setAddBarrierPlusSignButton:nil];
	[self setAddPersonLabel:nil];
	[self setAddCompetitorLabel:nil];
	[self setAddBarrierLabel:nil];
    [super viewDidUnload];
}
@end
