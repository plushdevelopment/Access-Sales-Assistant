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
#import "PickerViewController.h"
#import "SmartTableView.h"
#import "BaseDetailViewController.h"
#import "PhoneNumberFormatter.h"
#import "OperationHour.h"
#import "SelectionModelViewController.h"

@interface VisitApplicationProducerProfileTableViewController : BaseDetailViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DatePickerViewControllerDelegate, DetailViewController, UITableViewDataSource, UITableViewDelegate,optionSelectedDelegate>
{
    NSArray* sectionTitleArray;
    BOOL isContactsEdited;
	SmartTableView *_tableView;
    int myTextFieldSemaphore;
    
    PhoneNumberFormatter *myPhoneNumberFormatter;
    
    NSString *myLocale; //@"us"

}

@property (nonatomic, strong) Producer* detailItem;
@property (nonatomic, strong) IBOutlet PickerViewController *pickerViewController;
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



-(UITableViewCell*) tableViewCellForNibName:(NSString*)nibName;
-(ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*) addressCell:(NSInteger)forType;
-(ProducerContactTableViewCell*) contactTableViewCell:(ProducerContactTableViewCell*) contactCell:(NSInteger)forRow;
-(ProducerContactInfoTableViewCell*) contactInfoTableViewCell:(ProducerContactInfoTableViewCell*) contactInfoCell:(NSInteger)forRow;
-(void) raterTableViewCell:(ProducerRaterTableViewCell*) raterCell:(NSInteger)forRow;
-(void) statusTableViewCell:(ProducerStatusTableViewCell*) statusCell:(NSInteger)forRow;
-(void) hoursOfOperationCell:(ProducerHoursTableViewCell*)hoursCell:(NSInteger)forRow;
-(void) saveTextFieldToContext:(UITextField*) textField;

-(void) modifyEmailItem:(UITextField*) textField:(NSInteger) emailType;
-(void) modifyPhoneItem:(UITextField*) textField:(NSInteger) phoneType;
-(void) toggleSubmitButton:(BOOL)isEnable;
-(BOOL) isEnableSubmit;
-(void)FillAddressCellForType:(ProducerAddressTableViewCell*)addressCell:(AddressListItem*) withAddrItem; 
-(void) AutoFillEmailItem:(ProducerContactInfoTableViewCell*)contactInfoCell:(EmailListItem*) withEmailItem;
-(EmailListItem*)createNewEmailItem:(EmailListItem*) withEmailItem:(NSInteger) forType;
-(void) AutoFillHoursOfOperation:(HoursOfOperation*) withHours:(HoursOfOperation*) toHours;
-(void) toggleHoursOfOperationCell:(ProducerHoursTableViewCell*) hoursCell:(BOOL) isEnabled;
-(OperationHour*) assignHour:(OperationHour*) withHour:(OperationHour*) toHour:(HoursOfOperation*) hoursOperation:(NSInteger) forDay:(BOOL)isOpen;

//-(void) changeTextFieldOutline:(UITextField*) textField:(BOOL) toOriginal;

- (void)configureView;

- (IBAction)showPickerView:(id)sender;
- (IBAction)showDatePickerView:(id)sender;

-(IBAction)showSelectionTableView:(id)sender;
-(IBAction)neverVisitToggle:(id)sender;
-(IBAction)handleCustomSwitchToggle:(id)sender;

- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;
-(IBAction)autoFormatPhoneNumber:(id) sender;
-(void)doneSelection:(id)sender;

@end
