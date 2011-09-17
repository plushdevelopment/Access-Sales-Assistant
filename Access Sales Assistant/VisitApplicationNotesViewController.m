//
//  VisitApplicationNotesViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationNotesViewController.h"

#import "DailySummary.h"

#import "Producer.h"

#import "Note.h"

#import "HTTPOperationController.h"

@implementation VisitApplicationNotesViewController

@synthesize detailItem=_detailItem;

@synthesize managedObjectContext=_managedObjectContext;
@synthesize opportunityTextField = _opportunityTextField;
@synthesize summaryTextField = _summaryTextField;
@synthesize committmentTextField = _committmentTextField;
@synthesize followUpTextField = _followUpTextField;
@synthesize scrollView = _scrollView;
@synthesize titleLabel = _titleLabel;
@synthesize titleText;

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender
{
	[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[self.detailItem jsonStringValue]];
	self.detailItem.producerId.submittedValue = YES;
}

- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext == nil) {
		self.managedObjectContext = [NSManagedObjectContext defaultContext];
	}
	return _managedObjectContext;
}

#pragma mark -
#pragma mark Detail item

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
	if (self.detailItem) {
		if ([self.detailItem valueForKey:@"editedValue"]) {
			[[NSManagedObjectContext defaultContext] save];
		}
	}
	
	Producer *producer = (Producer *)newDetailItem;
	if (!producer.dailySummary) {
		producer.dailySummary = [DailySummary createEntity];
	}
    if (_detailItem != producer.dailySummary) {
        _detailItem = producer.dailySummary;
        
        // Update the view.
        [self configureView];
    }
    titleText = [[NSString alloc]initWithFormat:@"%@ - %@",producer.name,producer.producerCode];  
}

- (void)configureView
{
	for (Note *note in self.detailItem.notes) {
		switch (note.typeValue) {
			case 1:
				self.opportunityTextField.text = note.text;
				break;
			case 2:
				self.summaryTextField.text = note.text;
				break;
			case 3:
				self.committmentTextField.text = note.text;
				break;
			case 4:
				self.followUpTextField.text = note.text;
				break;
			default:
				break;
		}
	}
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if (!self.detailItem.editedValue) {
		self.detailItem.editedValue = YES;
		[[NSManagedObjectContext defaultContext] save];
	}
	return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	NSString *noteString = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	if (textView == self.opportunityTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 1) {
				note.text = noteString;
			}
		}
	} else if (textView == self.summaryTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 2) {
				note.text = noteString;
			}
		}
	} else if (textView == self.committmentTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 3) {
				note.text = noteString;
			}
		}
	} else if (textView == self.followUpTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 4) {
				note.text = noteString;
			}
		}
	}
	[self.managedObjectContext save];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
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
    _scrollView.contentSize = _scrollView.frame.size;
    _titleLabel.text = titleText;
}

- (void)viewDidUnload
{
	[self setOpportunityTextField:nil];
	[self setSummaryTextField:nil];
	[self setCommittmentTextField:nil];
	[self setFollowUpTextField:nil];
	[self setOpportunityTextField:nil];
	[self setSummaryTextField:nil];
	[self setCommittmentTextField:nil];
	[self setFollowUpTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
   // return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
