//
//  APICall.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIKey.h"
#import "ASIHTTPRequest.h"


@interface APICall : NSObject {
    
}

+ (void) checkTime;

+ (void) executeCall:(NSString *)url params:(NSString *)params;

@end
