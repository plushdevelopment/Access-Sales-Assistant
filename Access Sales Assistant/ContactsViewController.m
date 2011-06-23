//
//  ContactsViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactsViewController.h"


@implementation ContactsViewController

- (IBAction)closeModal:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)emailButton:(id)sender {
	UIButton *button;
	// Make sure the sender is a button
	if([sender isKindOfClass:[UIButton class]]) {
		button = (UIButton *)sender;
	} else {
		return;
	}
	
	NSString *emailAddress, *emailBody=nil;
	
	switch (button.tag) {
		case 0:
			emailAddress = @"ssc@accessgeneral.com";
			break;
		case 1:
			emailAddress = @"product@accessgeneral.com";
			break;
		case 2:
			emailAddress = @"qarequest@accessgeneral.com";
			emailBody = @"Policy Number: \nProducer Information:\n\nRequest:";
			break;
		case 3:
			emailAddress = @"customerservice@accessgeneral.com";
			break;
		case 4:
			emailAddress = @"helpdesk@accessgeneral.com";
			break;
		default:
			return;
	}
	
	// Make sure mail is available
	if ([MFMailComposeViewController canSendMail] == NO) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Unavailable" message:@"This device does not support email, so this action cannot be performed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		[alert release];
		return;
	}
	
	MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
	mailViewController.mailComposeDelegate = self;
	
	[mailViewController setToRecipients:[NSArray arrayWithObject:emailAddress]];
	
	if (emailBody != nil) {
		[mailViewController setMessageBody:emailBody isHTML:NO];
	}
	
	[self presentModalViewController:mailViewController animated:YES];
	[mailViewController release];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
	[self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
