//
//  VisitApplicationSummaryViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitApplicationSummaryViewController : UIViewController {
	UITextField *_nsbsTotalAppsPerMonthTextField;
	UITextField *_nsbsPercentLiabTextField;
	UITextField *_producerAddOnTextField;
	UITextField *_rdFollowUpTextField;
	UITextField *_nsbsMonthlyGoalTextField;
	UITextField *_nsbsPercentFDLTextField;
	UIButton *_rdFollowUpButton;
	UIButton *_producerAddOnButton;
	UIButton *_addPersonButton;
	UIButton *_addCompetitorButton;
	UIButton *_addBarrierButton;
	UILabel *_nsbsLabel;
	UILabel *_barriersToBusinessLabel;
	UILabel *_competitorsLabel;
	UILabel *_personSpokeWithLabel;
	UILabel *_generalLabel;
	UIButton *_addPersonPlusSignButton;
	UIButton *_addCompetitorPlusSignButton;
	UIButton *_addBarrierPlusSignButton;
	UILabel *_addPersonLabel;
	UILabel *_addCompetitorLabel;
	UILabel *_addBarrierLabel;
}


 


@property (nonatomic, strong) IBOutlet UIView *generalView;
@property (nonatomic, strong) IBOutlet UIView *personSpokeWithView1;
@property (nonatomic, strong) IBOutlet UIView *personSpokeWithView2;
@property (nonatomic, strong) IBOutlet UIView *personSpokeWithView3;
@property (nonatomic, strong) IBOutlet UITextField *producerNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *reportDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *callTypeTextField;
@property (nonatomic, strong) IBOutlet UIButton *reportDateButton;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField1;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField1;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField1;
@property (nonatomic, strong) IBOutlet UIButton *titleButton1;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField1;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField2;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField2;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField2;
@property (nonatomic, strong) IBOutlet UIButton *titleButton2;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField2;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField3;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField3;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField3;
@property (nonatomic, strong) IBOutlet UIButton *titleButton3;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField3;
@property (nonatomic, strong) IBOutlet UITextField *competitorNameTextField1;
@property (nonatomic, strong) IBOutlet UITextField *competitorAppsPerMonthTextField1;
@property (nonatomic, strong) IBOutlet UITextField *competitorCommissionStructureTextField1;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentNewTextField1;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentRenewalTextField1;
@property (nonatomic, strong) IBOutlet UIButton *competitorNameButton1;
@property (nonatomic, strong) IBOutlet UIButton *competitorCommissionStructureButton1;

@property (nonatomic, strong) IBOutlet UITextField *competitorNameTextField2;
@property (nonatomic, strong) IBOutlet UITextField *competitorAppsPerMonthTextField2;
@property (nonatomic, strong) IBOutlet UITextField *competitorCommissionStructureTextField2;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentNewTextField2;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentRenewalTextField2;
@property (nonatomic, strong) IBOutlet UIButton *competitorNameButton2;
@property (nonatomic, strong) IBOutlet UIButton *competitorCommissionStructureButton2;

@property (nonatomic, strong) IBOutlet UITextField *competitorNameTextField3;
@property (nonatomic, strong) IBOutlet UITextField *competitorAppsPerMonthTextField3;
@property (nonatomic, strong) IBOutlet UITextField *competitorCommissionStructureTextField3;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentNewTextField3;
@property (nonatomic, strong) IBOutlet UITextField *competitorPercentRenewalTextField3;
@property (nonatomic, strong) IBOutlet UIButton *competitorNameButton3;
@property (nonatomic, strong) IBOutlet UIButton *competitorCommissionStructureButton3;

@property (nonatomic, strong) IBOutlet UITextField *barrierToBusinessTextField1;
@property (nonatomic, strong) IBOutlet UIButton *barrierToBusinessButton1;

@property (nonatomic, strong) IBOutlet UITextField *barrierToBusinessTextField2;
@property (nonatomic, strong) IBOutlet UIButton *barrierToBusinessButton2;

@property (nonatomic, strong) IBOutlet UITextField *barrierToBusinessTextField3;
@property (nonatomic, strong) IBOutlet UIButton *barrierToBusinessButton3;

@property (nonatomic, strong) IBOutlet UITextField *nsbsTotalAppsPerMonthTextField;
@property (nonatomic, strong) IBOutlet UITextField *nsbsPercentLiabTextField;
@property (nonatomic, strong) IBOutlet UITextField *producerAddOnTextField;
@property (nonatomic, strong) IBOutlet UITextField *rdFollowUpTextField;
@property (nonatomic, strong) IBOutlet UITextField *nsbsMonthlyGoalTextField;
@property (nonatomic, strong) IBOutlet UITextField *nsbsPercentFDLTextField;
@property (nonatomic, strong) IBOutlet UIButton *rdFollowUpButton;
@property (nonatomic, strong) IBOutlet UIButton *producerAddOnButton;
@property (nonatomic, strong) IBOutlet UIButton *addPersonButton;
@property (nonatomic, strong) IBOutlet UIButton *addCompetitorButton;
@property (nonatomic, strong) IBOutlet UIButton *addBarrierButton;
@property (nonatomic, strong) IBOutlet UILabel *nsbsLabel;
@property (nonatomic, strong) IBOutlet UILabel *barriersToBusinessLabel;
@property (nonatomic, strong) IBOutlet UILabel *competitorsLabel;
@property (nonatomic, strong) IBOutlet UILabel *personSpokeWithLabel;
@property (nonatomic, strong) IBOutlet UILabel *generalLabel;
@property (nonatomic, strong) IBOutlet UIButton *addPersonPlusSignButton;
@property (nonatomic, strong) IBOutlet UIButton *addCompetitorPlusSignButton;
@property (nonatomic, strong) IBOutlet UIButton *addBarrierPlusSignButton;
@property (nonatomic, strong) IBOutlet UILabel *addPersonLabel;
@property (nonatomic, strong) IBOutlet UILabel *addCompetitorLabel;
@property (nonatomic, strong) IBOutlet UILabel *addBarrierLabel;


@end
