//
//  SuspendedCallViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SuspendedCallViewController : UIViewController {
	IBOutlet UIScrollView *contentScrollView;
    IBOutlet UIButton *insufficientFundsTab, *errorsTab;
	IBOutlet UIView *insufficientFundsView, *errorsView;
	IBOutlet UIWebView *insufficientFundsContent, *errorsContent;
}

- (IBAction)changeTab:(id)sender;

@end
