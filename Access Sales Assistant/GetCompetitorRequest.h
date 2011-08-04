//
//  GetCompetitorRequest.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"

@interface GetCompetitorRequest : ASIHTTPRequest

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPages;
@property (atomic, strong) NSManagedObjectContext *context;

@end
