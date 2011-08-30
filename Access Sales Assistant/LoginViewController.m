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

#import "HTTPOperationController.h"

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
	 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinished:) name:@"Login Successful" object:nil];
	if (self.user.domain.length > 0)
		self.domainField.text = self.user.domain;
	if (self.user.username.length > 0)
		self.usernameField.text = self.user.username;
	if (self.user.password.length > 0)
		self.passwordField.text = self.user.password;
	if (self.user.organization.length > 0)
		self.organizationField.text = self.user.organization;
	if (self.user.serviceKey.length > 0)
		self.serviceKeyField.text = self.user.serviceKey;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.managedObjectContext save];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
		NSString * _key = @"wTGMqLubzizPgylAsHGgfPfLDoclQt+YAIzM1ugFMko=";
		
		StringEncryption *crypto = [[StringEncryption alloc] init];
		NSData *secretData = [self.passwordField.text dataUsingEncoding:NSUTF8StringEncoding];
		CCOptions padding = kCCOptionPKCS7Padding;
		NSData *encryptedData = [crypto encrypt:secretData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
		NSString *encryptedString = [encryptedData base64EncodingWithLineLength:0];
		NSString *encryptedEncodedString = [self urlencode:encryptedString];
		NSLog(@"Encrypted Login: %@", encryptedEncodedString);
		[[self user] setPassword:encryptedEncodedString];
		[[self user] setOrganization:self.organizationField.text];
		[[self user] setServiceKey:self.serviceKeyField.text];
		[self.managedObjectContext save];
		
		NSString *urlString = [NSString stringWithFormat:@"https://uatmobile.accessgeneral.com/SecurityServices/STS/Authenticate?userName=%@&securePwd=%@&domain=%@&org=%@&apiKey=%@", self.user.username, self.user.password, self.user.domain, self.user.organization, self.user.serviceKey];
		NSURL *url = [NSURL URLWithString:urlString];
		ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
		[request setRequestMethod:@"GET"];
		[request addRequestHeader:@"Content-Type" value:@"application/json"];
		[request setTimeOutSeconds:60];
		[request setDelegate:self];
		[request startAsynchronous];
        
        
		 
	}
}

- (void)loginFinished:(ASIHTTPRequest *)request
{
	//if(request!=nil)
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Login Success" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Launch Map" object:nil];
    [self dismissModalViewControllerAnimated:YES];
    
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
	[[HTTPOperationController sharedHTTPOperationController] requestPickLists];
	[self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Launch Map" object:nil];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[self showError:[error localizedDescription]];
	//[self dismissModalViewControllerAnimated:YES];
}

-(NSString *) urlencode: (NSString *) url
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,
                            @"$" , @"," , @"[" , @"]",
                            @"#", @"!", @"'", @"(", 
                            @")", @"*", @" ",nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F" , @"%3F" ,
                             @"%3A" , @"%40" , @"%26" ,
                             @"%3D" , @"%2B" , @"%24" ,
                             @"%2C" , @"%5B" , @"%5D", 
                             @"%23", @"%21", @"%27",
                             @"%28", @"%29", @"%2A", @"%20",nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [url mutableCopy];
    
    int i;
    for(i = 0; i < len; i++)
    {
        
        [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *out = [NSString stringWithString: temp];
    
    return out;
}

@end
