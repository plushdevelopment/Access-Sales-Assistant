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

@end
