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
@synthesize submitButton=_submitButton;
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
        NSSet *notes = _detailItem.notes;
		if (notes.count != 4) {
			for (Note *note in notes) {
				[note deleteInContext:[NSManagedObjectContext defaultContext]];
			}
			[[NSManagedObjectContext defaultContext] save];
			Note *opportunityNote = [Note createEntity];
			[opportunityNote setTypeValue:1];
			Note *summaryNote = [Note createEntity];
			[summaryNote setTypeValue:2];
			Note *committmentNote = [Note createEntity];
			[committmentNote setTypeValue:3];
			Note *followUpNote = [Note createEntity];
			[followUpNote setTypeValue:4];
			[_detailItem setNotes:[NSSet setWithObjects:opportunityNote, summaryNote, committmentNote, followUpNote, nil]];
			[[NSManagedObjectContext defaultContext] save];
		}
        // Update the view.
        [self configureView];
    }
    titleText = [[NSString alloc]initWithFormat:@"%@ - %@",producer.name,producer.producerCode];  
}

- (void)configureView
{
    for (UIView *view in self.view.subviews) {
        for (UIResponder *responder in view.subviews) {
            if ([responder isKindOfClass:[UITextView class]]) {
                UITextView *textFld = (UITextView*) responder;
                [textFld setText:@""];
            }
        }
        
    }

	for (Note *note in self.detailItem.notes) {
		switch (note.typeValue) {
                NSLog(@"%@",note.text);
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
	return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	NSString *noteString = [textView.text stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
	if (textView == self.opportunityTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 1) {
				note.text = noteString;
				break;
			}
		}
	} else if (textView == self.summaryTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 2) {
				note.text = noteString;
				break;
			}
		}
	} else if (textView == self.committmentTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 3) {
				note.text = noteString;
				break;
			}
		}
	} else if (textView == self.followUpTextField) {
		for (Note *note in self.detailItem.notes) {
			if (note.typeValue == 4) {
				note.text = noteString;
				break;
			}
		}
	}
	self.detailItem.editedValue = YES;
	self.detailItem.producerId.editedValue = YES;
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
    
}

- (void)viewWillAppear:(BOOL)animated
{
	[self toggleSubmitButton:[self isEnableSubmit]];
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

-(void) toggleSubmitButton:(BOOL) isEnable
{
    [_submitButton setEnabled:isEnable];
}

-(BOOL)isEnableSubmit
{
	if (_detailItem.reportDate == nil) {
		return NO;
	}
    if(_detailItem.reasonNotSeen)
    {
		return TRUE;
    }
    
    if(!_detailItem.editedValue)
        return FALSE;
	
	if(_detailItem.reportDate == nil||
	   _detailItem.commissionStructure == nil ||
	   [_detailItem.commissionStructure.name  length]<=0 ||
	   _detailItem.commissionPercentNew == nil ||
	   _detailItem.commissionPercentRenewal == nil) {
		return  FALSE;
	}
	if([_detailItem.personsSpokeWith.allObjects count]<=0)
		return FALSE;
	
	for(PersonSpokeWith *pSpokeWith in _detailItem.personsSpokeWith.allObjects)
	{
		if([pSpokeWith.firstName length]<= 0 ||
		   [pSpokeWith.lastName length]<=0 ||
		   pSpokeWith.title == nil ||
		   [pSpokeWith.email length]<=0)
			return FALSE;
	}
	if(_detailItem.producerAddOn == nil||
	   _detailItem.nsbsFdl == nil ||
	   _detailItem.nsbsMonthlyGoal == nil ||
	   _detailItem.nsbsPercentLiab == nil ||
	   _detailItem.rdFollowUp == nil ||
	   _detailItem.nsbsTotAppsPerMonth == nil
	   ) {
		return FALSE;
	}
	if([_detailItem.competitors.allObjects count]<=0)
		return FALSE;
	
	for(Competitor *comptr in _detailItem.competitors.allObjects)
	{
		if([comptr.name length]<=0 ||
		   comptr.appsPerMonth == nil
		   )
			return FALSE;
	}
	if([_detailItem.barriersToBusiness.allObjects count]<=0)
		return FALSE;
	
	for(BarrierToBusiness *bBusiness in _detailItem.barriersToBusiness.allObjects)
	{
		if([bBusiness.name length]<=0)
			return FALSE;
	}
    
    return TRUE;
}

@end
