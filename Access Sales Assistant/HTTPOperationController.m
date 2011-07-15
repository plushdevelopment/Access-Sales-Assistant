//
//  HTTPOperationController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HTTPOperationController.h"

#import "SynthesizeSingleton.h"

#import "ASINetworkQueue.h"

#import "ASIHTTPRequest.h"

#import "ASIFormDataRequest.h"

#import "JSON.h"

#import "NSData+Base64.h"

#import "StringEncryption.h"

#import "User.h"

#import "Producer.h"

#import "Status.h"

#import "SuspensionReason.h"

#import "IneligibleReason.h"

#import "Rater.h"

#import "Rater2.h"

#import "SubTerritory.h"

#import "QuestionListItem.h"

#import "State.h"

#import "PhoneListItem.h"

#import "HoursOfOperation.h"

#import "EmailListItem.h"

#import "Contact.h"

#import "AddressListItem.h"

#define kPAGESIZE 1

@implementation HTTPOperationController

@synthesize networkQueue=_networkQueue;

@synthesize managedObjectContext = managedObjectContext_;

SYNTHESIZE_SINGLETON_FOR_CLASS(HTTPOperationController);

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		self.managedObjectContext = [NSManagedObjectContext defaultContext];
		
        // Create the network queue and initialize property
		[self setNetworkQueue:[ASINetworkQueue queue]];
		[[self networkQueue] setDelegate:self];
		[[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
		[[self networkQueue] setRequestDidStartSelector:@selector(requestDidStart:)];;
		[[self networkQueue] setShouldCancelAllRequestsOnFailure:NO];
		[[self networkQueue] go];
    }
    
    return self;
}

#pragma mark -
#pragma mark ASIHTTPRequest Delegate Methods


- (void)requestFinished:(ASIHTTPRequest *)request
{
	//... Handle finished notification
	//NSLog(@"Request did finish");
}


- (void)requestFailed:(ASIHTTPRequest *)request
{
	//... Handle fail notification
	//NSLog(@"Request did fail");
}


- (void)requestDidStart:(id)request
{
	//... Handle start notification
	//NSLog(@"Request did start");
}


- (void)queueFinished:(ASINetworkQueue *)queue
{
	[[self networkQueue] setSuspended:YES];
	//NSLog(@"Queue finished");
}


#pragma mark -
#pragma mark Specific Requests

// Authenticate
- (void)login
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString * _key = @"wTGMqLubzizPgylAsHGgfPfLDoclQt+YAIzM1ugFMko=";
	StringEncryption *crypto = [[StringEncryption alloc] init];
	NSData *secretData = [[user password] dataUsingEncoding:NSUTF8StringEncoding];
	CCOptions padding = kCCOptionPKCS7Padding;
	NSData *encryptedData = [crypto 
							 encrypt:secretData
							 key:[_key dataUsingEncoding:NSUTF8StringEncoding]
							 padding:&padding];
	
	NSString *encryptedString = [encryptedData base64EncodingWithLineLength:0];
	NSString *urlString = [NSString 
						   stringWithFormat:@"http://devweb01.development.accessgeneral.com:81/STS/Authenticate?userName=%@&securePwd=%@&domain=%@&org=%@&apiKey=%@",
						   [user username],
						   encryptedString,
						   [user domain],
						   [user organization],
						   [user serviceKey]];
	
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"GET"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(loginRequestFinished:)];
	[request setDidFailSelector:@selector(loginRequestFailed:)];
	[[self networkQueue] addOperation:request];
}

- (void)loginRequestFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSString *jsonString = [responseString JSONFragmentValue];
	NSString * encodedString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)jsonString, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
	User *user = [User findFirst];
	user.token = encodedString;
	[self.managedObjectContext save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Login Successful" object:request];
	
	[self requestPickLists];
}

- (void)loginRequestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Login Failure" object:request];
}

// Pick Lists
- (void)requestPickLists
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString 
						   stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/VisitApplicationService/Picklists?token=%@",
						   [user token]];
	
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"GET"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestPickListsFinished:)];
	[request setDidFailSelector:@selector(requestPickListsFailed:)];
	[[self networkQueue] addOperation:request];
}

- (void)requestPickListsFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSArray *results = [responseString JSONValue];
	for (NSDictionary *dict in results) {
		NSString *pickListType = [dict valueForKey:@"name"];
		NSArray *pickListItems = [dict objectForKey:@"pickList"];
		for (NSDictionary *itemDict in pickListItems) {
			NSManagedObject *item = [NSClassFromString(pickListType) ai_objectForProperty:@"uid" value:[itemDict valueForKey:@"uid"]];
			[item safeSetValuesForKeysWithDictionary:itemDict dateFormatter:nil];
		}
	}
	
	[self.managedObjectContext save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PickList Successful" object:request];
	
	[self requestProducers:1 pageSize:kPAGESIZE];
}

- (void)requestPickListsFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PickList Failure" object:request];
}

// Get Producers
- (void)requestProducers:(NSInteger)page pageSize:(NSInteger)size
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/ProducerService/Producers?pageNbr=%d&pageSize=%d&partialLoad=false&token=%@", page, size, [user token]];
	//NSLog(@"%@", urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"GET"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestProducersFinished:)];
	[request setDidFailSelector:@selector(requestProducersFailed:)];
	[[self networkQueue] addOperation:request];
}

- (void)requestProducersFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSDictionary *responseJSON = [responseString JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	for (NSDictionary *dict in results) {
		Producer *producer = [Producer ai_objectForProperty:@"uid" value:[dict valueForKey:@"uid"]];
		if (!producer.editedValue) {
			[producer safeSetValuesForKeysWithDictionary:dict dateFormatter:formatter];
		}
		
	}
	//[self.managedObjectContext saveOnBackgroundThread];
	[self.managedObjectContext save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Producers Successful" object:request];
	
	NSInteger currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	NSInteger totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	if (currentPage < totalPages) {
		currentPage++;
		[self requestProducers:currentPage pageSize:kPAGESIZE];
	}
}

- (void)requestProducersFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Producers Failure" object:request];
	[[self networkQueue] addOperation:request];
}

// Post Producer
- (void)postProducerProfile:(NSString *)profile
{
	NSLog(@"%@", profile);
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/VisitApplicationService/Producers?token=%@", [user token]];
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"POST"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(postProducerProfileFinished:)];
	[request setDidFailSelector:@selector(postProducerProfileFailed:)];
	[request setPostBody:[NSMutableData dataWithData:[profile dataUsingEncoding:NSASCIIStringEncoding]]];
	[[self networkQueue] addOperation:request];
}

- (void)postProducerProfileFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSDictionary *responseJSON = [responseString JSONValue];
	Producer *producer = [Producer ai_objectForProperty:@"uid" value:[responseJSON valueForKey:@"uid"]];
	producer.editedValue = NO;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	[producer safeSetValuesForKeysWithDictionary:responseJSON dateFormatter:formatter];
	[self.managedObjectContext save];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Producer Successful" object:request];
}

- (void)postProducerProfileFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Producer Failure" object:request];
	//[[self networkQueue] addOperation:request];
}

@end
