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

#import "JSON.h"

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
		
		NSString * _key = @"wTGMqLubzizPgylAsHGgfPfLDoclQt+YAIzM1ugFMko=";
		
		StringEncryption *crypto = [[StringEncryption alloc] init];
		NSData *secretData = [[[self user] password] dataUsingEncoding:NSUTF8StringEncoding];
		CCOptions padding = kCCOptionPKCS7Padding;
		NSData *encryptedData = [crypto encrypt:secretData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
		NSString *encryptedString = [encryptedData base64EncodingWithLineLength:0];
		NSString *encryptedEncodedString = [encryptedString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSLog(@"Encrypted Login: %@", encryptedEncodedString);
		
		
		
		NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:81/STS/Authenticate?userName=%@&securePwd=%@&domain=%@&org=%@&apiKey=%@", self.user.username, encryptedString, self.user.domain, self.user.organization, self.user.serviceKey];
		NSURL *url = [NSURL URLWithString:urlString];
		ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
		[request setRequestMethod:@"GET"];
		[request addRequestHeader:@"Content-Type" value:@"application/json"];
		[request setDelegate:self];
		[request startAsynchronous];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSLog(@"Response String: %@", responseString);
	NSString *jsonString = [responseString JSONFragmentValue];
	
	NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)jsonString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
	
	self.user.token = encodedString;
	
	NSDictionary *userInfo = [[self.user entity] userInfo];
	for (NSString *attribute in userInfo) {
		NSLog(@"%@", attribute);
	}
	
	[self.managedObjectContext save];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[self showError:[error localizedDescription]];
	//[self dismissModalViewControllerAnimated:YES];
}

@end
