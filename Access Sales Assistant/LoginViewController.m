//
//  LoginViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

#import "NSData+Base64.h"

#import "StringEncryption.h"

#import "ASIFormDataRequest.h"

@implementation LoginViewController

@synthesize domainField=_domainField;

@synthesize usernameField=_usernameField;

@synthesize passwordField=_passwordField;

@synthesize organizationField=_organizationField;

@synthesize serviceKeyField=_apiKeyField;

@synthesize user=_user;

@synthesize managedObjectContext=_managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.managedObjectContext = [NSManagedObjectContext defaultContext];
		self.user = [User findFirst];
		if (!self.user) {
			self.user = [User createEntity];
		}
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
    [super viewDidUnload];
    [self.managedObjectContext save];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)showError:(NSString *)message
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: @"OK", nil];
	[alertView show];
	[alertView release];

}

- (IBAction)submitLogin:(id)sender
{
	if (self.domainField.text.length == 0) {
		[self showError:@"Please enter a Domain"];
	} else if (self.usernameField.text.length == 0) {
		[self showError:@"Please enter a Username"];
	} else if (self.passwordField.text.length == 0) {
		[self showError:@"Please enter a Password"];
	} else if (self.organizationField.text.length == 0) {
		[self showError:@"Please enter an Organization"];
	} else if (self.serviceKeyField.text.length == 0) {
		[self showError:@"Please enter a Service Key"];

	} else {
		[[self user] setDomain:self.domainField.text];
		[[self user] setUsername:self.usernameField.text];
		[[self user] setPassword:self.passwordField.text];
		[[self user] setOrganization:self.organizationField.text];
		[[self user] setServiceKey:self.serviceKeyField.text];
		NSString *jsonString = [[self user] jsonStringValue];
		NSLog(@"%@", jsonString);
		NSString * _key = @"wTGMqLubzizPgylAsHGgfPfLDoclQt+YAIzM1ugFMko=";
		
		StringEncryption *crypto = [[StringEncryption alloc] init];
		NSData *secretData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
		CCOptions padding = kCCOptionPKCS7Padding;
		NSData *encryptedData = [crypto encrypt:secretData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
		NSString *encryptedString = [encryptedData base64EncodingWithLineLength:0];
		NSLog(@"Encrypted Login: %@", encryptedString);
		
		NSString *urlString = [NSString stringWithFormat:@"https://accessgeneral.com/app/"];
		NSURL *url = [NSURL URLWithString:urlString];
		ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
		[request setPostValue:encryptedString forKey:@"apiKey"];
		[request setDelegate:self];
		[request startAsynchronous];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSLog(@"Response String: %@", responseString);
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	// Uncomment this once login mechanism is in place 
	/*
	[self showError:[error localizedDescription];];
	*/
	
	// Remove this once login mechanism is in place
	[self dismissModalViewControllerAnimated:YES];
}

@end
