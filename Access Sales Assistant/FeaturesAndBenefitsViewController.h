//
//  FeaturesAndBenefitsViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"
#import "StateSelectionTableViewController.h"
#import "RootViewController.h"
#import "SSLocationManager.h"
#import "YahooPlaceData.h"
#import "YahooPlaceFinder.h"
//@interface FeaturesAndBenefitsViewController : UIViewController<stateChangedDelegate,UIScrollViewDelegate,SubstitutableDetailViewController,SSLocationManagerDelegate>

@interface FeaturesAndBenefitsViewController : BaseDetailViewController<stateChangedDelegate,UIScrollViewDelegate,SSLocationManagerDelegate>
{
    UIPopoverController* _popOverController;
}

-(IBAction)selectState:(id)sender;
-(void) selectedState:(NSString*) stateName selectedStateCode:(NSString *)stateCode;

@property(nonatomic,strong) IBOutlet UILabel* _accessInternationalDrivers;
@property(nonatomic,strong) IBOutlet UILabel* _accessBusiness;
@property(nonatomic,strong) IBOutlet UILabel* _multilingualCompany;
@property(nonatomic,strong) IBOutlet UILabel* _salvageTitles;
@property(nonatomic,strong) IBOutlet UILabel* _weDonotDirect;
@property(nonatomic,strong) IBOutlet UILabel* _namedNonOwnerPolicy;
@property(nonatomic,strong) IBOutlet UILabel* _registeredOwnerDiscounts;
@property(nonatomic,strong) IBOutlet UILabel* _multiFamilyPolicy;
@property(nonatomic,strong) IBOutlet UILabel* _acceptUpto2DUIs;
@property(nonatomic,strong) IBOutlet UILabel* _noCreditScoreorTiers;
@property(nonatomic,strong) IBOutlet UILabel* _multiplePaymentOptions;
@property(nonatomic,strong) IBOutlet UIButton* _changeStateButton;
@property(nonatomic,strong) IBOutlet UIScrollView* fnbScrollview;
@property (nonatomic,strong)StateSelectionTableViewController* stateViewController;
@property (nonatomic, strong) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;

@property (nonatomic,strong) NSString* currentStateName;
@property (nonatomic,strong) NSString* currentStateCode;


@end
