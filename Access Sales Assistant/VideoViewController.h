//
//  VideoViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,strong) IBOutlet UIWebView *webView;

- (IBAction)doneButtonPress:(id)sender;

@end
