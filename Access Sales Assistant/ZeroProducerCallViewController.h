//
//  ZeroProducerCallViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZeroProducerCallViewController : UIViewController {
    IBOutlet UIScrollView *contentScrollView;
    IBOutlet UIButton *overviewTab, *salesPitchTab, *closeTab;
	IBOutlet UIView *overviewView, *salesPitchView, *closeView;
	IBOutlet UIWebView *overviewContent, *salesPitchContent, *closeContent;
}

- (IBAction)changeTab:(id)sender;

@end
