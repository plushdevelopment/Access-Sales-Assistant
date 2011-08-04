//
//  ProspectApplicationViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProspectApplicationViewController.h"

#import "HTTPOperationController.h"
#import "Producer.h"
#import "User.h"
#import "DailySummary.h"
#import "PurposeOfCall.h"
#import "Status.h"
#import "AddressListItem.h"
#import "State.h"
#import "SubTerritory.h"
#import "PhoneListItem.h"
#import "EmailListItem.h"
#import "Rater.h"
#import "Rater2.h"
#import "Contact.h"
#import "ContactType.h"
//#import ""
@implementation ProspectApplicationViewController

#pragma mark - Synthesize
@synthesize toolBar = _toolBar;
@synthesize scrollView = _scrollView;
@synthesize headerImage = _headerImage;
@synthesize searchProducer = _searchProducer;
@synthesize subTerritory = _subTerritory;
@synthesize mailingState = _mailingState;
@synthesize commissionState = _commissionState;
@synthesize physicalState = _physicalState;
@synthesize raterWeb = _raterWeb;
@synthesize rater2 = _rater2;


@synthesize subTerritoryText = _subTerritoryText;
@synthesize mailingStateText = _mailingStateText;
@synthesize commissionStateText = _commissionStateText;
@synthesize physicalStateText = _physicalStateText;
@synthesize raterWebText = _raterWebText;
@synthesize rater2Text = _rater2Text;

@synthesize agencyName = _agencyName;
@synthesize tsmName = _tsmName;
@synthesize sourceText = _sourceText;
@synthesize mailingStreet = _mailingStreet;
@synthesize mailingCity = _mailingCity;
@synthesize mailingZip = _mailingZip;
@synthesize commissionStreet = _commissionStreet;
@synthesize commissionCity = _commissionCity;
@synthesize commissionZip = _commissionZip;
@synthesize physicalStreet = _physicalStreet;
@synthesize physicalStreet2 = _physicalStreet2;
@synthesize physicalCity = _physicalCity;
@synthesize physicalZip = _physicalZip;
@synthesize phone = _phone;
@synthesize email = _email;
@synthesize fax  = _fax;
@synthesize ownerFirstName = _ownerFirstName;
@synthesize ownerLastName = _ownerLastName;
@synthesize primaryContactFirstName = _primaryContactFirstName;
@synthesize primaryContactLastName = _primaryContactLastName;
@synthesize statusText = _statusText;
@synthesize customerEmail = _customerEmail;

@synthesize prospectPopoverController = _prospectPopoverController;
@synthesize producerListTableView = _producerListTableView;
@synthesize pListTableViewController = _pListTableViewController;
@synthesize detailItem = _detailItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    /*[[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewUpForKeyboard:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewDownAfterKeyboard)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
     */
    [super viewDidLoad];
    self.baseToolbar = _toolBar;
    CGSize contentSize = self.view.frame.size;
    contentSize.height-=_headerImage.frame.size.height;
    _scrollView.contentSize = contentSize;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
    
    [self setToolBar:nil];
    [self setAgencyName:nil];
    [self setTsmName:nil];
    [self setSubTerritory:nil];
    [self setSourceText:nil];
    [self setMailingStreet:nil];
    [self setMailingCity:nil];
    [self setMailingState:nil];
    [self setMailingZip:nil];
    [self setCommissionStreet:nil];
    [self setCommissionCity:nil];
    [self setCommissionState:nil];
    [self setCommissionZip:nil];
    [self setPhysicalStreet:nil];
    [self setPhysicalCity:nil];
    [self setPhysicalState:nil];
    [self setPhysicalZip:nil];
    [self setPhone:nil];
    [self setEmail:nil];
    [self setFax:nil];
    [self setRaterWeb:nil];
    [self setRater2:nil];
    [self setOwnerFirstName:nil];
    [self setPrimaryContactFirstName:nil];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Keyboard Notifications

- (void) shiftViewUpForKeyboard: (NSNotification*) theNotification;
{
    CGRect keyboardFrame;
    NSDictionary* userInfo = theNotification.userInfo;
    keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIInterfaceOrientation theStatusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if UIInterfaceOrientationIsLandscape(theStatusBarOrientation)
        keyboardShiftAmount = keyboardFrame.size.width;
    else 
        keyboardShiftAmount = keyboardFrame.size.height;
    
    [UIView beginAnimations: @"ShiftUp" context: nil];
    [UIView setAnimationDuration: keyboardSlideDuration];
    self.view.center = CGPointMake( self.view.center.x, self.view.center.y - keyboardShiftAmount);
    [UIView commitAnimations];
    viewShiftedForKeyboard = TRUE;
}

//------------------

- (void) shiftViewDownAfterKeyboard;
{
    if (viewShiftedForKeyboard)
    {
        [UIView beginAnimations: @"ShiftUp" context: nil];
        [UIView setAnimationDuration: keyboardSlideDuration];
        self.view.center = CGPointMake( self.view.center.x, self.view.center.y + keyboardShiftAmount);
        [UIView commitAnimations];
        viewShiftedForKeyboard = FALSE;
    }
}

#pragma mark - Button Actions
-(IBAction)searchProducerAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchProducerDone:) 
                                                 name:@"searchProducer"
                                               object:nil];
    [_agencyName resignFirstResponder];
    
  //  NSString* escapedString = [self.agencyName.text st]
    [[HTTPOperationController sharedHTTPOperationController] searchProducer:self.agencyName.text];  
}
-(void) searchProducerDone:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchProducer" object:nil];
    [producerNamesArray removeAllObjects];
    producerNamesArray = (NSMutableArray*) [notification object];
    [self showTableView];
    
    
   // NSLog(@"Producers List:%@",array);
}
-(IBAction)subTerritoryAction:(id)sender
{
    
}
-(IBAction)mailingStateAction:(id)sender
{
    
}
-(IBAction)commissionStateAction:(id)sender
{
    
}
-(IBAction)physicalStateAction:(id)sender
{
    
}
-(IBAction)raterWebAction:(id)sender
{
    
}
-(IBAction)rater2Action:(id)sender
{
    
}
-(IBAction)submitProspectApplication:(id)sender
{
    
}
-(IBAction)cancelProspectApplication:(id)sender
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [producerNamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]];
    }
    
    // Configure the cell...
    NSString* str= [[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"name"];//[producerList objectAtIndex:indexPath.row];
   // NSString *str= [[NSString alloc] initWithFormat:@"%@",[p name]];
    cell.textLabel.text = str;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.prospectPopoverController dismissPopoverAnimated:YES];
    //detailItem = 
     NSManagedObjectContext *context = [NSManagedObjectContext context];
    NSDictionary* dict = [producerNamesArray objectAtIndex:indexPath.row];
    
    _detailItem = (Producer*)[Producer ai_objectForProperty:@"uid" value:[dict valueForKey:@"uid"] managedObjectContext:context];
    
    //TSM name
    User *user = [User findFirst];
    
    _tsmName.text =  [user username];
    
    //Producer Name
    [self.agencyName setText:_detailItem.name];
    
    //Sub Territory
    NSString* subterritory = [[NSString alloc] initWithFormat:@"%d",_detailItem.subTerritory.uid];
    [self.subTerritoryText setText:subterritory];
    //Source
    [self.sourceText setText:_detailItem.dailySummary.purposeOfCall.name];
    
    //Status
    [self.statusText setText:_detailItem.status.name];
    
    
    //Addresses
    for (AddressListItem *address in _detailItem.addresses) {
        if (address.addressTypeValue == 1) {
            [self.mailingStreet setText:address.addressLine1];
            [self.mailingCity setText:address.city];
         
            
            [self.mailingStateText setText:address.state.name];
            [self.mailingZip setText:address.postalCode];
        } else if (address.addressTypeValue == 2) {
            [self.commissionStreet setText:address.addressLine1];
            [self.commissionCity setText:address.city];
            [self.commissionStateText setText:address.state.name];
            [self.commissionZip setText:address.postalCode];
        } else if (address.addressTypeValue == 3) {
            [self.physicalStreet setText:address.addressLine1];
            [self.physicalCity setText:address.city];
            [self.physicalStateText setText:address.state.name];
            [self.physicalZip setText:address.postalCode];
        }
    }
    
    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers) {
        if (phoneNumber.typeValue == 1) {
         
        } else if (phoneNumber.typeValue == 2) {
           
        } else if (phoneNumber.typeValue == 3) {
            [self.phone setText:phoneNumber.number];
        } else if (phoneNumber.typeValue == 4) {
            [self.fax setText:phoneNumber.number];
        }
    }
    for (EmailListItem *email in _detailItem.emails) {
        if (email.typeValue == 1) {
          //  [self.emailAddressTextField setText:email.address];
        } else if (email.typeValue == 2) {
           
        } else if (email.typeValue == 3) {
            [self.email setText:email.address];
        } else if (email.typeValue == 4) {
            [self.customerEmail setText:email.address];
        } else if (email.typeValue == 5) {
          
        }
    }
    
    [self.raterWebText setText:_detailItem.rater.name];
    [self.rater2Text setText:_detailItem.rater2.name];
    
    
    for (Contact *cnt in _detailItem.contacts)
    {
        NSLog(cnt.type.name);
        if(cnt.type.name == @"Owner" )
        {
            [self.ownerFirstName setText:cnt.firstName];
        }
    else if(cnt.type.name == @"Primary Contact")
    {
        [self.primaryContactFirstName setText:cnt.firstName];
    }
}

   // [self.ownerLastName setText:_detailItem.co]
    

}
-(void) showTableView
{
   // self.pickerViewController.currentTag = button.tag;
    
	[self.pListTableViewController setContentSizeForViewInPopover:CGSizeMake(344.0, 259.0)];
	_prospectPopoverController = [[UIPopoverController alloc] initWithContentViewController:self.pListTableViewController];
    
    CGRect rectPopOver = CGRectMake(_agencyName.frame.origin.x, _scrollView.frame.origin.y + _agencyName.frame.origin.y, _agencyName.frame.size.width, _agencyName.frame.size.height);
	[self.prospectPopoverController presentPopoverFromRect:rectPopOver inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    UITableView *tableView =self.pListTableViewController.tableView;
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    [tableView reloadData];
}


@end
