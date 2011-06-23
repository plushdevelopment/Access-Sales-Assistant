//
//  ProspectCallViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProspectCallViewController : UIViewController {
	IBOutlet UIScrollView *contentScrollView;
    IBOutlet UIView *overviewView, *salesPitchView, *callSurveyView, *closeView;
	IBOutlet UIButton *overviewTab, *salesPitchTab, *callSurveyTab, *closeTab;
	IBOutlet UIWebView *overviewContent, *salesPitchContent, *callSurveyContent, *closeContent;
}

- (IBAction)changeTab:(id)sender;

@end
