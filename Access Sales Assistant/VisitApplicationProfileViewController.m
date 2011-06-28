//
//  VisitApplicationProfileViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationProfileViewController.h"

#define PRODUCER_CODE					0
#define SUB_TERRITORY					1
#define PRODUCER_NAME					2
#define EO_EXPIRES						3
#define NUMBER_OF_LOCATIONS				4
#define ACCESS_SIGN						5
#define DATE_ESTABLISHED				6
#define HOW_DO_YOU_MARKET_YOUR_AGENCY	7
#define APPOINTED_DATE					8
#define SUSPENSION_REASON				9
#define STATUS							10
#define ELIGIBLE						11
#define STATUS_DATE						12
#define REASON_INELIGIBLE				13
#define RATER_1							14
#define RATER_2							15
#define PHONE_1							16
#define ACCOUNTING_EMAIL				17
#define FAX_1							18
#define CUSTOMER_SERVICE_EMAIL			19
#define MAIN_EMAIL						20
#define WEBSITE_ADDRESS					21
#define CLAIMS_EMAIL					22
#define MONDAY_STOP						23
#define MONDAY_START					24
#define TUESDAY_STOP					25
#define TUESDAY_START					26
#define WEDNESDAY_STOP					27
#define WEDNESDAY_START					28
#define THURSDAY_STOP					29
#define THURSDAY_START					30
#define FRIDAY_STOP						31
#define FRIDAY_START					32
#define SATURDAY_STOP					33
#define SATURDAY_START					34
#define SUNDAY_STOP						35
#define SUNDAY_START					36
#define MAILING_CITY					37
#define MAILING_ADDRESS					38
#define COMMISSION_CITY					39
#define COMMISSION_ADDRESS				40
#define PHYSICAL_CITY					41
#define PHYSICAL_ADDRESS				42
#define MAILING_ZIP						43
#define MAILING_STATE					44
#define COMMISSION_ZIP					45
#define COMMISSION_STATE				46
#define PHYSICAL_ZIP					47
#define PHYSICAL_STATE					48
#define MOBILE_PHONE					49
#define NUMBER_OF_EMPLOYEES				50
#define FAX_2							51
#define FIRST_NAME						52
#define EMAIL_ADDRESS					53
#define LAST_NAME						54
#define SOCIAL_SECURITY_NUMBER			55
#define TITLE							56



@implementation VisitApplicationProfileViewController

@synthesize producerCodeTextField;
@synthesize subTerritoryTextField;
@synthesize producerNameTextField;
@synthesize eOExpiresTextField;
@synthesize numberOfLocationsTextField;
@synthesize accessSignTextField;
@synthesize dateEstablishedTextField;
@synthesize howDoYouMarketTextField;
@synthesize appointedDateTextField;
@synthesize suspensionReasonTextField;
@synthesize statusTextField;
@synthesize eligibleTextField;
@synthesize statusDateTextField;
@synthesize reasonIneligibleTextField;
@synthesize rater1TextField;
@synthesize rater2TextField;
@synthesize phone1TextField;
@synthesize accountingEmailTextField;
@synthesize fax1TextField;
@synthesize customerServiceEmailTextField;
@synthesize mainEmailTextField;
@synthesize websiteAddressTextField;
@synthesize claimsEmailTextField;
@synthesize mondayStartTextField;
@synthesize mondayStopTextField;
@synthesize tuesdayStartTextField;
@synthesize tuesdayStopTextField;
@synthesize wednesdayStartTextField;
@synthesize wednesdayStopTextField;
@synthesize thursdayStartTextField;
@synthesize thursdayStopTextField;
@synthesize fridayStartTextField;
@synthesize fridayStopTextField;
@synthesize saturdayStartTextField;
@synthesize saturdayStopTextField;
@synthesize sundayStartTextField;
@synthesize sundayStopTextField;
@synthesize mailingAddressTextField;
@synthesize mailingCityTextField;
@synthesize mailingStateTextField;
@synthesize mailingZipTextField;
@synthesize commissionAddressTextField;
@synthesize commissionCityTextField;
@synthesize commissionStateTextField;
@synthesize commissionZipTextField;
@synthesize physicalAddressTextField;
@synthesize physicalCityTextField;
@synthesize physicalStateTextField;
@synthesize physicalZipTextField;
@synthesize numberOfEmployeesTextField;
@synthesize mobilePhoneTextField;
@synthesize firstNameTextField;
@synthesize fax2TextField;
@synthesize lastNameTextField;
@synthesize emailAddressTextField;
@synthesize titleTextField;
@synthesize socialSecurityNumberTextField;

@synthesize pickerViewController;
@synthesize aPopoverController=_aPopoverController;

@synthesize numberOfLocationsButton;
@synthesize dateEstablishedButton;
@synthesize subTerritoryButton;
@synthesize eOExpiresButton;
@synthesize accessSignButton;
@synthesize appointedDateButton;
@synthesize suspensionReasonButton;
@synthesize statusButton;
@synthesize statusDateButton;
@synthesize eligibleButton;
@synthesize reasonIneligibleButton;
@synthesize rater1Button;
@synthesize rater2Button;
@synthesize mondayStartButton;
@synthesize mondayStopButton;
@synthesize tuesdayStartButton;
@synthesize tuesdayStopButton;
@synthesize wednesdayStartButton;
@synthesize wednesdayStopButton;
@synthesize thursdayStartButton;
@synthesize thursdayStopButton;
@synthesize fridayStartButton;
@synthesize fridayStopButton;
@synthesize saturdayStartButton;
@synthesize saturdayStopButton;
@synthesize sundayStartButton;
@synthesize sundayStopButton;
@synthesize mailingStateButton;
@synthesize commissionStateButton;
@synthesize physicalStateButton;
@synthesize numberOfEmployeesButton;
@synthesize titleButton;


#pragma mark -
#pragma mark IBActions

- (IBAction)showPickerView:(id)sender
{
	UIButton *button = (UIButton *)sender;
	
	self.pickerViewController.currentTag = button.tag;
	[self.pickerViewController setContentSizeForViewInPopover:CGSizeMake(344.0, 259.0)];
	_aPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.pickerViewController];
	[self.aPopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
	UIPickerView *pickerView = self.pickerViewController.pickerView;
	[pickerView setDelegate:self];
	[pickerView setDataSource:self];
	[pickerView setShowsSelectionIndicator:YES];
	[pickerView selectRow:0 inComponent:0 animated:NO];
}

- (IBAction)showDatePickerView:(id)sender
{
	
	UIButton *button = (UIButton *)sender;
	DatePickerViewController *viewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
	[viewController.datePicker setDate:[NSDate date]];
	viewController.delegate = self;
	viewController.currentTag = button.tag;
	[viewController setContentSizeForViewInPopover:viewController.view.frame.size];
	_aPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
	[self.aPopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[viewController.datePicker setDatePickerMode:UIDatePickerModeDate];
}

- (IBAction)showTimePickerView:(id)sender
{
	
	UIButton *button = (UIButton *)sender;
	DatePickerViewController *viewController = [[DatePickerViewController alloc] initWithNibName:@"DatePickerViewController" bundle:nil];
	[viewController.datePicker setDate:[NSDate date]];
	viewController.delegate = self;
	viewController.currentTag = button.tag;
	[viewController setContentSizeForViewInPopover:viewController.view.frame.size];
	_aPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
	[self.aPopoverController presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[viewController.datePicker setDatePickerMode:UIDatePickerModeTime];
}

#pragma mark -
#pragma mark init



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
	[self setProducerNameTextField:nil];
	[self setProducerCodeTextField:nil];
	[self setSubTerritoryTextField:nil];
	[self setEOExpiresTextField:nil];
	[self setNumberOfLocationsTextField:nil];
	[self setAccessSignTextField:nil];
	[self setDateEstablishedTextField:nil];
	[self setHowDoYouMarketTextField:nil];
	[self setAppointedDateTextField:nil];
	[self setSuspensionReasonTextField:nil];
	[self setStatusTextField:nil];
	[self setEligibleTextField:nil];
	[self setStatusDateTextField:nil];
	[self setReasonIneligibleTextField:nil];
	[self setRater1TextField:nil];
	[self setRater2TextField:nil];
	[self setSundayStopTextField:nil];
	[self setSaturdayStartTextField:nil];
	[self setMondayStopTextField:nil];
	[self setTuesdayStopTextField:nil];
	[self setThursdayStartTextField:nil];
	[self setFridayStopTextField:nil];
	[self setWednesdayStartTextField:nil];
	[self setFridayStartTextField:nil];
	[self setThursdayStopTextField:nil];
	[self setWednesdayStopTextField:nil];
	[self setTuesdayStartTextField:nil];
	[self setSaturdayStopTextField:nil];
	[self setSundayStartTextField:nil];
	[self setMondayStartTextField:nil];
	[self setMailingAddressTextField:nil];
	[self setMailingCityTextField:nil];
	[self setMailingStateTextField:nil];
	[self setMailingZipTextField:nil];
	[self setCommissionAddressTextField:nil];
	[self setCommissionCityTextField:nil];
	[self setPhysicalStateTextField:nil];
	[self setCommissionStateTextField:nil];
	[self setCommissionZipTextField:nil];
	[self setPhysicalAddressTextField:nil];
	[self setPhysicalCityTextField:nil];
	[self setPhysicalZipTextField:nil];
	[self setNumberOfEmployeesTextField:nil];
	[self setMobilePhoneTextField:nil];
	[self setFirstNameTextField:nil];
	[self setFax2TextField:nil];
	[self setLastNameTextField:nil];
	[self setEmailAddressTextField:nil];
	[self setTitleTextField:nil];
	[self setSocialSecurityNumberTextField:nil];
	[self setPhone1TextField:nil];
	[self setAccountingEmailTextField:nil];
	[self setFax1TextField:nil];
	[self setCustomerServiceEmailTextField:nil];
	[self setMainEmailTextField:nil];
	[self setWebsiteAddressTextField:nil];
	[self setClaimsEmailTextField:nil];
	[self setPickerViewController:nil];
	[self setNumberOfLocationsButton:nil];
	[self setDateEstablishedButton:nil];
	[self setSubTerritoryButton:nil];
	[self setEOExpiresButton:nil];
	[self setAccessSignButton:nil];
	[self setAppointedDateButton:nil];
	[self setSuspensionReasonButton:nil];
	[self setStatusButton:nil];
	[self setStatusDateButton:nil];
	[self setEligibleButton:nil];
	[self setReasonIneligibleButton:nil];
	[self setRater1Button:nil];
	[self setRater2Button:nil];
	[self setMondayStartButton:nil];
	[self setMondayStopButton:nil];
	[self setTuesdayStartButton:nil];
	[self setTuesdayStopButton:nil];
	[self setWednesdayStartButton:nil];
	[self setWednesdayStopButton:nil];
	[self setThursdayStartButton:nil];
	[self setThursdayStopButton:nil];
	[self setFridayStartButton:nil];
	[self setFridayStopButton:nil];
	[self setSaturdayStartButton:nil];
	[self setSaturdayStopButton:nil];
	[self setSundayStartButton:nil];
	[self setSundayStopButton:nil];
	[self setMailingStateButton:nil];
	[self setCommissionStateButton:nil];
	[self setPhysicalStateButton:nil];
	[self setNumberOfEmployeesButton:nil];
	[self setTitleButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self nextField:textField.tag];
	return YES;
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 10;
}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	switch (self.pickerViewController.currentTag) {
		case SUB_TERRITORY:
			self.subTerritoryTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case NUMBER_OF_LOCATIONS:
			self.numberOfLocationsTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case ACCESS_SIGN:
			self.accessSignTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case SUSPENSION_REASON:
			self.suspensionReasonTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case STATUS:
			self.statusTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case ELIGIBLE:
			self.eligibleTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case REASON_INELIGIBLE:
			self.reasonIneligibleTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case RATER_1:
			self.rater1TextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case RATER_2:
			self.rater2TextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case MAILING_STATE:
			self.mailingStateTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case COMMISSION_STATE:
			self.commissionStateTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case PHYSICAL_STATE:
			self.physicalStateTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		case NUMBER_OF_EMPLOYEES:
			self.numberOfEmployeesTextField.text = [pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
			break;
		default:
			break;
	}
}

/*
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	
}
*/

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *theTitle = @"NOT SET";
	switch (self.pickerViewController.currentTag) {
		case SUB_TERRITORY:
			theTitle = @"SUB_TERRITORY";
			break;
		case NUMBER_OF_LOCATIONS:
			theTitle = @"NUMBER_OF_LOCATIONS";
			break;
		case ACCESS_SIGN:
			theTitle = @"ACCESS_SIGN";
			break;
		case SUSPENSION_REASON:
			theTitle = @"SUSPENSION_REASON";
			break;
		case STATUS:
			theTitle = @"STATUS";
			break;
		case ELIGIBLE:
			theTitle = @"ELIGIBLE";
			break;
		case REASON_INELIGIBLE:
			theTitle = @"REASON_INELIGIBLE";
			break;
		case RATER_1:
			theTitle = @"RATER_1";
			break;
		case RATER_2:
			theTitle = @"RATER_2";
			break;
		case MAILING_STATE:
			theTitle = @"MAILING_STATE";
			break;
		case COMMISSION_STATE:
			theTitle = @"COMMISSION_STATE";
			break;
		case PHYSICAL_STATE:
			theTitle = @"PHYSICAL_STATE";
			break;
		case NUMBER_OF_EMPLOYEES:
			theTitle = @"NUMBER_OF_EMPLOYEES";
			break;
		case TITLE:
			theTitle = @"TITLE";
			break;
		default:
			break;
	}
	return theTitle;
}

/*
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	
}
*/

/*
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	
}
*/

#pragma mark -
#pragma mark DatePickerViewControllerDelegate

- (void)didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	switch (tag) {
		case EO_EXPIRES:
			self.eOExpiresTextField.text = [toDate description];
			break;
		case DATE_ESTABLISHED:
			self.dateEstablishedTextField.text = [toDate description];
			break;
		case STATUS_DATE:
			self.statusDateTextField.text = [toDate description];
			break;
		case MONDAY_START:
			self.mondayStartTextField.text = [toDate description];
			break;
		case MONDAY_STOP:
			self.mondayStopTextField.text = [toDate description];
			break;
		case TUESDAY_START:
			self.tuesdayStartTextField.text = [toDate description];
			break;
		case TUESDAY_STOP:
			self.tuesdayStopTextField.text = [toDate description];
			break;
		case WEDNESDAY_START:
			self.wednesdayStartTextField.text = [toDate description];
			break;
		case WEDNESDAY_STOP:
			self.wednesdayStopTextField.text = [toDate description];
			break;
		case THURSDAY_START:
			self.thursdayStartTextField.text = [toDate description];
			break;
		case THURSDAY_STOP:
			self.thursdayStopTextField.text = [toDate description];
			break;
		case FRIDAY_START:
			self.fridayStartTextField.text = [toDate description];
			break;
		case FRIDAY_STOP:
			self.fridayStopTextField.text = [toDate description];
			break;
		case SATURDAY_START:
			self.saturdayStartTextField.text = [toDate description];
			break;
		case SATURDAY_STOP:
			self.saturdayStopTextField.text = [toDate description];
			break;
		case SUNDAY_START:
			self.sundayStartTextField.text = [toDate description];
			break;
		case SUNDAY_STOP:
			self.sundayStopTextField.text = [toDate description];
			break;
		default:
			break;
	}
}

- (void)nextField:(NSInteger)currentTag
{
	[self.aPopoverController dismissPopoverAnimated:YES];
	switch (currentTag) {
		case PRODUCER_CODE:
			[self.producerCodeTextField resignFirstResponder];
			[self showPickerView:self.subTerritoryButton];
			break;
		case SUB_TERRITORY:
			[self.producerNameTextField becomeFirstResponder];
			break;
		case PRODUCER_NAME:
			[self.producerNameTextField resignFirstResponder];
			[self showDatePickerView:self.eOExpiresButton];
			break;
		case EO_EXPIRES:
			[self showPickerView:self.numberOfLocationsButton];
			break;
		case NUMBER_OF_LOCATIONS:
			[self showPickerView:self.accessSignButton];
			break;
		case ACCESS_SIGN:
			[self showDatePickerView:self.dateEstablishedButton];
			break;
		case DATE_ESTABLISHED:
			[self.howDoYouMarketTextField becomeFirstResponder];
			break;
		case HOW_DO_YOU_MARKET_YOUR_AGENCY:
			[self.howDoYouMarketTextField resignFirstResponder];
			[self showDatePickerView:self.appointedDateButton];
			break;
		case APPOINTED_DATE:
			[self showPickerView:self.suspensionReasonButton];
			break;
		case SUSPENSION_REASON:
			[self showPickerView:self.statusButton];
			break;
		case STATUS:
			[self showPickerView:self.eligibleButton];
			break;
		case ELIGIBLE:
			[self showDatePickerView:self.statusDateButton];
			break;
		case STATUS_DATE:
			[self showPickerView:self.reasonIneligibleButton];
			break;
		case REASON_INELIGIBLE:
			[self showPickerView:self.rater1Button];
			break;
		case RATER_1:
			[self showPickerView:self.rater2Button];
			break;
		case RATER_2:
			[self.phone1TextField becomeFirstResponder];
			break;
		case PHONE_1:
			[self.accountingEmailTextField becomeFirstResponder];
			break;
		case ACCOUNTING_EMAIL:
			[self.fax1TextField becomeFirstResponder];
			break;
		case FAX_1:
			[self.customerServiceEmailTextField becomeFirstResponder];
			break;
		case CUSTOMER_SERVICE_EMAIL:
			[self.mainEmailTextField becomeFirstResponder];
			break;
		case MAIN_EMAIL:
			[self.websiteAddressTextField becomeFirstResponder];
			break;
		case WEBSITE_ADDRESS:
			[self.claimsEmailTextField becomeFirstResponder];
			break;
		case CLAIMS_EMAIL:
			[self.claimsEmailTextField resignFirstResponder];
			[self showTimePickerView:mondayStartButton];
			break;
		case MONDAY_START:
			[self showTimePickerView:mondayStopButton];
			break;
		case MONDAY_STOP:
			[self showTimePickerView:tuesdayStartButton];
			break;
		case TUESDAY_START:
			[self showTimePickerView:tuesdayStopButton];
			break;
		case TUESDAY_STOP:
			[self showTimePickerView:wednesdayStartButton];
			break;
		case WEDNESDAY_START:
			[self showTimePickerView:wednesdayStopButton];
			break;
		case WEDNESDAY_STOP:
			[self showTimePickerView:thursdayStartButton];
			break;
		case THURSDAY_START:
			[self showTimePickerView:thursdayStopButton];
			break;
		case THURSDAY_STOP:
			[self showTimePickerView:fridayStartButton];
			break;
		case FRIDAY_START:
			[self showTimePickerView:fridayStopButton];
			break;
		case FRIDAY_STOP:
			[self showTimePickerView:saturdayStartButton];
			break;
		case SATURDAY_START:
			[self showTimePickerView:saturdayStopButton];
			break;
		case SATURDAY_STOP:
			[self showTimePickerView:sundayStartButton];
			break;
		case SUNDAY_START:
			[self showTimePickerView:sundayStopButton];
			break;
		case SUNDAY_STOP:
			[self.mailingAddressTextField becomeFirstResponder];
			break;
		case MAILING_ADDRESS:
			[self.mailingCityTextField becomeFirstResponder];
			break;
		case MAILING_CITY:
			[self.mailingCityTextField resignFirstResponder];
			[self showPickerView:self.mailingStateButton];
			break;
		case MAILING_STATE:
			[self.mailingZipTextField becomeFirstResponder];
			break;
		case MAILING_ZIP:
			[self.commissionAddressTextField becomeFirstResponder];
			break;
		case COMMISSION_ADDRESS:
			[self.commissionCityTextField becomeFirstResponder];
			break;
		case COMMISSION_CITY:
			[self.commissionCityTextField resignFirstResponder];
			[self showPickerView:self.commissionStateButton];
			break;
		case COMMISSION_STATE:
			[self.commissionZipTextField becomeFirstResponder];
			break;
		case COMMISSION_ZIP:
			[self.physicalAddressTextField becomeFirstResponder];
			break;
		case PHYSICAL_ADDRESS:
			[self.physicalCityTextField becomeFirstResponder];
			break;
		case PHYSICAL_CITY:
			[self.physicalCityTextField resignFirstResponder];
			[self showPickerView:self.physicalStateButton];
			break;
		case PHYSICAL_STATE:
			[self.physicalZipTextField becomeFirstResponder];
			break;
		case PHYSICAL_ZIP:
			[self.physicalZipTextField resignFirstResponder];
			[self showPickerView:self.numberOfEmployeesButton];
			break;
		case NUMBER_OF_EMPLOYEES:
			[self.mobilePhoneTextField becomeFirstResponder];
			break;
		case MOBILE_PHONE:
			[self.firstNameTextField becomeFirstResponder];
			break;
		case FIRST_NAME:
			[self.fax2TextField becomeFirstResponder];
			break;
		case FAX_2:
			[self.lastNameTextField becomeFirstResponder];
			break;
		case LAST_NAME:
			[self.emailAddressTextField becomeFirstResponder];
			break;
		case EMAIL_ADDRESS:
			[self.emailAddressTextField resignFirstResponder];
			[self showPickerView:self.titleButton];
			break;
		case TITLE:
			[self.socialSecurityNumberTextField becomeFirstResponder];
			break;
		case SOCIAL_SECURITY_NUMBER:
			[self.producerCodeTextField becomeFirstResponder];
			
			break;
		default:
			break;
	}
}

- (void)previousField:(NSInteger)currentTag
{
	
}

@end
