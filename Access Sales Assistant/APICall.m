//
//  APICall.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"


@implementation APICall

+ (void) checkTime {
	NSString *url = @"https://testmobile.accessgeneral.com/CrmServices/ProducerService/CurrentTime";
	
	[APICall executeCall:url params:@""];
	
	NSString *apiKey = @"{\"domain\":\"ACCESS\", \"username\":\"pbrennaman\", \"password\":\"@gyar911\", \"organization\":\"access\", \"apiKey\":\"9546482E-887A-4CAB-A403-AD9C326FFDA5\"}";
	NSLog(@"%@", [apiKey AES256EncryptWithKey:[APIKey secretKey]]);
	
	//apiKey = @"vRiDPZzzkyI8zyU021YuzVk2u3qS0ZFkn8dz3ESl3SApHoMU74igiwj4ZMSz/y55vUfWIjWnnz/+eEdsZzh+H4VXch3RcgB7srIgekTuV0TZ/KFkekPLzsmmAypdsBe0YCf6ss4mXBidMEjZXReDe9qh+oQwJwci0wTq3spMYeBrlTWoaHZGO3uqx5cpXKjC";
	//NSLog(@"%@", [apiKey AES256DecryptWithKey:[APIKey secretKey]]);
}


+ (void) executeCall:(NSString *)url params:(NSString *)params {
	NSString *completeUrl, *apiKey;
	
	//apiKey = [[APIKey sharedSingleton] getEncryptedParameter];
	apiKey = @"DH74bNyqifL780ryktI-MiGfC8-Anoe9RGBTcpHEDOMpi6zh1JDIKlD-wI05ZszBD3CBlyb0Yhxro_6a2snSJMGs35jiiytV5Xm2HR8rJMjgb90Fs7MdjNjlgAxnFlbIc-O1xEYwfZegiGwRhcd6W3iTR-JsE9yQOv5Gu4KN3VLjnpkAPhyF9rEnFQeN1dH80";
	completeUrl = [NSString stringWithFormat:@"%@?apiKey=%@&%@", url, apiKey, params];
	
	//NSLog(@"Key: %@", apiKey);
	//NSLog(@"Decrypt: %@", [apiKey AES256DecryptWithKey:[APIKey secretKey]]);
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString: completeUrl]];
	[request addRequestHeader:@"ContentType" value:@"application/json"];
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		//NSLog(@"Response: %@", response);
	}
	//NSLog(@"Error: %@", error);
}

@end
