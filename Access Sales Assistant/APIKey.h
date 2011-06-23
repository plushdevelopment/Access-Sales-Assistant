//
//  APIKey.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "NSString+AESCrypt.h"

@interface APIKey : NSObject {
    NSString *apiKey, *username, *password, *domain, *organization;
}
+ (NSString *)secretKey;
+ (APIKey *)sharedSingleton;

- (NSString *)getEncryptedParameter;

- (NSDictionary *) proxyForJson;

@end
