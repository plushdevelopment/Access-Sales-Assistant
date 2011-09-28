//
//  VisitApplicationProducerProfileTableViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProducerGeneralTableViewCell.h"
#import "ProducerAddressTableViewCell.h"
#import "ProducerContactTableViewCell.h"
#import "ProducerContactInfoTableViewCell.h"
#import "ProducerRaterTableViewCell.h"
#import "ProducerStatusTableViewCell.h"
#import "ProducerHoursTableViewCell.h"
#import "ProducerQuestionTableViewCell.h"
#import "LastVisitedTableViewCell.h"
#import "Producer.h"
#import "VisitApplicationTabBarController.h"
#import "DatePickerViewController.h"
#import "SmartTableView.h"
#import "BaseDetailViewController.h"
#import "PhoneNumberFormatter.h"
#import "OperationHour.h"
#import "SelectionModelViewController.h"

@interface VisitApplicationProducerProfileTableViewController : BaseDetailViewController <UITextFieldDelegate, DatePickerViewControllerDelegate, DetailViewController, UITableViewDataSource, UITableViewDelegate,optionSelectedDelegate>
{
    NSArray* sectionTitleArray;
    BOOL isContactsEdited;
	SmartTableView *_tableView;
    int myTextFieldSemaphore;
    
    PhoneNumberFormatter *myPhoneNumberFormatter;
    
    NSString *myLocale; //@"us"
    
    int prevIndexPath,currentIndexPath,currentTag;
    
    UITextField *currentTextFld;

}

@property (nonatomic, strong) Producer* detailItem;
@property (nonatomic, strong) IBOutlet DatePickerViewController *datePickerViewController;
@property (nonatomic, strong) UIPopoverController *popoverController;

@property (nonatomic, strong) IBOutlet ProducerStatusTableViewCell* statusCell;
@property (nonatomic, strong) IBOutlet ProducerGeneralTableViewCell* generalTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerAddressTableViewCell* addressTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerContactTableViewCell* contactTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerContactInfoTableViewCell* contactInfoTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerRaterTableViewCell* raterTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerHoursTableViewCell* hoursTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerQuestionTableViewCell *questionTableViewCell;
@property (nonatomic, strong) IBOutlet LastVisitedTableViewCell *lastVisitedCell;
@property (strong, nonatomic) IBOutlet SmartTableView *tableView;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic) BOOL isDoneSelected;

@property (nonatomic, strong) UINib *profileGeneralTableViewCellNib;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *submitButton;

@property (nonatomic,strong) IBOutlet SelectionModelViewController *selectionTableView;
@property (nonatomic, strong) NSMutableSet *fields;



-(UITableViewCell*) tableViewCellForNibName:(NSString*)nibName;
-(ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*)addressCell createAddressCellForType:(NSInteger)forType;
-(ProducerContactTableViewCell*) contactTableViewCell:(ProducerContactTableViewCell*) contactCell createContactCellForType:(NSInteger)forRow;
-(ProducerContactInfoTableViewCell*) contactInfoTableViewCell:(ProducerContactInfoTableViewCell*) contactInfoCell contactInfoForRow:(NSInteger)forRow;
-(void) raterTableViewCell:(ProducerRaterTableViewCell*) raterCell raterCellForRow:(NSInteger)forRow;
-(void) statusTableViewCell:(ProducerStatusTableViewCell*) statusCell statusCellForRow:(NSInteger)forRow;
-(void) hoursOfOperationCell:(ProducerHoursTableViewCell*)hoursCell hoursCellForRow:(NSInteger)forRow;
-(void) saveTextFieldToContext:(UITextField*) textField;
-(void) modifyEmailItem:(UITextField*) textField forEmailType:(NSInteger) emailType;
-(void) modifyPhoneItem:(UITextField*) textField forPhoneType:(NSInteger) phoneType;
-(void) toggleSubmitButton:(BOOL)isEnable;
-(BOOL) isEnableSubmit;
-(void)fillAddressCellForType:(ProducerAddressTableViewCell*)addressCell fillAddressWithItem:(AddressListItem*) withAddrItem forAddressType:(NSInteger) forType; 
-(void) autoFillEmailItem:(ProducerContactInfoTableViewCell*)contactInfoCell fillWithEmailItem:(EmailListItem*) withEmailItem;
-(EmailListItem*)createNewEmailItem:(EmailListItem*) withEmailItem createEmailForType:(NSInteger) forType;
-(void) autoFillHoursOfOperation:(HoursOfOperation*) withHours fillWithHours:(HoursOfOperation*) toHours;
-(void) toggleHoursOfOperationCell:(ProducerHoursTableViewCell*) hoursCell isEnableHoursCell:(BOOL) isEnabled;
-(OperationHour*) assignHour:(OperationHour*)withHour assignToHour:(OperationHour*) toHour forHoursOfOperation:(HoursOfOperation*) hoursOperation hoursForDay:(NSInteger) forDay isHoursOpen:(BOOL)isOpen;
- (void)configureView;
- (IBAction)showDatePickerView:(id)sender;
-(IBAction)showSelectionTableView:(id)sender;
-(IBAction)neverVisitToggle:(id)sender;
-(IBAction)handleCustomSwitchToggle:(id)sender;
- (IBAction)navigateToProducer:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;
-(IBAction)autoFormatPhoneNumber:(id)sender;
-(void)doneSelection:(id)sender;
@end
