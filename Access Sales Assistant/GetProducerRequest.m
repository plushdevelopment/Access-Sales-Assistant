//
//  GetProducerRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetProducerRequest.h"
#import "JSON.h"

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
	NSLog(@"%@", [self responseString]);
	self.context = [NSManagedObjectContext contextThatNotifiesDefaultContextOnMainThread];
	NSDictionary *responseJSON = [[self responseString] JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
	for (NSDictionary *dict in results) {
		@autoreleasepool {
			Producer *producer = [Producer findFirstByAttribute:@"uid" withValue:[dict valueForKey:@"uid"] inContext:self.context];
			if (!producer) {
				producer = [Producer createInContext:self.context];
				QuestionListItem *question = [QuestionListItem createInContext:self.context];
				[producer addQuestionsObject:question];
				HoursOfOperation *hours = [HoursOfOperation createInContext:self.context];
				[producer setHoursOfOperation:hours];
			}
			if (!producer.editedValue) {
				[producer safeSetValuesForKeysWithDictionary:dict dateFormatter:formatter managedObjectContext:self.context];
				// Calc schedule values
				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
				[dateFormatter setDateFormat:@"EEEE, MM-dd-yyyy"];
				producer.nextScheduledVisitDate = [dateFormatter stringFromDate:[producer nextScheduledVisit]];
				NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
				[timeFormatter setDateFormat:@"hh:mm a"];
				producer.nextScheduledVisitTime = [timeFormatter stringFromDate:[producer nextScheduledVisit]];
				producer.address = [NSString stringWithFormat:@"%@,%@", producer.latitude, producer.longitude];
				// Hours of Operation
				HoursOfOperation *hoursOfOperation = producer.hoursOfOperation;
				if (!hoursOfOperation) {
					hoursOfOperation = [HoursOfOperation createInContext:self.context];
					[producer setHoursOfOperation:hoursOfOperation];
				}
				NSAssert(hoursOfOperation, @"Hours of Operation is nil");
				[hoursOfOperation safeSetValuesForKeysWithDictionary:[dict valueForKey:@"hoursOfOperation"] dateFormatter:nil managedObjectContext:self.context];
				// Contacts
				NSArray *contactsArray = [dict valueForKey:@"contacts"];
				if (contactsArray.count > 0) {
					for (Contact *contact in producer.contacts) {
						[contact deleteInContext:self.context];
					}
					for (NSDictionary *contactDictionary in contactsArray) {
						Contact *contact = [Contact createInContext:self.context];
						[contact setProducer:producer];
						[contact safeSetValuesForKeysWithDictionary:contactDictionary dateFormatter:nil managedObjectContext:self.context];
					}
				}
			} else {
				NSLog(@"Producer has been editted:\n %@", [producer jsonStringValue]);
			}
		}
	}
	NSError *saveError = nil;
	[self.context save:&saveError];
	
	self.currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	self.totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	
	[super requestFinished];
}

@end
