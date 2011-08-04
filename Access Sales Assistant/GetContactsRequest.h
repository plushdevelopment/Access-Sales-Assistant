//
//  GetContactsRequest.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"

@interface GetContactsRequest : ASIHTTPRequest

@property (atomic, strong) NSManagedObjectContext *context;

@end
