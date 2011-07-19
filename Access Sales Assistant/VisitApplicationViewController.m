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

@implementation VisitApplicationViewController

@synthesize toolbar=_toolbar;

@synthesize popoverController;

@synthesize activeVisitFormView;

@synthesize profileApplicationViewController;
@synthesize summaryApplicationViewController;
@synthesize notesApplicationViewController;
@synthesize photoApplicationViewController;

@synthesize detailItem=_detailItem;

@synthesize currentController=_currentController;

- (IBAction)loadApplicationForm:(id)sender
{
	UIButton *button = (UIButton *)sender;
	switch (button.tag) {
		case 2:
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:profileApplicationViewController.view];
			float contentWidth = self.activeVisitFormView.frame.size.width;
			[(UIScrollView *)profileApplicationViewController.view setContentSize:CGSizeMake(contentWidth, 1500.0)];
			profileApplicationViewController.detailItem = self.detailItem;
			self.currentController = profileApplicationViewController;
			break;
		case 3: {
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:summaryApplicationViewController.view];
			DailySummary *summary = [(Producer *)self.detailItem dailySummary];
			if (!summary) {
				summary = [DailySummary createEntity];
				[(Producer *)self.detailItem setDailySummary:summary];
				[[NSManagedObjectContext defaultContext] save];
			}
			summaryApplicationViewController.detailItem = summary;
			self.currentController = summaryApplicationViewController;
		}
			break;
		case 4: {
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:notesApplicationViewController.view];
			DailySummary *summary = [(Producer *)self.detailItem dailySummary];
			if (!summary) {
				summary = [DailySummary createEntity];
				[(Producer *)self.detailItem setDailySummary:summary];
				[[NSManagedObjectContext defaultContext] save];
			}
			notesApplicationViewController.detailItem = summary;
			self.currentController = notesApplicationViewController;
		}
			break;
		case 5:
			for (UIView *view in [self.activeVisitFormView subviews]) {
				[view removeFromSuperview];
			}
			[self.activeVisitFormView addSubview:photoApplicationViewController.view];
			photoApplicationViewController.detailItem = self.detailItem;
			self.currentController = photoApplicationViewController;
			self.photoApplicationViewController.parent = self;
			break;
		default:
			break;
	}
	NSLog(@"Button Label: %@ Button Tag: %d", button.titleLabel.text, button.tag);
}

- (IBAction)submitApplicationForm:(id)sender
{
	Producer *producer = (Producer *)self.detailItem;
	if ([self.currentController isEqual:self.profileApplicationViewController]) {
		[[HTTPOperationController sharedHTTPOperationController] postProducerProfile:[producer jsonStringValue]];
	} else if ([self.currentController isEqual:self.summaryApplicationViewController]) {
		[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[producer.dailySummary jsonStringValue]];
	} else if ([self.currentController isEqual:self.notesApplicationViewController]) {
		[[HTTPOperationController sharedHTTPOperationController] postDailySummary:[producer.dailySummary jsonStringValue]];
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
	[self.activeVisitFormView addSubview:profileApplicationViewController.view];
	float contentWidth = self.activeVisitFormView.frame.size.width;
	[(UIScrollView *)profileApplicationViewController.view setContentSize:CGSizeMake(contentWidth, 1500.0)];
	profileApplicationViewController.detailItem = self.detailItem;
	self.currentController = profileApplicationViewController;
}

- (void)viewDidUnload
{
	[self setToolbar:nil];
	[self setActiveVisitFormView:nil];
	[self setProfileApplicationViewController:nil];
	[self setSummaryApplicationViewController:nil];
	[self setPhotoApplicationViewController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Menu";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    self.popoverController = nil;
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
    }
	
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
	
	if (self.detailItem) {
	    [profileApplicationViewController setDetailItem:self.detailItem];
		[summaryApplicationViewController setDetailItem:[(Producer *)self.detailItem dailySummary]];
		[notesApplicationViewController setDetailItem:[(Producer *)self.detailItem dailySummary]];
		[photoApplicationViewController setDetailItem:self.detailItem];
	}
}

@end
