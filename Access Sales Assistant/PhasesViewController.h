//
//  PhasesViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PhasesViewController : UIViewController {
	IBOutlet UIView *contentView;
	IBOutlet UIWebView *pageContentWebView;
}

@end
