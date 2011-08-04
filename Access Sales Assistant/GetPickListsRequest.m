//
//  GetPickListsRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetPickListsRequest.h"

@implementation GetPickListsRequest

@synthesize context=_context;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		[self setNumberOfTimesToRetryOnTimeout:3];
		[self setQueuePriority:NSOperationQueuePriorityVeryHigh];
		[self addRequestHeader:@"Content-Type" value:@"application/json"];
    }
    
    return self;
}

- (void)requestFinished
{
	self.context = [NSManagedObjectContext contextForCurrentThread];
	
	NSString *responseString = [self responseString];
	NSArray *results = [responseString objectFromJSONString];
	for (NSDictionary *dict in results) {
		NSString *pickListType = [dict valueForKey:@"name"];
		NSArray *pickListItems = [dict objectForKey:@"pickList"];
		for (NSDictionary *itemDict in pickListItems) {
			NSManagedObject *item = [NSClassFromString(pickListType) ai_objectForProperty:@"uid" value:[itemDict valueForKey:@"uid"] managedObjectContext:self.context];
			[item safeSetValuesForKeysWithDictionary:itemDict dateFormatter:nil managedObjectContext:self.context];
		}
	}
	
	[self.context save:nil];
	[super requestFinished];
}

@end
