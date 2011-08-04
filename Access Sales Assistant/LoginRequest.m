//
//  LoginRequest.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginRequest.h"

#import "JSON.h"

#import "User.h"

@implementation LoginRequest

@synthesize context=_context;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		[self addRequestHeader:@"Content-Type" value:@"application/json"];
		[self setNumberOfTimesToRetryOnTimeout:3];
		[self setQueuePriority:NSOperationQueuePriorityVeryHigh];
    }
    
    return self;
}

@end
