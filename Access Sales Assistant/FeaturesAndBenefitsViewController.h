//
//  FeaturesAndBenefitsViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateSelectionTableViewController.h"


@interface FeaturesAndBenefitsViewController : UIViewController<stateChangedDelegate>
{
    UIPopoverController* _popOverController;
}

-(IBAction)selectState:(id)sender;
-(void) selectedState:(NSString*) stateName;

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
@property (nonatomic,strong)StateSelectionTableViewController* stateViewController;


@end
