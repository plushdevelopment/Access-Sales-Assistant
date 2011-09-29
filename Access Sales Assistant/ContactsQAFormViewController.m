//
//  ContactsQAFormViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactsQAFormViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "QAResolutionForm.h"
#import "HTTPOperationController.h"
@implementation ContactsQAFormViewController

@synthesize requestView = _requestView;
@synthesize producerCodeField = _producerCodeField;
@synthesize producerNumberField = _producerNumberField;
@synthesize descriptionField = _descriptionField;


@synthesize strProducerNumber = _strProducerNumber;
@synthesize strProducerCode = _strProducerCode;
@synthesize strQARequest = _strQARequest;
@synthesize strQADescription = _strQADescription;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.requestView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.requestView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.requestView.layer setBorderWidth: 3.0f];
    [self.requestView.layer setCornerRadius:8.0f];
    [self.requestView.layer setMasksToBounds:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(IBAction)cancelRequest:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)submitRequest:(id)sender
{
    
    self.strProducerNumber = _producerNumberField.text;
    self.strProducerCode = _producerCodeField.text;
    self.strQADescription = _descriptionField.text;
    self.strQARequest = _requestView.text;

    QAResolutionForm *formData = [QAResolutionForm createEntity];
    formData.producerCode = _strProducerCode;
    formData.policyNumber = _strProducerNumber;
    formData.descp = _strQADescription;
    formData.request = _strQARequest;
    
    [[HTTPOperationController sharedHTTPOperationController] postQAResolutionForm:[formData jsonStringValue]];
    
    [self dismissModalViewControllerAnimated:YES];
}
@end
