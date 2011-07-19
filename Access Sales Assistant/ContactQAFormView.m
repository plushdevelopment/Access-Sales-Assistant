//
//  ContactQAFormView.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactQAFormView.h"

@implementation ContactQAFormView

@synthesize toolBar=_toolBar;
@synthesize producerNumber = _producerNumber;
@synthesize producerCode = _producerCode;
@synthesize qaRequest = _qaRequest;
@synthesize qaDescription = _qaDescription;
@synthesize qaSubmitButton = _qaSubmitButton;
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
    self.baseToolbar = _toolBar;
    // Do any additional setup after loading the view from its nib.
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

-(IBAction)submitQARequest:(id)sender
{
    self.strProducerNumber = self.producerNumber.text;
    self.strProducerCode = self.producerCode.text;
    self.strQADescription = self.qaDescription.text;
    self.strQARequest = self.qaRequest.text;
    
    NSString* requestFormat = [[NSString alloc] initWithFormat:@"Producer Num:%@\nProducer Code:%@\nDescription: %@\nRequest: %@\n",self.strProducerNumber,self.strProducerCode,self.strQADescription,self.strQARequest];
    [self showAlert:requestFormat];
}
@end
