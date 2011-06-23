//
//  DataManagementController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APICall.h"

@interface DataManagementController : NSObject {
	
}
+ (DataManagementController*)sharedSingleton;

- (void)checkLoginCredentials: (UIViewController *) view;
- (void)displayLoginFormModalOnView: (UIViewController *) view;

@end
