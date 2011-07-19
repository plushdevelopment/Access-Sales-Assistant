//
//  VisitApplicationNotesViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationNotesViewController.h"

#import "DailySummary.h"

#import "Note.h"

@implementation VisitApplicationNotesViewController

@synthesize detailItem=_detailItem;

@synthesize managedObjectContext=_managedObjectContext;
@synthesize opportunityTextField = _opportunityTextField;
@synthesize summaryTextField = _summaryTextField;
@synthesize committmentTextField = _committmentTextField;
@synthesize followUpTextField = _followUpTextField;


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
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (!self.detailItem.editedValue) {
		self.detailItem.editedValue = YES;
		[[NSManagedObjectContext defaultContext] save];
	}
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSString *noteString = [textField.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	if (textField == self.opportunityTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 1) {
				note.text = noteString;
			}
		}
	} else if (textField == self.summaryTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 2) {
				note.text = noteString;
			}
		}
	} else if (textField == self.committmentTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 3) {
				note.text = noteString;
			}
		}
	} else if (textField == self.followUpTextField) {
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
