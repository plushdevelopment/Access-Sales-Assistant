//
//  ContactsQAFormViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactsQAFormViewController.h"

#import <QuartzCore/QuartzCore.h>
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
    
    [self.requestView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [self.requestView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.requestView.layer setBorderWidth: 3.0f];
    [self.requestView.layer setCornerRadius:8.0f];
    [self.requestView.layer setMasksToBounds:YES];
   // self.requestView.layer.borderWidth = 5.0f;
    //self.requestView.layer.borderColor = [[UIColor grayColor] CGColor];
    
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

    
     NSString* requestFormat = [[NSString alloc] initWithFormat:@"Producer Num:%@\nProducer Code:%@\nDescription: %@\nRequest: %@\n",self.strProducerNumber,self.strProducerCode,self.strQADescription,self.strQARequest];
        [self showAlert:requestFormat];
    
   // [self showAlert:@"Request submitted successfully!"];
    [self dismissModalViewControllerAnimated:YES];
}
@end
