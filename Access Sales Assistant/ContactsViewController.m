//
//  ContactsViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactsViewController.h"

@implementation ContactsViewController

@synthesize toolBar=_toolBar;
@synthesize selectedContactOption;

#define EMAIL_SSC 0
#define EMAIL_CUSTOMER_SERVICE 1
#define EMAIL_NSF 2
#define EMAIL_PRODUCT 3
#define EMAIL_QA_FORM 4
#define EMAIL_FACILITIES 5
#define QA_RESOLUTION_TT 6
#define EMAIL_HELP_DESK 7
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


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Hello from California!"];
	NSString* toAddress =nil;
    
    switch(selectedContactOption)
    {
        case EMAIL_SSC:
            toAddress = @"ssc@accessgeneral.com";
            break;
        case EMAIL_CUSTOMER_SERVICE:
            toAddress = @"customer@accessgeneral.com";
            break;
        case EMAIL_NSF:
            toAddress = @"nsf@accessgeneral.com";
            break;
        case EMAIL_PRODUCT:
            toAddress = @"product@accessgeneral.com";
            break;
        case EMAIL_FACILITIES:
            toAddress = @"facilities@accessgeneral.com";
            break;
        case QA_RESOLUTION_TT:
            toAddress = @"timetable@accessgeneral.com";
            break;
        case EMAIL_HELP_DESK:
            toAddress = @"help@accessgeneral.com";
            break;
    
    }
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:toAddress]; 
		
	[picker setToRecipients:toRecipients];
	
	
	
	// Fill out the email body text
	NSString *emailBody = @"It is raining in sunny California!";
//	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
  //  [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
//	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
//			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
	//		message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
	//		message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
	//		message.text = @"Result: failed";
			break;
		default:
	//		message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void) launchMailComposer
{
    if(selectedContactOption == EMAIL_QA_FORM)
    {}
    else
    {
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
    }

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

@end
