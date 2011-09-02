//
//  HUDNetworkQueue.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HUDNetworkQueue.h"

#import "Access_Sales_AssistantAppDelegate.h"

#import "MBProgressHUD.h"

@implementation HUDNetworkQueue

@synthesize hud=_hud;

- (Access_Sales_AssistantAppDelegate *)sharedAppDelegate
{
	return (Access_Sales_AssistantAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)go
{
	[super go];
	self.hud = [MBProgressHUD showHUDAddedTo:[[self sharedAppDelegate] window] animated:YES];
	self.hud.labelText = @"Loading";
	self.hud.detailsLabelText = @"updating data";
	self.hud.dimBackground = YES;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	[super requestFinished:request];
	if ([self requestsCount] == 0) {
		[self.hud hide:YES];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	[super requestFailed:request];
	if ([self requestsCount] == 0) {
		[self.hud hide:YES];
	}
}

@end
