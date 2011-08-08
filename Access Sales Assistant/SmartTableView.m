//
//  SmartTableView.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SmartTableView.h"

@implementation SmartTableView

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:@selector(keyboardDidShow:) 
					   name:UIKeyboardDidShowNotification object:nil];
		[center addObserver:self selector:@selector(keyboardWillHide:) 
					   name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
    if (self) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:@selector(keyboardDidShow:) name:@"Picker Did Show" object:nil];
		[center addObserver:self selector:@selector(keyboardWillHide:) name:@"Picker Will Hide" object:nil];
	}
	
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
	// keyboard frame is in window coordinates
	NSDictionary *userInfo = [notification object];
	CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	
	// convert own frame to window coordinates, frame is in superview's coordinates
	CGRect ownFrame = [self.window convertRect:self.frame fromView:self.superview];
	
	// calculate the area of own frame that is covered by keyboard
	CGRect coveredFrame = CGRectIntersection(ownFrame, keyboardFrame);
	
	// now this might be rotated, so convert it back
	coveredFrame = [self.window convertRect:coveredFrame toView:self.superview];
	
	// set inset to make up for covered array at bottom
	self.contentInset = UIEdgeInsetsMake(self.contentInset.top, self.contentInset.left, coveredFrame.size.height, 0);
	self.scrollIndicatorInsets = self.contentInset;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	self.scrollIndicatorInsets = self.contentInset;
}

@end
