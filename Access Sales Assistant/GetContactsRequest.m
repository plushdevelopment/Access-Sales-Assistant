//
//  GetContactsRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetContactsRequest.h"

#import "JSON.h"

#import "Contact.h"

@implementation GetContactsRequest

@synthesize context=_context;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		[self setNumberOfTimesToRetryOnTimeout:3];
		[self setQueuePriority:NSOperationQueuePriorityVeryLow];
		[self addRequestHeader:@"Content-Type" value:@"application/json"];
    }
    
    return self;
}

- (void)requestFinished
{
	self.context = [NSManagedObjectContext contextThatNotifiesDefaultContextOnMainThread];
	
	NSDictionary *responseJSON = [[self responseString] JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	for (NSDictionary *dict in results) {
		
		Contact *competitor = [Contact ai_objectForProperty:@"uid"
															value:[dict valueForKey:@"uid"] 
											 managedObjectContext:self.context];
		if (!competitor.editedValue) {
			[competitor safeSetValuesForKeysWithDictionary:dict
											 dateFormatter:nil managedObjectContext:self.context];
		}
	}
	
	[self.context save:nil];
	[super requestFinished];
}

@end
