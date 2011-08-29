//
//  GetProducerRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetProducerRequest.h"

#import "JSON.h"

#import "Producer.h"

#import "AddressListItem.h"

#import "State.h"

@implementation GetProducerRequest

@synthesize currentPage=_currentPage;

@synthesize totalPages=_totalPages;

@synthesize context=_context;

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	if (self) {
		_currentPage = 0;
		_totalPages = 0;
		[self addRequestHeader:@"Content-Type" value:@"application/json"];
		[self setNumberOfTimesToRetryOnTimeout:3];
		[self setQueuePriority:NSOperationQueuePriorityLow];
	}
	return self;
}

- (void)requestFinished
{
	self.context = [NSManagedObjectContext contextThatNotifiesDefaultContextOnMainThread];
	NSDictionary *responseJSON = [[self responseString] JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
	for (NSDictionary *dict in results) {
		
			Producer *producer = [Producer ai_objectForProperty:@"uid"
														  value:[dict valueForKey:@"uid"] 
										   managedObjectContext:self.context];
			if (!producer.editedValue) {
				[producer safeSetValuesForKeysWithDictionary:dict dateFormatter:formatter managedObjectContext:self.context];
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"EEEE, MM-dd-yyyy"];
				producer.nextScheduledVisitDate = [dateFormatter stringFromDate:[producer nextScheduledVisit]];
				//NSLog(@"%@", producer.nextScheduledVisitDate);
				//NSLog(@"%@", producer.nextScheduledVisitTime);
				NSLog(@"%@", [producer.nextScheduledVisit debugDescription]);
				NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
				[timeFormatter setDateFormat:@"hh:mm a"];
				producer.nextScheduledVisitTime = [timeFormatter stringFromDate:[producer nextScheduledVisit]];
				producer.address = [NSString stringWithFormat:@"%@,%@", producer.latitude, producer.longitude];
			}
	}
	NSError *saveError = nil;
	[self.context save:&saveError];
	
	self.currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	self.totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	
	[super requestFinished];
}

@end
