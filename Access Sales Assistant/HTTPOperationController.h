//
//  HTTPOperationController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"

@class ASINetworkQueue;
@class User;

@interface HTTPOperationController : NSObject <ASIHTTPRequestDelegate>

@property (strong) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (HTTPOperationController *)sharedHTTPOperationController;

- (void)login;
- (void)loginRequestFinished:(ASIHTTPRequest *)request;
- (void)loginRequestFailed:(ASIHTTPRequest *)request;
- (void)requestPickLists;
- (void)requestPickListsFinished:(ASIHTTPRequest *)request;
- (void)requestPickListsFailed:(ASIHTTPRequest *)request;
- (void)requestProducers:(NSInteger)page pageSize:(NSInteger)size;
- (void)requestProducersFinished:(ASIHTTPRequest *)request;
- (void)requestProducersFailed:(ASIHTTPRequest *)request;
- (void)postProducerProfile:(NSString *)profile;
- (void)postProducerProfileFinished:(ASIHTTPRequest *)request;
- (void)postProducerProfileFailed:(ASIHTTPRequest *)request;

@end
