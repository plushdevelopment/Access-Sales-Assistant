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

#import "DailySummary.h"

#import "ProducerImage.h"

#import "NSManagedObject+Lidenbrock.h"

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
	NSLog(@"%@", urlString);
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
			/*
			NSManagedObject *item = [NSClassFromString(pickListType) entityFromJson:dict.description];
			NSLog(@"%@", item);
			 */
		}
	}
	
	[self.managedObjectContext save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PickList Successful" object:request];
	NSNumber *page = [NSNumber numberWithInt:1];
	[self requestProducers:page];
}

- (void)requestPickListsFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PickList Failure" object:request];
}

// Get Producers
- (void)requestProducers:(NSNumber *)page
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/ProducerService/Producers?pageNbr=%d&pageSize=%d&partialLoad=false&token=%@", [page integerValue], kPAGESIZE, [user token]];
	NSLog(@"%@", urlString);
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
	
	[self.managedObjectContext save];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Producers Successful" object:request];
	
	NSInteger currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	NSInteger totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	if (currentPage < totalPages) {
		currentPage++;
		[self performSelector:@selector(requestProducers:) withObject:[NSNumber numberWithInteger:currentPage] afterDelay:2];
	}
}

- (void)requestProducersFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Producers Failure" object:request];
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

// Post Daily Summary
- (void)postDailySummary:(NSString *)summary
{
	NSLog(@"%@", summary);
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/VisitApplicationService/DailySummaryReports?token=%@", [user token]];
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"POST"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(postDailySummaryFinished:)];
	[request setDidFailSelector:@selector(postDailySummaryFailed:)];
	[request setPostBody:[NSMutableData dataWithData:[summary dataUsingEncoding:NSASCIIStringEncoding]]];
	[[self networkQueue] addOperation:request];
}

- (void)postDailySummaryFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSDictionary *responseJSON = [responseString JSONValue];
	Producer *producer = [Producer ai_objectForProperty:@"uid" value:[responseJSON valueForKeyPath:@"producerId.uid"]];
	producer.dailySummary.editedValue = NO;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	[producer.dailySummary safeSetValuesForKeysWithDictionary:responseJSON dateFormatter:formatter];
	[self.managedObjectContext save];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Summary Successful" object:request];
}

- (void)postDailySummaryFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Summary Failure" object:request];
	//[[self networkQueue] addOperation:request];
}

// Post Image for Producer
- (void)postImage:(UIImage *)image forProducer:(NSString *)producerID
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *imageName = [NSString stringWithFormat:@"%@_%d.png", producerID, [image hash]];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/VisitApplicationService/Producers/%@/Images?fileName=%@&token=%@", producerID, imageName, [user token]];
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"POST"];
	NSData *tempData = UIImageJPEGRepresentation(image, 2.0);
	NSMutableData *imageData = [NSMutableData dataWithData:tempData];
	[request setPostBody:imageData];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(postImageForProducerFinished:)];
	[request setDidFailSelector:@selector(postImageForProducerFailed:)];
	[[self networkQueue] addOperation:request];
}

- (void)postImageForProducerFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Image Successful" object:request];
}

- (void)postImageForProducerFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Post Image Failure" object:request];
}

// Get Image for Producer
- (void)getImagesForProducer:(NSString *)producerID
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	User *user = [User findFirst];
	NSString *urlString = [NSString stringWithFormat:@"http://devweb01.development.accessgeneral.com:82/VisitApplicationService/Producers/%@/Images?token=%@", producerID, [user token]];
	NSLog(@"%@", urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"GET"];
	[request addRequestHeader:@"Content-Type" value:@"application/json"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(getImagesForProducerFinished:)];
	[request setDidFailSelector:@selector(getImagesForProducerFailed:)];
	NSDictionary *userInfoDict = [NSDictionary dictionaryWithObjectsAndKeys:producerID, @"producerUID", nil];
	[request setUserInfo:userInfoDict];
	[[self networkQueue] addOperation:request];
}

- (void)getImagesForProducerFinished:(ASIHTTPRequest *)request
{
	NSString *responseString = [request responseString];
	NSString *escapedString = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
	NSArray *responseJSON = [escapedString JSONValue];
	if (responseJSON) {
		NSLog(@"%@", responseJSON);
		for (NSDictionary *dict in responseJSON) {
			NSString *producerUID = [[request userInfo] valueForKey:@"producerID"];
			[self getImage:[dict valueForKey:@"url"] forProducer:producerUID];
		}
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Get Images Successful" object:request];
}

- (void)getImagesForProducerFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Get Images Failure" object:request];
}

// Get Image
- (void)getImage:(NSString *)urlString forProducer:(NSString *)producerID
{
	if ([[self networkQueue] isSuspended]) {
		[[self networkQueue] go];
	}
	
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setRequestMethod:@"GET"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(getImageFinished:)];
	[request setDidFailSelector:@selector(getImageFailed:)];
	//[[request userInfo] setValue:producerID forKey:@"producerUID"];
	
	NSArray *pathComps = [urlString pathComponents];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *imagePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [pathComps lastObject]]];
	[request setDownloadDestinationPath:imagePath];
	
	[[self networkQueue] addOperation:request];
}

- (void)getImageFinished:(ASIHTTPRequest *)request
{
	NSString *urlString = [[request url] absoluteString];
	NSArray *pathComps = [urlString pathComponents];
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *imagePath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [pathComps lastObject]]];
	NSArray *producerIDStringArray = [[pathComps lastObject] componentsSeparatedByString:@"_"];
	NSString *producerUID;
	if (producerIDStringArray.count > 1)
		producerUID = [producerIDStringArray objectAtIndex:0];
	NSLog(@"%@", producerUID);
	Producer *producer = [Producer findFirstByAttribute:@"uid" withValue:producerUID];
	ProducerImage *image = [ProducerImage ai_objectForProperty:@"imagePath" value:imagePath];
	
	if (![producer.images containsObject:image]) {
		[producer addImagesObject:image];
	}
	
	NSString *responseString = [request responseString];
	NSData *responseData = [request responseData];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Get Image Successful" object:request];
}

- (void)getImageFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"Request Error: %@", [error localizedDescription]);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Get Image Failure" object:request];
}

@end
