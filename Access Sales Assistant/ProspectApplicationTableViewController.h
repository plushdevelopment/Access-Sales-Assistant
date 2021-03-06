//
//  ProspectApplicationTableViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



#import "ProducerAddressTableViewCell.h"
#import "ProducerContactInfoTableViewCell.h"
#import "ProducerRaterTableViewCell.h"
#import "DatePickerViewController.h"
#import "ProspectAppContactTableViewCell.h"
#import "ProspectAppGeneralTableViewCell.h"
#import "SmartTableView.h"
#import "Producer.h"
#import "BaseDetailViewController.h"
#import "VisitApplicationTabBarController.h"
#import "PhoneNumberFormatter.h"
#import "SelectionModelViewController.h"

@interface ProspectApplicationTableViewController : BaseDetailViewController<UITextFieldDelegate,DatePickerViewControllerDelegate, DetailViewController,UITableViewDelegate,UITableViewDataSource,optionSelectedDelegate>
{
    NSArray* sectionTitleArray;
    NSMutableArray* producerList;
    NSMutableArray* producerNamesArray;
    
    int myTextFieldSemaphore;
    PhoneNumberFormatter *myPhoneNumberFormatter;
    NSString *myLocale;
}
@property (nonatomic, strong) IBOutlet ProducerAddressTableViewCell* addressTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerContactInfoTableViewCell* contactInfoTableViewCell;
@property (nonatomic, strong) IBOutlet ProducerRaterTableViewCell* raterTableViewCell;
@property (nonatomic, strong) IBOutlet ProspectAppContactTableViewCell *contactTableViewCell;
@property (nonatomic, strong) IBOutlet ProspectAppGeneralTableViewCell *generalTableViewCell;


@property (nonatomic,strong) IBOutlet SmartTableView* tableView;
@property (nonatomic, strong) Producer* detailItem;

@property (nonatomic, strong) IBOutlet DatePickerViewController *datePickerViewController;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *submitButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem* spaceButton;

@property (nonatomic, strong) UIPopoverController *prospectPopoverController;
@property (nonatomic, strong) NSMutableSet *fields;

- (IBAction)showDatePickerView:(id)sender;
- (IBAction)showSelectionTableView:(id)sender;

- (void) toggleSubmitButton:(BOOL)isEnabled;
- (BOOL) isEnableSubmit;

- (ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*) addressCell createAddressCellWithType:(NSInteger)forType;
- (void) saveTextFieldToContext:(UITextField*) textField;
- (IBAction)submitProspectApp:(id)sender;
- (IBAction)autoFormatPhoneNumber:(id) sender;
@end
