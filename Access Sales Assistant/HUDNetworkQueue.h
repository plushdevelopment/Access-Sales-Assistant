//
//  HUDNetworkQueue.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASINetworkQueue.h"

@class Access_Sales_AssistantAppDelegate;

@class MBProgressHUD;

@interface HUDNetworkQueue : ASINetworkQueue

@property (strong, nonatomic) MBProgressHUD *hud;

- (Access_Sales_AssistantAppDelegate *)sharedAppDelegate;

@end
