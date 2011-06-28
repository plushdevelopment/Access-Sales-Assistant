//
//  VisitApplicationProfileViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"
#import "PickerViewController.h"

@interface VisitApplicationProfileViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DatePickerViewControllerDelegate> {
	UITextField *producerCodeTextField;
	UITextField *subTerritoryTextField;
	UITextField *producerNameTextField;
	UITextField *eOExpiresTextField;
	UITextField *numberOfLocationsTextField;
	UITextField *accessSignTextField;
	UITextField *dateEstablishedTextField;
	UITextField *howDoYouMarketTextField;
	UITextField *appointedDateTextField;
	UITextField *suspensionReasonTextField;
	UITextField *statusTextField;
	UITextField *eligibleTextField;
	UITextField *statusDateTextField;
	UITextField *reasonIneligibleTextField;
	UITextField *rater1TextField;
	UITextField *rater2TextField;
	UITextField *phone1TextField;
	UITextField *accountingEmailTextField;
	UITextField *fax1TextField;
	UITextField *customerServiceEmailTextField;
	UITextField *mainEmailTextField;
	UITextField *websiteAddressTextField;
	UITextField *claimsEmailTextField;
	UITextField *mondayStartTextField;
	UITextField *mondayStopTextField;
	UITextField *tuesdayStartTextField;
	UITextField *tuesdayStopTextField;
	UITextField *wednesdayStartTextField;
	UITextField *wednesdayStopTextField;
	UITextField *thursdayStartTextField;
	UITextField *thursdayStopTextField;
	UITextField *fridayStartTextField;
	UITextField *fridayStopTextField;
	UITextField *saturdayStartTextField;
	UITextField *saturdayStopTextField;
	UITextField *sundayStartTextField;
	UITextField *sundayStopTextField;
	UITextField *mailingAddressTextField;
	UITextField *mailingCityTextField;
	UITextField *mailingStateTextField;
	UITextField *mailingZipTextField;
	UITextField *commissionAddressTextField;
	UITextField *commissionCityTextField;
	UITextField *commissionStateTextField;
	UITextField *commissionZipTextField;
	UITextField *physicalAddressTextField;
	UITextField *physicalCityTextField;
	UITextField *physicalStateTextField;
	UITextField *physicalZipTextField;
	UITextField *numberOfEmployeesTextField;
	UITextField *mobilePhoneTextField;
	UITextField *firstNameTextField;
	UITextField *fax2TextField;
	UITextField *lastNameTextField;
	UITextField *emailAddressTextField;
	UIButton *titleTextField;
	UITextField *socialSecurityNumberTextField;
	PickerViewController *pickerViewController;
	UIButton *numberOfLocationsButton;
	UIButton *dateEstablishedButton;
	UIButton *subTerritoryButton;
	UIButton *eOExpiresButton;
	UIButton *accessSignButton;
	UIButton *appointedDateButton;
	UIButton *suspensionReasonButton;
	UIButton *statusButton;
	UIButton *statusDateButton;
	UIButton *eligibleButton;
	UIButton *reasonIneligibleButton;
	UIButton *rater1Button;
	UIButton *rater2Button;
	UIButton *mondayStartButton;
	UIButton *mondayStopButton;
	UIButton *tuesdayStartButton;
	UIButton *tuesdayStopButton;
	UIButton *wednesdayStartButton;
	UIButton *wednesdayStopButton;
	UIButton *thursdayStartButton;
	UIButton *thursdayStopButton;
	UIButton *fridayStartButton;
	UIButton *fridayStopButton;
	UIButton *saturdayStartButton;
	UIButton *saturdayStopButton;
	UIButton *sundayStartButton;
	UIButton *sundayStopButton;
	UIButton *mailingStateButton;
	UIButton *commissionStateButton;
	UIButton *physicalStateButton;
	UIButton *numberOfEmployeesButton;
	UIButton *titleButton;
	
}

@property (nonatomic, strong) IBOutlet UITextField *producerCodeTextField;
@property (nonatomic, strong) IBOutlet UITextField *subTerritoryTextField;
@property (nonatomic, strong) IBOutlet UITextField *producerNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *eOExpiresTextField;
@property (nonatomic, strong) IBOutlet UITextField *numberOfLocationsTextField;
@property (nonatomic, strong) IBOutlet UITextField *accessSignTextField;
@property (nonatomic, strong) IBOutlet UITextField *dateEstablishedTextField;
@property (nonatomic, strong) IBOutlet UITextField *howDoYouMarketTextField;
@property (nonatomic, strong) IBOutlet UITextField *appointedDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *suspensionReasonTextField;
@property (nonatomic, strong) IBOutlet UITextField *statusTextField;
@property (nonatomic, strong) IBOutlet UITextField *eligibleTextField;
@property (nonatomic, strong) IBOutlet UITextField *statusDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *reasonIneligibleTextField;
@property (nonatomic, strong) IBOutlet UITextField *rater1TextField;
@property (nonatomic, strong) IBOutlet UITextField *rater2TextField;
@property (nonatomic, strong) IBOutlet UITextField *phone1TextField;
@property (nonatomic, strong) IBOutlet UITextField *accountingEmailTextField;
@property (nonatomic, strong) IBOutlet UITextField *fax1TextField;
@property (nonatomic, strong) IBOutlet UITextField *customerServiceEmailTextField;
@property (nonatomic, strong) IBOutlet UITextField *mainEmailTextField;
@property (nonatomic, strong) IBOutlet UITextField *websiteAddressTextField;
@property (nonatomic, strong) IBOutlet UITextField *claimsEmailTextField;
@property (nonatomic, strong) IBOutlet UITextField *mondayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *mondayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *tuesdayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *tuesdayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *wednesdayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *wednesdayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *thursdayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *thursdayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *fridayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *fridayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *saturdayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *saturdayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *sundayStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *sundayStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *mailingAddressTextField;
@property (nonatomic, strong) IBOutlet UITextField *mailingCityTextField;
@property (nonatomic, strong) IBOutlet UITextField *mailingStateTextField;
@property (nonatomic, strong) IBOutlet UITextField *mailingZipTextField;
@property (nonatomic, strong) IBOutlet UITextField *commissionAddressTextField;
@property (nonatomic, strong) IBOutlet UITextField *commissionCityTextField;
@property (nonatomic, strong) IBOutlet UITextField *commissionStateTextField;
@property (nonatomic, strong) IBOutlet UITextField *commissionZipTextField;
@property (nonatomic, strong) IBOutlet UITextField *physicalAddressTextField;
@property (nonatomic, strong) IBOutlet UITextField *physicalCityTextField;
@property (nonatomic, strong) IBOutlet UITextField *physicalStateTextField;
@property (nonatomic, strong) IBOutlet UITextField *physicalZipTextField;
@property (nonatomic, strong) IBOutlet UITextField *numberOfEmployeesTextField;
@property (nonatomic, strong) IBOutlet UITextField *mobilePhoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *firstNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *fax2TextField;
@property (nonatomic, strong) IBOutlet UITextField *lastNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailAddressTextField;
@property (nonatomic, strong) IBOutlet UIButton *titleTextField;
@property (nonatomic, strong) IBOutlet UITextField *socialSecurityNumberTextField;

@property (nonatomic, strong) IBOutlet PickerViewController *pickerViewController;
@property (nonatomic, strong) UIPopoverController *aPopoverController;

@property (nonatomic, strong) IBOutlet UIButton *numberOfLocationsButton;
@property (nonatomic, strong) IBOutlet UIButton *dateEstablishedButton;
@property (nonatomic, strong) IBOutlet UIButton *subTerritoryButton;
@property (nonatomic, strong) IBOutlet UIButton *eOExpiresButton;
@property (nonatomic, strong) IBOutlet UIButton *accessSignButton;
@property (nonatomic, strong) IBOutlet UIButton *appointedDateButton;
@property (nonatomic, strong) IBOutlet UIButton *suspensionReasonButton;
@property (nonatomic, strong) IBOutlet UIButton *statusButton;
@property (nonatomic, strong) IBOutlet UIButton *statusDateButton;
@property (nonatomic, strong) IBOutlet UIButton *eligibleButton;
@property (nonatomic, strong) IBOutlet UIButton *reasonIneligibleButton;
@property (nonatomic, strong) IBOutlet UIButton *rater1Button;
@property (nonatomic, strong) IBOutlet UIButton *rater2Button;
@property (nonatomic, strong) IBOutlet UIButton *mondayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *mondayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *tuesdayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *tuesdayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *wednesdayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *wednesdayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *thursdayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *thursdayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *fridayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *fridayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *saturdayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *saturdayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *sundayStartButton;
@property (nonatomic, strong) IBOutlet UIButton *sundayStopButton;
@property (nonatomic, strong) IBOutlet UIButton *mailingStateButton;
@property (nonatomic, strong) IBOutlet UIButton *commissionStateButton;
@property (nonatomic, strong) IBOutlet UIButton *physicalStateButton;
@property (nonatomic, strong) IBOutlet UIButton *numberOfEmployeesButton;
@property (nonatomic, strong) IBOutlet UIButton *titleButton;



- (IBAction)showPickerView:(id)sender;
- (IBAction)showDatePickerView:(id)sender;

@end
