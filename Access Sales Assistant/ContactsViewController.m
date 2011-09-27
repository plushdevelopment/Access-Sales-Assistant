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
@synthesize rootPopoverButtonItem;

#define EMAIL_SSC 0
#define EMAIL_CUSTOMER_SERVICE 1
#define EMAIL_NSF 2
#define EMAIL_PRODUCT 3
#define EMAIL_QA_FORM 4
#define EMAIL_FACILITIES 5
#define QA_RESOLUTION_TT 6
#define EMAIL_HELP_DESK 7

#define EMAIL_SSC_SUBJECT           @"Sales Compliance Request"
#define EMAIL_QA_SUBJECT            @"Quality Assurance Request"
#define EMAIL_NSF_SUBJECT           @"Insufficient Funds Request"
#define EMAIL_PRODUCT_SUBJECT       @"Competitive Update"
#define EMAIL_CUSTOMER_SUBJECT      @"Customer Service Request"
#define EMAIL_HELPDESK_SUBJECT      @"Help Desk Request"
#define EMAIL_FACILITIES_SUBJECT    @"Equipment Request"
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
	
	
	NSString* toAddress =nil;
    
    switch(selectedContactOption)
    {
        case EMAIL_SSC:
        {
            toAddress = @"ssc@access.com";
            [picker setSubject:EMAIL_SSC_SUBJECT];
            break;
        }
        case EMAIL_CUSTOMER_SERVICE:
        {
            toAddress = @"customer@access.com";
            [picker setSubject:EMAIL_CUSTOMER_SUBJECT];
            break;
        }
        case EMAIL_NSF:
        {
            toAddress = @"nsf@access.com";
            [picker setSubject:EMAIL_NSF_SUBJECT];
            break;
        }
        case EMAIL_PRODUCT:
        {
            toAddress = @"product@access.com";
            [picker setSubject:EMAIL_PRODUCT_SUBJECT];
            break;
        }
        case EMAIL_FACILITIES:
        {
            toAddress = @"facilities@access.com";
            [picker setSubject:EMAIL_FACILITIES_SUBJECT];
            break;
        }
        case QA_RESOLUTION_TT:
        {
            toAddress = @"timetable@access.com";
            break;
        }
        case EMAIL_HELP_DESK:
        {
            toAddress = @"help@access.com";
            [picker setSubject:EMAIL_HELPDESK_SUBJECT];
            break;
        }
    
    }
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:toAddress]; 
		
	[picker setToRecipients:toRecipients];
	
	
	
	// Fill out the email body text
	NSString *emailBody = @"";
    
    [picker setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [picker setModalPresentationStyle:UIModalPresentationFormSheet];
	[picker setMessageBody:emailBody isHTML:NO];
	//[picker SETM
	[self presentModalViewController:picker animated:YES];
  //  [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
//	message.hidden = NO;
	// Notifies users about errors associated with the interface
    
    NSString* message = @"";
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message = @"Result: failed";
			break;
		default:
			message = @"Result: not sent";
			break;
	}
  //  [self showAlert:message];
    
   // [self showRootPopoverButtonItem:rootPopoverButtonItem];
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;//[[UIDevice currentDevice] orientation];
    
	// if(orientation == 0)
	//     orientation = self.detailViewController.interfaceOrientation;
    
    if(UIDeviceOrientationIsPortrait(orientation))
    {
		
		[self showRootPopoverButtonItem:rootPopoverButtonItem];
		
    }
    else
        [self invalidateRootPopoverButtonItem:rootPopoverButtonItem];

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
