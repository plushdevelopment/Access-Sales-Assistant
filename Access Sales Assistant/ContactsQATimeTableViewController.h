//
//  ContactsQATimeTableViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"
#import "StateSelectionTableViewController.h"
#import "SSLocationManager.h"
#import "YahooPlaceData.h"
#import "YahooPlaceFinder.h"
@interface ContactsQATimeTableViewController : BaseDetailViewController<stateChangedDelegate,SSLocationManagerDelegate>
{
    UIPopoverController* popOverController;
    UIInterfaceOrientation currentOrientation;
}

@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;
@property(nonatomic,strong) IBOutlet UIButton* stateChangeButton;
@property(nonatomic,strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong)StateSelectionTableViewController* stateViewController;
@property (nonatomic,strong) NSString* currentStateName;
@property (nonatomic,strong) NSString* currentStateCode;
-(IBAction)stateChanged:(id)sender;
-(void) selectedState:(NSString*) stateName:(NSString *)stateCode;

@end
