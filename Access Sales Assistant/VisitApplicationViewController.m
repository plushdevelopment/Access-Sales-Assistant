//
//  VisitApplicationViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationViewController.h"

#import "HTTPOperationController.h"

#import "Producer.h"

#import "DailySummary.h"

#import "ProfileTableViewController.h"

@implementation VisitApplicationViewController

@synthesize tabBarController = _tabBarController;
@synthesize titleLabel=_titleLabel;

@synthesize activeVisitFormView=_activeVisitFormView;

@synthesize profileApplicationViewController=_profileApplicationViewController;

@synthesize summaryApplicationViewController=_summaryApplicationViewController;

@synthesize notesApplicationViewController=_notesApplicationViewController;

@synthesize photoApplicationViewController=_photoApplicationViewController;

@synthesize detailItem=_detailItem;

@synthesize currentController=_currentController;

@synthesize toolBar=_toolBar;

@synthesize pc =_pc;

- (IBAction)loadApplicationForm:(id)sender
{
	UIButton *button = (UIButton *)sender;
	switch (button.tag) {
		case 2:
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:_profileApplicationViewController.view];
			float contentWidth = self.activeVisitFormView.frame.size.width;
			//[(UIScrollView *)_profileApplicationViewController.view setContentSize:CGSizeMake(contentWidth, 1500.0)];
			_profileApplicationViewController.detailItem = self.detailItem;
			self.currentController = _profileApplicationViewController;
			break;
		case 3: {
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:_summaryApplicationViewController.view];
			DailySummary *summary = [(Producer *)self.detailItem dailySummary];
			if (!summary) {
				summary = [DailySummary createEntity];
				[(Producer *)self.detailItem setDailySummary:summary];
				[[NSManagedObjectContext defaultContext] save];
			}
			_summaryApplicationViewController.detailItem = summary;
			self.currentController = _summaryApplicationViewController;
		}
			break;
		case 4: {
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:_notesApplicationViewController.view];
			DailySummary *summary = [(Producer *)self.detailItem dailySummary];
			if (!summary) {
				summary = [DailySummary createEntity];
				[(Producer *)self.detailItem setDailySummary:summary];
				[[NSManagedObjectContext defaultContext] save];
			}
			_notesApplicationViewController.detailItem = summary;
			self.currentController = _notesApplicationViewController;
		}
			break;
		case 5:
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:_photoApplicationViewController.view];
			_photoApplicationViewController.detailItem = self.detailItem;
			self.currentController = _photoApplicationViewController;
			self.photoApplicationViewController.parent = self;
			break;
		default:
			break;
	}
	NSLog(@"Button Label: %@ Button Tag: %d", button.titleLabel.text, button.tag);
}

- (IBAction)cancelApplicationForm:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submitApplicationForm:(id)sender
{
	if (!self.detailItem) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select a producer from the menu" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alertView show];
	} else {
		Producer *producer = (Producer *)self.detailItem;
		if ([self.currentController isEqual:self.profileApplicationViewController]) {
			[[HTTPOperationController sharedHTTPOperationController] postProducerProfile:[producer jsonStringValue]];
		} else if ([self.currentController isEqual:self.summaryApplicationViewController]) {
			[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[producer.dailySummary jsonStringValue]];
			producer.submittedValue = YES;
		} else if ([self.currentController isEqual:self.notesApplicationViewController]) {
			[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[producer.dailySummary jsonStringValue]];
			producer.submittedValue = YES;
		}
	}
}

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
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.baseToolbar = self.toolBar;
	
    _profileApplicationViewController.view.frame = CGRectMake(0,20,  768, 800);
	[self.activeVisitFormView addSubview:_profileApplicationViewController.view];
    
    
	_profileApplicationViewController.detailItem = self.detailItem;
	self.currentController = _profileApplicationViewController;
    
    	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"Post Producer Successful" object:nil];
        	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"Post Summary Successful" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"Post Image Successful" object:nil];
}

- (void)viewDidUnload
{
	[self setActiveVisitFormView:nil];
	[self setProfileApplicationViewController:nil];
	[self setSummaryApplicationViewController:nil];
	[self setPhotoApplicationViewController:nil];
	[self setTitleLabel:nil];
    [self setTabBarController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   // return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    return YES;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	Producer *producer = (Producer *)self.detailItem;
	[[HTTPOperationController sharedHTTPOperationController] postImage:image forProducer:producer.uid];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        [self.pc dismissPopoverAnimated:YES];
    }
	
}

- (void)configureView
{
    // Update the user interface for the detail item.
	
	if (self.detailItem) {
	    [_profileApplicationViewController setDetailItem:self.detailItem];
		[_summaryApplicationViewController setDetailItem:[(Producer *)self.detailItem dailySummary]];
		[_notesApplicationViewController setDetailItem:[(Producer *)self.detailItem dailySummary]];
		[_photoApplicationViewController setDetailItem:self.detailItem];
	}
}

-(void)showInfo:(id) sender
{
    if(self.currentController == _profileApplicationViewController)
    {
        [self showAlert:@"Producer profile submitted Successfully!"];
    }
    else if(self.currentController == _summaryApplicationViewController)
    {
        [self showAlert:@"Producer summary submitted Successfully!"];
    }
    else if(self.currentController == _notesApplicationViewController)
    {
        [self showAlert:@"Producer notes submitted Successfully!"];
    }
    else if(self.currentController == _photoApplicationViewController)
    {
        [self showAlert:@"Producer picture submitted Successfully!"];
    }
}
@end
