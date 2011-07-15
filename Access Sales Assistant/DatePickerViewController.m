//
//  DatePickerViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"

@implementation DatePickerViewController

@synthesize datePicker;

@synthesize delegate=_delegate;

@synthesize currentTag=_currentTag;

@synthesize currentIndexPath=_currentIndexPath;

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

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)datePickerValueChanged:(id)sender
{
	if (self.delegate != nil) {
		[self.delegate didChangeDate:self.datePicker.date forTag:self.currentTag];
	}
}

- (IBAction)nextField:(id)sender
{
	if (self.delegate != nil) {
		[self.delegate nextField:self.currentTag];
	}
}

- (IBAction)previousField:(id)sender
{
	if (self.delegate != nil) {
		[self.delegate previousField:self.currentTag];
	}
}


@end
