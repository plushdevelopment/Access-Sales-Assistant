//
//  GetProducerRequest.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"

@interface GetProducerRequest : ASIHTTPRequest

@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger totalPages;

@end
