//
//  FeaturesAndBenefitsViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FeaturesAndBenefitsViewController.h"
#import "RootViewController.h"

#import "StateSelectionTableViewController.h"
@implementation FeaturesAndBenefitsViewController

@synthesize _accessInternationalDrivers;
@synthesize _accessBusiness;
@synthesize _multilingualCompany;
@synthesize _salvageTitles;
@synthesize _weDonotDirect;
@synthesize _namedNonOwnerPolicy;
@synthesize _registeredOwnerDiscounts;
@synthesize _multiFamilyPolicy;
@synthesize _acceptUpto2DUIs;
@synthesize _noCreditScoreorTiers;
@synthesize _multiplePaymentOptions;
@synthesize _changeStateButton;
@synthesize stateViewController=_stateViewController;

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(IBAction)selectState:(id)sender
{
    if(self.stateViewController == nil)
    {
        self.stateViewController = [[StateSelectionTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
 
    
    _popOverController  = [[UIPopoverController alloc] initWithContentViewController:self.stateViewController];
    }
    
    [_popOverController presentPopoverFromRect: CGRectMake(300,930,300,500) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    self.stateViewController.delegate = self;
    
    
    
}
-(void) selectedState:(NSString*) stateName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"FeaturesAndBenefits" ofType:@"plist"];
      NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary* featuresAndBenefits = [plistData objectForKey:stateName]; 
    
    [_changeStateButton setTitle:stateName forState:UIControlStateNormal];
    
    _accessInternationalDrivers.text = [featuresAndBenefits objectForKey:@"Accept International Drivers and Experience"];
    _accessBusiness.text = [featuresAndBenefits objectForKey:@"Accept Business or Artisan Use"];
    _multilingualCompany.text = [featuresAndBenefits objectForKey:@"Multilingual Company"];
    _salvageTitles.text = [featuresAndBenefits objectForKey:@"Salvage Titles"];
    _weDonotDirect.text = [featuresAndBenefits objectForKey:@"We Do Not Go Direct"];
    _namedNonOwnerPolicy.text = [featuresAndBenefits objectForKey:@"Named Non-Owner Policy Option"];
    _registeredOwnerDiscounts.text = [featuresAndBenefits objectForKey:@"Registered Owner Discounts"];
    _multiFamilyPolicy.text = [featuresAndBenefits objectForKey:@"Multi Family Policy"];
    _acceptUpto2DUIs.text = [featuresAndBenefits objectForKey:@"Accept up to 2 DUIs"];
    _noCreditScoreorTiers.text = [featuresAndBenefits objectForKey:@"No Credit Score for Tiers"];
    _multiplePaymentOptions.text = [featuresAndBenefits objectForKey:@"Multiple Payment Options"];
    
    [_popOverController dismissPopoverAnimated:YES];
    
    
    
    
}

@end
