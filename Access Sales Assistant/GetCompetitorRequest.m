//
//  GetCompetitorRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetCompetitorRequest.h"

#import "JSON.h"

#import "Competitor.h"

@implementation GetCompetitorRequest

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
		[self setQueuePriority:NSOperationQueuePriorityVeryLow];
	}
	return self;
}

- (void)requestFinished
{
	self.context = [NSManagedObjectContext contextForCurrentThread];
	NSDictionary *responseJSON = [[self responseString] JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	for (NSDictionary *dict in results) {
		
		Competitor *competitor = [Competitor ai_objectForProperty:@"uid"
													  value:[dict valueForKey:@"uid"] 
									   managedObjectContext:self.context];
		if (!competitor.editedValue) {
			[competitor safeSetValuesForKeysWithDictionary:dict
										   dateFormatter:nil managedObjectContext:self.context];
		}
	}
	[self.context save:nil];
	
	self.currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	self.totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	
	[super requestFinished];
}

@end
