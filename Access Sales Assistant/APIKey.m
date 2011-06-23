//
//  APIKey.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APIKey.h"


@implementation APIKey

// Returns the encrypted parameter needed for all api requests
- (NSString *)getEncryptedParameter {
	NSString *json;
	
	json = [NSString stringWithFormat:@"{ \"apiKey\":\"%@\", \"domain\":\"%@\", \"organization\":\"%@\", \"password\":\"%@\", \"username\":\"%@\" }",
			apiKey, domain, organization, password, username];
	
	return [json AES256EncryptWithKey:[APIKey secretKey]];
}

- (NSDictionary *) proxyForJson {
	NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
	
	[dict setValue:apiKey forKey:@"apiKey"];
	[dict setValue:domain forKey:@"domain"];
	[dict setValue:organization forKey:@"organization"];
	[dict setValue:password forKey:@"password"];
	[dict setValue:username forKey:@"username"];
	
	return dict;
}

// Secret Key
+ (NSString *)secretKey {
	return @"wTGMqLubzizPgylAsHGgfPfLDoclQt+YAIzM1ugFMko=";
}

// Singleton Management
static APIKey* _sharedSingleton = nil;
+(APIKey *)sharedSingleton {
	@synchronized([APIKey class]) {
		if(!_sharedSingleton) {
			[[self alloc] init];
		}
		
		return _sharedSingleton;
	}
	
	return nil;
}

+(id)alloc {
	@synchronized([APIKey class]) {
		NSAssert(_sharedSingleton ==nil, @"Attempted to allocate a second APIKey object");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
	
	return nil;
}

- (id) init {
	self = [super init];
	if(self != nil) {
		// initialize here
		apiKey = @"9546482E-887A-4CAB-A403-AD9C326FFDA5";
		
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		username = [defaults valueForKey:@"Username"];
		password = [defaults valueForKey:@"Password"];
		domain = [defaults valueForKey:@"Domain"];
		organization = [defaults valueForKey:@"Organization"];
	}
	
	return self;
}

- (void) dealloc {
	[apiKey release];
	[username release];
	[password release];
	[domain release];
	[organization release];
	
	[super dealloc];
}
@end
