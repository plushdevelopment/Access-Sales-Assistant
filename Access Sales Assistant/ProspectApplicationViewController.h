//
//  ProspectApplicationViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"
#import "ProducerListTableViewController.h"
#import "Producer.h"
@interface ProspectApplicationViewController : BaseDetailViewController<UITableViewDelegate,UITableViewDataSource>
{
    BOOL viewShiftedForKeyboard;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    NSMutableArray* producerList;
    NSMutableArray* producerNamesArray;
}


@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;
@property(nonatomic,strong) IBOutlet UIScrollView* scrollView;
@property(nonatomic,strong) IBOutlet UIImageView* headerImage;


@property(nonatomic,strong) IBOutlet UIButton* searchProducer;
@property(nonatomic,strong) IBOutlet UIButton* subTerritory;
@property(nonatomic,strong) IBOutlet UIButton* mailingState;
@property(nonatomic,strong) IBOutlet UIButton* commissionState;
@property(nonatomic,strong) IBOutlet UIButton* physicalState;
@property(nonatomic,strong) IBOutlet UIButton* raterWeb;
@property(nonatomic,strong) IBOutlet UIButton* rater2;

@property(nonatomic,strong) IBOutlet UITextField *agencyName;
@property(nonatomic,strong) IBOutlet UITextField *tsmName;
@property(nonatomic,strong) IBOutlet UITextField *sourceText;
@property(nonatomic,strong) IBOutlet UITextField *mailingStreet;
@property(nonatomic,strong) IBOutlet UITextField *mailingCity;
@property(nonatomic,strong) IBOutlet UITextField *mailingZip;

@property(nonatomic,strong) IBOutlet UITextField *commissionStreet;
@property(nonatomic,strong) IBOutlet UITextField *commissionCity;
@property(nonatomic,strong) IBOutlet UITextField *commissionZip;
@property(nonatomic,strong) IBOutlet UITextField *physicalStreet;
@property(nonatomic,strong) IBOutlet UITextField *physicalCity;
@property(nonatomic,strong) IBOutlet UITextField *physicalZip;
@property(nonatomic,strong) IBOutlet UITextField *physicalStreet2;
@property(nonatomic,strong) IBOutlet UITextField *phone;
@property(nonatomic,strong) IBOutlet UITextField *email;
@property(nonatomic,strong) IBOutlet UITextField *fax;
@property(nonatomic,strong) IBOutlet UITextField *ownerFirstName;
@property(nonatomic,strong) IBOutlet UITextField *ownerLastName;
@property(nonatomic,strong) IBOutlet UITextField *primaryContactFirstName;
@property(nonatomic,strong) IBOutlet UITextField *primaryContactLastName;

@property (nonatomic, strong) UIPopoverController *prospectPopoverController;
@property (nonatomic,strong) UITableView* producerListTableView;
@property (nonatomic,strong) IBOutlet ProducerListTableViewController *pListTableViewController;
@property (nonatomic,strong) Producer* detailItem;



-(IBAction) searchProducerAction:(id)sender;
-(IBAction) subTerritoryAction:(id)sender;
-(IBAction) mailingStateAction:(id)sender;
-(IBAction)commissionStateAction:(id)sender;
-(IBAction)physicalStateAction:(id)sender;
-(IBAction)raterWebAction:(id)sender;
-(IBAction)rater2Action:(id)sender;

-(IBAction)submitProspectApplication:(id)sender;
-(IBAction)cancelProspectApplication:(id)sender;

-(void) showTableView;




@end
