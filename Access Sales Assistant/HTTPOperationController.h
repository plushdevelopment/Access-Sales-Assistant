//
//  HTTPOperationController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "HUDNetworkQueue.h"

#define kUATURL @"https://uatmobile.accessgeneral.com/TsmServices/"
#define kDevURL @"http://devweb01.development.accessgeneral.com:82/"
#define kProdURL @"https://mobile.accessgeneral.com/TsmServices/"
#define kURL @"https://mobile.accessgeneral.com/TsmServices/"

#define kLoginURLUAT @"https://uatmobile.accessgeneral.com/SecurityServices/"
#define kLoginURLDev @"http://devweb01.development.accessgeneral.com:81/"
#define kLoginURLProd @"https://mobile.accessgeneral.com/SecurityServices/"
#define kLoginURL @"https://mobile.accessgeneral.com/SecurityServices/"

@interface HTTPOperationController : NSObject <ASIHTTPRequestDelegate>

@property (strong) HUDNetworkQueue *networkQueue;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (HTTPOperationController *)sharedHTTPOperationController;

- (void)synchronizeSchedule;

- (void)login;
- (void)loginRequestFinished:(ASIHTTPRequest *)request;
- (void)loginRequestFailed:(ASIHTTPRequest *)request;

- (void)logout;

- (void)refreshProducers;

- (void)requestPickLists;
- (void)requestPickListsFinished:(ASIHTTPRequest *)request;
- (void)requestPickListsFailed:(ASIHTTPRequest *)request;

- (void)requestCompetitors:(NSNumber *)page;
- (void)requestCompetitorsFinished:(ASIHTTPRequest *)request;
- (void)requestCompetitorsFailed:(ASIHTTPRequest *)request;

- (void)requestProducers:(NSNumber *)page;
- (void)requestProducersFinished:(ASIHTTPRequest *)request;
- (void)requestProducersFailed:(ASIHTTPRequest *)request;

- (void)postProducerProfile:(NSString *)profile;
- (void)postProducerProfileFinished:(ASIHTTPRequest *)request;
- (void)postProducerProfileFailed:(ASIHTTPRequest *)request;

- (void)postDailySummary:(NSString *)summary;
- (void)postDailySummaryFinished:(ASIHTTPRequest *)request;
- (void)postDailySummaryFailed:(ASIHTTPRequest *)request;

- (void)getImagesForProducer:(NSString *)producerID;
- (void)getImagesForProducerFinished:(ASIHTTPRequest *)request;
- (void)getImagesForProducerFailed:(ASIHTTPRequest *)request;

- (void)postImage:(UIImage *)image forProducer:(NSString *)producerID;
- (void)postImageForProducerFinished:(ASIHTTPRequest *)request;
- (void)postImageForProducerFailed:(ASIHTTPRequest *)request;

- (void)deleteImage:(NSString *)imageName forProducer:(NSString *)producerID;
- (void)deleteImageForProducerFinished:(ASIHTTPRequest *)request;
- (void)deleteImageForProducerFailed:(ASIHTTPRequest *)request;

- (void)getImage:(NSString *)urlString forProducer:(NSString *)producerID;
- (void)getImageFinished:(ASIHTTPRequest *)request;
- (void)getImageFailed:(ASIHTTPRequest *)request;

- (void)getTrainingVideos;
- (void)getTrainingVideosFinished:(ASIHTTPRequest*)request;
- (void)getTrainingVideosFailed:(ASIHTTPRequest*)request;

- (void)searchProducer:(NSString*)searchString;
- (void)searchProducerFinished:(ASIHTTPRequest*)request;
- (void)searchProducerFailed:(ASIHTTPRequest*)request;

- (void)getAUNTKsForProducer:(NSString *)producerCode;
- (void)getAUNTKsForProducerFinished:(ASIHTTPRequest*)request;
- (void)getAUNTKsForProducerFailed:(ASIHTTPRequest*)request;

- (void)postQAResolutionForm:(NSString*)qaResolutionForm;
- (void)postQAResolutionFormFinished:(ASIHTTPRequest*)request;
- (void)postQAResolutionFormFailed:(ASIHTTPRequest*)request;

- (void)deleteContact:(NSString *)contact;
- (void)deleteContactFinished:(ASIHTTPRequest *)request;
- (void)deleteContactFailed:(ASIHTTPRequest *)request;

-(NSString *) urlencode: (NSString *) url;

@end
