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
#import "Producer.h"
#import "VisitApplicationTabBarController.h"
#import "DatePickerViewController.h"
#import "PickerViewController.h"
#import "SmartTableView.h"
#import "BaseDetailViewController.h"

@interface VisitApplicationProducerProfileTableViewController : BaseDetailViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DatePickerViewControllerDelegate, DetailViewController, UITableViewDataSource, UITableViewDelegate>
{
    NSArray* sectionTitleArray;
    BOOL isContactsEdited;
	SmartTableView *_tableView;
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
@property (strong, nonatomic) IBOutlet SmartTableView *tableView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *submitButton;



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
//-(void) changeTextFieldOutline:(UITextField*) textField:(BOOL) toOriginal;

- (void)configureView;

- (IBAction)showPickerView:(id)sender;
- (IBAction)showDatePickerView:(id)sender;

- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;

@end
