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
	}
	return self;
}

- (void)requestFinished
{
	self.context = [NSManagedObjectContext contextForCurrentThread];
	NSDictionary *responseJSON = [[self responseString] JSONValue];
	NSArray *results = [responseJSON objectForKey:@"results"];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	for (NSDictionary *dict in results) {
		
			Producer *producer = [Producer ai_objectForProperty:@"uid"
														  value:[dict valueForKey:@"uid"] 
										   managedObjectContext:self.context];
			if (!producer.editedValue) {
				[producer safeSetValuesForKeysWithDictionary:dict
											   dateFormatter:formatter managedObjectContext:self.context];
			}
	}
	[self.context save:nil];
	
	self.currentPage = [[responseJSON valueForKey:@"currentPage"] integerValue];
	self.totalPages = [[responseJSON valueForKey:@"totalPages"] integerValue];
	
	[super requestFinished];
}

@end
