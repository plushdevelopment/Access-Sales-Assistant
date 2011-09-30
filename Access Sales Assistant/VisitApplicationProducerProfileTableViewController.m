//
//  VisitApplicationProducerProfileTableViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationProducerProfileTableViewController.h"
#import "Access_Sales_AssistantAppDelegate.h"
#import "UITableView+PRPSubviewAdditions.h"
#import "ProducerQuestionTableViewCell.h"
#import "ProducerStatusTableViewCell.h"
#import "ProducerRaterTableViewCell.h"
#import "ProducerHoursTableViewCell.h"
#import "ProducerContactInfoTableViewCell.h"
#import "ProducerAddressTableViewCell.h"
#import "ProducerContactTableViewCell.h"
#import "AddRowTableViewCell.h"
#import "ProducerProfileConstants.h"
#import "HTTPOperationController.h"
#import "NSString-Validation.h"
#import <QuartzCore/QuartzCore.h>
#import "UIHelpers.h"
#import "SelectionModelViewController.h"
#import "AccessSalesConstants.h"

@implementation VisitApplicationProducerProfileTableViewController

@synthesize detailItem = _detailItem;
@synthesize selectionTableView = _selectionTableView;
@synthesize popoverController;
@synthesize datePickerViewController = _datePickerViewController;
@synthesize statusCell = _statusCell;
@synthesize generalTableViewCell = _generalTableViewCell;
@synthesize questionTableViewCell = _questionTableViewCell;
@synthesize tableView = _tableView;
@synthesize raterTableViewCell = _raterTableViewCell;
@synthesize contactInfoTableViewCell = _contactInfoTableViewCell;
@synthesize hoursTableViewCell = _hoursTableViewCell;
@synthesize addressTableViewCell = _addressTableViewCell;
@synthesize contactTableViewCell = _contactTableViewCell;
@synthesize lastVisitedCell = _lastVisitedCell;
@synthesize dismissButton = _dismissButton;
@synthesize submitButton = _submitButton;
@synthesize isDoneSelected = _isDoneSelected;
@synthesize profileGeneralTableViewCellNib = _profileGeneralTableViewCellNib;
@synthesize fields=_fields;
@synthesize titleLabel = _titleLabel;

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender
{
	[[HTTPOperationController sharedHTTPOperationController] postProducerProfile:[self.detailItem jsonStringValue]];
}

- (IBAction)navigateToProducer:(id)sender
{
	NSString *url = [NSString stringWithFormat:@"motionxgpsdrivehd://dest?lat=%f&lon=%f", self.detailItem.latitudeValue, self.detailItem.longitudeValue];
	UIApplication *app = [UIApplication sharedApplication];
	[app openURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)postProducerSuccess:(id)notification
{
	[UIHelpers showAlertWithTitle:@"Success" msg:PRODUCER_PROFILE_REQUEST_SUCCESS buttonTitle:@"OK"];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	
    [super viewDidLoad];
    
	self.fields = [NSMutableSet set];
	
    sectionTitleArray = [[NSArray alloc] initWithObjects:PRODUCER_PROFILE_SECTIONS];
    
    self.tableView.allowsSelection = NO;
    
    myTextFieldSemaphore =0;
    myPhoneNumberFormatter = [[PhoneNumberFormatter alloc] init];
    
	
    self.tableView.backgroundColor = [UIColor clearColor];
    _isDoneSelected = TRUE;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postProducerSuccess:) name:@"Post Producer Successful" object:nil];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.view setNeedsDisplay];
}
-(void) toggleSubmitButton:(BOOL) isEnable
{
    [_submitButton setEnabled:isEnable];
}
- (void)setDetailItem:(id)newDetailItem
{
	if (self.detailItem) {
		[[NSManagedObjectContext defaultContext] save];
	}
	
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
	[self toggleSubmitButton:[self isEnableSubmit]];
    _titleLabel.text = [[NSString alloc]initWithFormat:@"%@ - %@",_detailItem.name,_detailItem.producerCode];
}

- (void)configureView
{
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	if(_detailItem.lastVisit)
		return [sectionTitleArray count];
	else
		return ([sectionTitleArray count] - 1);
    
    return 0;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch(section)
    {
        case ELastVisited:
        {
            if(_detailItem.lastVisit)
                return 1;
            else
                return 0;
        }
        case EGeneral:
            return 1;
        case EQuestions:
            return _detailItem.questions.allObjects.count;
        case EAddresses:
            return 3;
        case ECompanyContactInfo:
            return 1;
        case EHoursOfOperation:
            return 1;
        case EContacts:
        {
            int count = _detailItem.contacts.allObjects.count;
            return count+1;
        }
        default:
            return 1;
    }
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitleArray objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	
    switch(indexPath.section)
    {
        case ELastVisited:
        {
            
            LastVisitedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LastVisitedTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"LastVisitedTableViewCell" owner:self options:nil];
                cell = (LastVisitedTableViewCell*)_lastVisitedCell;
            }
			
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            
			
            NSString* lastVisitedText = [[NSString alloc] initWithFormat:@"%@",[dateFormatter stringFromDate:_detailItem.lastVisit]];
            
            cell.visitedLabel.text = lastVisitedText;
            cell.summaryNotesTextView.text = _detailItem.lastVisitSummaryNote;
            return cell;
        }
			break;
        case EGeneral:
        {
        
            ProducerGeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerGeneralTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerGeneralTableViewCell" owner:self options:nil];
                cell = (ProducerGeneralTableViewCell*)_generalTableViewCell;
            }
			cell.producerCodeTextField.text = self.detailItem.producerCode;
            
            [self disableTextField:cell.producerCodeTextField :NO];
			cell.producerNameTextField.text = self.detailItem.name;
            cell.numberOfEmployeesTextField.text = [[NSString alloc]initWithFormat:@"%@",_detailItem.numberOfEmployees];
            cell.accessSignTextField.text = _detailItem.hasAccessSignValue?@"Yes":@"No";
            cell.subTerritoryTextField.text = _detailItem.subTerritory.uid.stringValue;
            cell.numberOfLocationsTextField.text = _detailItem.numberOfLocations.stringValue;
			
			[self.fields addObject:cell.producerNameTextField];
			[self.fields addObject:cell.numberOfEmployeesTextField];
			[self.fields addObject:cell.numberOfLocationsTextField];
			[self.fields addObject:cell.subTerritoryTextField];
            [self.fields addObject:cell.primaryContactTextField];
			
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            
            cell.eOExpiresTextField.text = [dateFormatter stringFromDate:_detailItem.eAndOExpires];
			[self disableTextField:cell.eOExpiresTextField :NO];
			cell.eOExpiresTextField.enabled = NO;
            cell.dateEstablishedTextField.text = [dateFormatter stringFromDate:_detailItem.dateEstablished];
            
            cell.primaryContactTextField.text = _detailItem.primaryContact;
            
            if(_detailItem.neverVisitValue)
                cell.neverVisitCustomSwitch.on = TRUE;
            else
                cell.neverVisitCustomSwitch.on = FALSE;
            
            if(_detailItem.hasAccessSignValue)
                cell.accessSignCustomSwitch.on = TRUE;
            else
                cell.accessSignCustomSwitch.on = FALSE;
            
            
            return cell;
        }
        case EQuestions:
        {
            ProducerQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerQuestionTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerQuestionTableViewCell" owner:self options:nil];
                cell = (ProducerQuestionTableViewCell*)_questionTableViewCell;
            }
            
            NSArray* questionArray=_detailItem.questions.allObjects;
            QuestionListItem *qListItem = (QuestionListItem *)[questionArray objectAtIndex:indexPath.row];
            cell.questionLabel.text = qListItem.text;
            cell.answerTextField.text = qListItem.answer;
			
			[self.fields addObject:cell.answerTextField];
			
            return cell;
			
        }
            
        case EStatus:
        {
            
            ProducerStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerStatusTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerStatusTableViewCell" owner:self options:nil];
                cell = (ProducerStatusTableViewCell*)_statusCell;
            }
            [self statusTableViewCell:cell statusCellForRow:indexPath.row];
            return cell;
        }
        case ERater:
        {
            ProducerRaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerRaterTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerRaterTableViewCell" owner:self options:nil];
                cell = (ProducerRaterTableViewCell*)_raterTableViewCell;
            }
            
            [self raterTableViewCell:cell raterCellForRow:indexPath.row];
			
			if (self.detailItem.rater) {
				[cell.rater2Button setEnabled:YES];
				[self disableTextField:cell.rater2TextField :YES];
				cell.rater2TextField.enabled = NO;
			} else {
				[cell.rater2Button setEnabled:NO];
				[self disableTextField:cell.rater2TextField :NO];
				cell.rater2TextField.enabled = NO;
			}
			
            return cell;
        }
        case ECompanyContactInfo:
        {
                    
            ProducerContactInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerContactInfoTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerContactInfoTableViewCell" owner:self options:nil];
                cell = (ProducerContactInfoTableViewCell*)_contactInfoTableViewCell;
            }
            
            
            [self contactInfoTableViewCell:cell contactInfoForRow:indexPath.row];
			
			[self.fields addObject:cell.phone1TextField];
			[self.fields addObject:cell.faxTextField];
			[self.fields addObject:cell.mainMailTextField];
			[self.fields addObject:cell.claimsMailTextField];
            [self.fields addObject:cell.acctMailTextField];
			[self.fields addObject:cell.custServMailTextField];
			[self.fields addObject:cell.webAddrTextField];
			
            return cell;
        }
        case EHoursOfOperation:
        {
            
            ProducerHoursTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerHoursTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerHoursTableViewCell" owner:self options:nil];
                cell = (ProducerHoursTableViewCell*)_hoursTableViewCell;
            }
            [self hoursOfOperationCell:cell hoursCellForRow:indexPath.row];
            return cell;
        }
        case EAddresses:
        {
            ProducerAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerAddressTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProducerAddressTableViewCell" owner:self options:nil];
                cell = (ProducerAddressTableViewCell*)_addressTableViewCell;
            }
            
            if(indexPath.row ==0)
            {
                cell.addressTitle.text = @"Mailing Address*";
                cell = [self addressTableViewCell:cell createAddressCellForType:1];
				
            }
            else if(indexPath.row==1)
            {
				cell.addressTitle.text = @"Commission Address*";
				cell = [self addressTableViewCell:cell createAddressCellForType:2];
				
            }
            else if(indexPath.row == 2)
            {
                cell.addressTitle.text = @"Physical Address*";
                cell = [self addressTableViewCell:cell createAddressCellForType:3];
				
            }
            
			[self.fields addObject:cell.streetAddress1TextField];
			[self.fields addObject:cell.streetAddress2TextField];
			[self.fields addObject:cell.cityTextField];
			[self.fields addObject:cell.zipTextField];
			
            return cell;
        }
        case EContacts:
        {
            if(indexPath.row == _detailItem.contacts.allObjects.count)
            {
                AddRowTableViewCell* cell = [AddRowTableViewCell cellForTableView:tableView fromNib:[AddRowTableViewCell nib]];
                cell.addRowType.text = @"Add Person";
                
				
                UIButton *button = cell.addButton;
                button.tag = 1001;
                
                [button addTarget:self action:@selector(AddContact:) forControlEvents:UIControlEventTouchUpInside];
                
                [button setEnabled:isContactsEdited?FALSE:TRUE];
                
                cell.delRowType.text = @"Delete Person";
                UIButton *remBtn = cell.editButton;
                [remBtn setTitle:isContactsEdited?@"Done":@"Edit" forState:UIControlStateNormal];
                [remBtn setEnabled:isContactsEdited?TRUE:((indexPath.row>0)?TRUE:FALSE)];
                remBtn.tag = 1002;
                
                [remBtn addTarget:self action:@selector(AddContact:) forControlEvents:UIControlEventTouchUpInside];
				
                return cell;
				
            }
            else
            {
                
                ProducerContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProducerContactTableViewCell"];
                if (cell == nil) {
                    // Load the top-level objects from the custom cell XIB.
                    [[NSBundle mainBundle] loadNibNamed:@"ProducerContactTableViewCell" owner:self options:nil];
                    cell = (ProducerContactTableViewCell*)_contactTableViewCell;
                }
                
                cell = [self contactTableViewCell:cell createContactCellForType:indexPath.row];
				
				[self.fields addObject:cell.firstNameTextField];
				[self.fields addObject:cell.lastNameTextField];
				[self.fields addObject:cell.mobilePhoneTextField];
				[self.fields addObject:cell.emailAddressTextField];
				[self.fields addObject:cell.socialSecurityNumberTextField];
				
				return cell;
            }
        }
            
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
    switch (indexPath.section) {
        case ELastVisited:
        {
            height = 200;
            break;
        }
        case EGeneral:
        {
            height = 234.0;
        }
            break;
        case EQuestions:
        {
            height = 44.0;
        }
            break;
        case EStatus:
        {
            height = 150.0;
        }
            break;
        case ERater:
        {
            height = 44;
        }
            break;
        case ECompanyContactInfo:
        {
            height = 234;
            break;
        }
            
        case EHoursOfOperation:
        {
            height = 186.0;
            break;
        }
        case EAddresses:
        {
            height = 72;
            break;
        }
        case EContacts:
        {
            if (indexPath.row == _detailItem.contacts.allObjects.count) {
                height =44.0;
            }
            else
                height = 150.0;
            break;
        }
        default:
            height = 110.0;
            
    }
	
    return height;
}

-(UITableViewCell*) tableViewCellForNibName:(NSString *)nibName
{
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    
    UITableViewCell* cell = nil;
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[UITableViewCell class]])
        {
            cell = (UITableViewCell *)currentObject;
            break;
        }
    }
    
    return cell;
}

#pragma mark - Create new or fill table view cell with entity values

-(void) AddContact:(id) sender
{
    UIButton* btn = (UIButton*) sender;
	self.detailItem.editedValue = YES;
    if(btn.tag == 1001)
    {
        Contact* newContact = [Contact createEntity];
		newContact.editedValue = YES;
        [self.detailItem addContactsObject:newContact];
		[[NSManagedObjectContext defaultContext]save];
        [self.tableView reloadData];
    }
    else if(btn.tag == 1002)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
			[btn setTitle:@"Done" forState:UIControlStateNormal];
			isContactsEdited = TRUE;
            
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            isContactsEdited = FALSE;
        }
		
        [self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}


-(ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*) addressCell createAddressCellForType:(NSInteger)forType
{
    BOOL isCommissionAddrFound = FALSE,isPhysicalAddrFound,isMailingAddrFound=FALSE,isCurrentAddrFound=FALSE;
    
    AddressListItem *mailingAddress=nil, *commissionAddress=nil, *physicalAddress=nil;
    for(AddressListItem *addrItem in _detailItem.addresses)
    {
        if(addrItem.addressTypeValue == forType)
        {
            [self fillAddressCellForType:addressCell fillAddressWithItem:addrItem forAddressType:0];      
            isCurrentAddrFound= TRUE;
            break;
        }
        if(addrItem.addressTypeValue == MAILING_ADDRESS)
        {
            isMailingAddrFound = TRUE;
            mailingAddress = addrItem;
            
        }
        else if(addrItem.addressTypeValue == COMMISSION_ADDRESS)
        {
            isCommissionAddrFound = TRUE;
            commissionAddress = addrItem;
        }
        else if(addrItem.addressTypeValue == PHYSICAL_ADDRESS)
        {
            isPhysicalAddrFound = TRUE;
            physicalAddress = addrItem;
        }
        
    }
    
	if(isCurrentAddrFound)
		return addressCell;
    else
    {
        if(isMailingAddrFound)
        {
            [self fillAddressCellForType:addressCell fillAddressWithItem:mailingAddress forAddressType:forType];
        }
        else if(isCommissionAddrFound)
        {
            [self fillAddressCellForType:addressCell fillAddressWithItem:commissionAddress forAddressType:forType];
        }
        else if(isPhysicalAddrFound)
        {
            [self fillAddressCellForType:addressCell fillAddressWithItem:physicalAddress forAddressType:forType];
        }
        return addressCell;
    }
	return addressCell;
	
}

-(void)fillAddressCellForType:(ProducerAddressTableViewCell*)addressCell fillAddressWithItem:(AddressListItem*) withAddrItem forAddressType: (NSInteger) forType
{
    AddressListItem *newAddressListItem = nil;
    if(forType == 0)
    {
        newAddressListItem = withAddrItem;
        
        addressCell.streetAddress1TextField.text = withAddrItem.addressLine1;
        
        addressCell.streetAddress2TextField.text = withAddrItem.addressLine2;
        
        addressCell.cityTextField.text = withAddrItem.city;
        
        addressCell.stateTextField.text = withAddrItem.state.name;
        
        addressCell.zipTextField.text = withAddrItem.postalCode;
        
        
    }
    else
    {
        newAddressListItem = [AddressListItem createEntity];
        newAddressListItem.addressTypeValue = forType;
        newAddressListItem.addressLine1 = withAddrItem.addressLine1;
        newAddressListItem.addressLine2 = withAddrItem.addressLine2;
        newAddressListItem.city = withAddrItem.city;
        
        newAddressListItem.state = [State findFirstByAttribute:@"name" withValue: withAddrItem.state.name];
       
        newAddressListItem.postalCode = withAddrItem.postalCode;
        [self.detailItem addAddressesObject:newAddressListItem];
    }
    
    addressCell.streetAddress1TextField.text = newAddressListItem.addressLine1;
    addressCell.streetAddress2TextField.text = newAddressListItem.addressLine2;
    addressCell.cityTextField.text = newAddressListItem.city;
    addressCell.stateTextField.text = newAddressListItem.state.name;
    addressCell.zipTextField.text = newAddressListItem.postalCode;
    
    [[NSManagedObjectContext defaultContext] save];
}

-(ProducerContactTableViewCell*) contactTableViewCell:(ProducerContactTableViewCell*) contactCell createContactCellForType:(NSInteger)forRow
{
    NSArray* contactArray = _detailItem.contacts.allObjects;
    
    Contact* tContact = [contactArray objectAtIndex:forRow];
    
	
    contactCell.firstNameTextField.text = tContact.firstName;
    contactCell.lastNameTextField.text = tContact.lastName;
    contactCell.socialSecurityNumberTextField.text = tContact.ssn;
	contactCell.titleTextField.text = tContact.type.name;
	for (PhoneListItem *phone in tContact.phoneNumbers) {
		if (phone.typeValue == 4) {
			contactCell.faxTextField.text = phone.number;
		} else if (phone.typeValue == 5) {
			contactCell.mobilePhoneTextField.text = phone.number;
		}
	}
	for (EmailListItem *email in tContact.emails) {
		if (email.typeValue == 5) {
			contactCell.emailAddressTextField.text = email.address;
		}
	}
    if([tContact.type.name isEqualToString:@"Agent"])
        [self disableTextField:contactCell.socialSecurityNumberTextField :NO];
    else
        [self disableTextField:contactCell.socialSecurityNumberTextField :YES];
    
    return contactCell;
}
-(ProducerContactInfoTableViewCell*) contactInfoTableViewCell:(ProducerContactInfoTableViewCell*) contactInfoCell contactInfoForRow:(NSInteger)forRow
{
    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers) {
        if (phoneNumber.typeValue == 1) {
			[contactInfoCell.phone1TextField setText:phoneNumber.number];
        } else if (phoneNumber.typeValue == 2) {
        } else if (phoneNumber.typeValue == 3) {
            
        } else if (phoneNumber.typeValue == 4) {
            [contactInfoCell.faxTextField setText:phoneNumber.number];
        }
        
    }
    BOOL isAccountMailFound=FALSE,isMainMailFound=FALSE,isCustServiceMailFound=FALSE,isClaimsMailFound=FALSE;
    EmailListItem* acctMailItem,*mainMailItem,*custMailItem,*claimsMailItem;
    
    for (EmailListItem *email in _detailItem.emails) {
        
        if (email.typeValue == ACCOUNTING_EMAIL) {
            if([email.address length]>0)
            {
                isAccountMailFound = TRUE;
                acctMailItem = email;
            }
        } else if (email.typeValue == MAIN_EMAIL) {
			
            if([email.address length]>0)
            {
                isMainMailFound = TRUE;
                mainMailItem = email;
            }
        } else if (email.typeValue == CUSTOMER_SERVICE_EMAIL) {
			
            if([email.address length]>0)
            {
                isCustServiceMailFound = TRUE;
                custMailItem = email;
            }
        } else if (email.typeValue == CLAIMS_EMAIL) {
			
            if([email.address length]>0)
            {
                isClaimsMailFound = TRUE;
                claimsMailItem = email;
            }
        }
    }
    
	EmailListItem *emailToUse = isMainMailFound?mainMailItem:(isAccountMailFound?acctMailItem:(isCustServiceMailFound?custMailItem:(isClaimsMailFound?claimsMailItem:nil)));
	
    
    if(isAccountMailFound)
    {
        [contactInfoCell.acctMailTextField setText:acctMailItem.address];
    }
    else
    {
        if(emailToUse)
        {
            EmailListItem* newMailItem = [self createNewEmailItem:emailToUse createEmailForType:ACCOUNTING_EMAIL];
            [contactInfoCell.acctMailTextField setText:newMailItem.address];
        }
    }
    
    if(isMainMailFound)
    {
        
        [contactInfoCell.mainMailTextField setText:mainMailItem.address];
    }
    else
    {
        if(emailToUse)
        {
			EmailListItem* newMailItem = [self createNewEmailItem:emailToUse createEmailForType:MAIN_EMAIL];
            [contactInfoCell.mainMailTextField setText:newMailItem.address];
        }
    }
    if(isCustServiceMailFound)
    {
        [contactInfoCell.custServMailTextField setText:custMailItem.address];
    }
    else
    {
        if(emailToUse)
        {
            EmailListItem* newMailItem = [self createNewEmailItem:emailToUse createEmailForType:CUSTOMER_SERVICE_EMAIL];
            [contactInfoCell.custServMailTextField setText:newMailItem.address];
        }
    }
    
    if(isClaimsMailFound)
    {
        [contactInfoCell.claimsMailTextField setText:claimsMailItem.address];
    }
    else
    {
        if(emailToUse)
        {
			EmailListItem* newMailItem = [self createNewEmailItem:emailToUse createEmailForType:CLAIMS_EMAIL];//[EmailListItem createEntity];
            [contactInfoCell.claimsMailTextField setText:newMailItem.address];
        }
    }
    
    
    [contactInfoCell.webAddrTextField setText:_detailItem.webAddress];
    return contactInfoCell;
	
}

-(EmailListItem*)createNewEmailItem:(EmailListItem*) withEmailItem createEmailForType:(NSInteger) forType
{
    EmailListItem* newMailItem = [EmailListItem createEntity];
    newMailItem.typeValue = forType;
    newMailItem.address = withEmailItem.address;
    [self.detailItem addEmailsObject:newMailItem];
    return newMailItem;
	
}

-(void) raterTableViewCell:(ProducerRaterTableViewCell*) raterCell raterCellForRow:(NSInteger)forRow
{
    [raterCell.raterTextField setText:_detailItem.rater.name];
    [raterCell.rater2TextField setText:_detailItem.rater2.name];
}

-(void) statusTableViewCell:(ProducerStatusTableViewCell*) statusCell statusCellForRow:(NSInteger)forRow
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
	
    Status * tStatus = _detailItem.status;
    statusCell.statusTextField.text = tStatus.name;
    [self disableTextField:statusCell.statusTextField :NO];
    statusCell.appointedDateTextField.text = [dateFormatter stringFromDate:_detailItem.appointedDate];
    [self disableTextField:statusCell.appointedDateTextField :NO];
    statusCell.eligibleTextField.text = _detailItem.isEligibleValue?@"YES":@"NO";
    statusCell.statusDateTextField.text = [dateFormatter stringFromDate:_detailItem.statusDate];
    [self disableTextField:statusCell.statusDateTextField :NO];
    statusCell.suspensionReasonTextField.text = _detailItem.suspensionReason.name;
    [self disableTextField:statusCell.suspensionReasonTextField :NO];
    
    if(_detailItem.isEligibleValue)
        statusCell.eligibleCustomSwitch.on = TRUE;
    else
        statusCell.eligibleCustomSwitch.on = FALSE;
    
    
    if(_detailItem.isEligibleValue)
    {
        IneligibleReason *ineligibleObj = _detailItem.ineligibleReason;
        if(ineligibleObj)
        {
            _detailItem.ineligibleReason = nil;
            
        }
    }
    
    
        statusCell.reasonIneligibleTextField.text = _detailItem.ineligibleReason.name;
        statusCell.reasonIneligibleTextField.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
        statusCell.reasonIneligibleButton.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
        statusCell.reasonIneligibleLabel.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
	
}

-(void) hoursOfOperationCell:(ProducerHoursTableViewCell*)hoursCell hoursCellForRow:(NSInteger)forRow
{
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    
    HoursOfOperation *hOfOperation = _detailItem.hoursOfOperation;
    
    BOOL isMondayHoursExists = ([hOfOperation.mondayOpenTime.name length]>0 && [hOfOperation.mondayCloseTime.name length]>0)?TRUE:NO;
    
    [hoursCell.monStartTextField setText:hOfOperation.mondayOpenTime.name];
    [hoursCell.monStopTextField setText:hOfOperation.mondayCloseTime.name];
	
    if(isMondayHoursExists)
    {
		
        {
			
			[self toggleHoursOfOperationCell:hoursCell isEnableHoursCell:TRUE];
			hOfOperation.tuesdayOpenTime = [hOfOperation.tuesdayOpenTime.name length]>0?hOfOperation.tuesdayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.tueStartTextField setText:[hOfOperation.tuesdayOpenTime.name length]>0?hOfOperation.tuesdayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.tuesdayCloseTime = [hOfOperation.tuesdayCloseTime.name length]>0?hOfOperation.tuesdayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.tueStopTextField setText:[hOfOperation.tuesdayCloseTime.name length]>0?hOfOperation.tuesdayCloseTime.name:hOfOperation.mondayCloseTime.name];
			
			hOfOperation.wednesdayOpenTime = [hOfOperation.wednesdayOpenTime.name length]>0?hOfOperation.wednesdayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.wedStartTextField setText:[hOfOperation.wednesdayOpenTime.name length]>0?hOfOperation.wednesdayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.wednesdayCloseTime = [hOfOperation.wednesdayCloseTime.name length]>0?hOfOperation.wednesdayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.wedStopTextField setText:[hOfOperation.wednesdayCloseTime.name length]>0?hOfOperation.wednesdayCloseTime.name:hOfOperation.mondayCloseTime.name];
			
			hOfOperation.thursdayOpenTime = [hOfOperation.thursdayOpenTime.name length]>0?hOfOperation.thursdayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.thuStartTextField setText:[hOfOperation.thursdayOpenTime.name length]>0?hOfOperation.thursdayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.thursdayCloseTime = [hOfOperation.thursdayCloseTime.name length]>0?hOfOperation.thursdayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.thuStopTextField setText:[hOfOperation.thursdayCloseTime.name length]>0?hOfOperation.thursdayCloseTime.name:hOfOperation.mondayCloseTime.name];
			
			hOfOperation.fridayOpenTime = [hOfOperation.fridayOpenTime.name length]>0?hOfOperation.fridayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.friStartTextField setText:[hOfOperation.fridayOpenTime.name length]>0?hOfOperation.fridayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.fridayCloseTime = [hOfOperation.fridayCloseTime.name length]>0?hOfOperation.fridayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.friStopTextField setText:[hOfOperation.fridayCloseTime.name length]>0?hOfOperation.fridayCloseTime.name:hOfOperation.mondayCloseTime.name];
			
			hOfOperation.saturdayOpenTime = [hOfOperation.saturdayOpenTime.name length]>0?hOfOperation.saturdayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.satStartTextField setText:[hOfOperation.saturdayOpenTime.name length]>0?hOfOperation.saturdayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.saturdayCloseTime = [hOfOperation.saturdayCloseTime.name length]>0?hOfOperation.saturdayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.satStopTextField setText:hOfOperation.saturdayCloseTime.name ];
			
			hOfOperation.sundayOpenTime = [hOfOperation.sundayOpenTime.name length]>0?hOfOperation.sundayOpenTime:hOfOperation.mondayOpenTime;
			[hoursCell.sunStartTextField setText:[hOfOperation.sundayOpenTime.name length]>0?hOfOperation.sundayOpenTime.name:hOfOperation.mondayOpenTime.name];
			
			hOfOperation.sundayCloseTime = [hOfOperation.sundayCloseTime.name length]>0?hOfOperation.sundayCloseTime:hOfOperation.mondayCloseTime;
			[hoursCell.sunStopTextField setText:hOfOperation.sundayCloseTime.name];
        }
	}
    else 
    {
        [self toggleHoursOfOperationCell:hoursCell isEnableHoursCell:FALSE];
    }
    
}

-(void) toggleHoursOfOperationCell:(ProducerHoursTableViewCell*) hoursCell isEnableHoursCell:(BOOL) isEnabled
{
    [hoursCell.tueStartTextField setEnabled:isEnabled];
    [hoursCell.tueStartButton setEnabled:isEnabled];
    [self disableTextField:hoursCell.tueStartTextField :isEnabled];
    
    [hoursCell.tueStopTextField setEnabled:isEnabled];
	[hoursCell.tueStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.tueStopTextField :isEnabled];
    
    [hoursCell.wedStartTextField setEnabled:isEnabled];
	[hoursCell.wedStartButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.wedStartTextField :isEnabled];
    
    [hoursCell.wedStopTextField setEnabled:isEnabled];
	[hoursCell.wedStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.wedStopTextField :isEnabled];
    
    [hoursCell.thuStartTextField setEnabled:isEnabled];
	[hoursCell.thuStartButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.thuStartTextField :isEnabled];
    
    [hoursCell.thuStopTextField setEnabled:isEnabled];
	[hoursCell.thuStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.thuStopTextField :isEnabled];
    
    [hoursCell.friStartTextField setEnabled:isEnabled];
	[hoursCell.friStartButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.friStartTextField :isEnabled];
    
    [hoursCell.friStopTextField setEnabled:isEnabled];
	[hoursCell.friStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.friStopTextField :isEnabled];
    
    [hoursCell.satStartTextField setEnabled:isEnabled];
	[hoursCell.satStartButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.satStartTextField :isEnabled];
    
    [hoursCell.satStopTextField setEnabled:isEnabled];
	[hoursCell.satStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.satStopTextField :isEnabled];
    
    [hoursCell.sunStartTextField setEnabled:isEnabled];
	[hoursCell.sunStartButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.sunStartTextField :isEnabled];
    
    [hoursCell.sunStopTextField setEnabled:isEnabled];
	[hoursCell.sunStopButton setEnabled:isEnabled];
	[self disableTextField:hoursCell.sunStopTextField :isEnabled];
	
}

-(OperationHour*) assignHour:(OperationHour*)withHour assignToHour:(OperationHour*) toHour forHoursOfOperation:(HoursOfOperation*) hoursOperation hoursForDay:(NSInteger) forDay isHoursOpen:(BOOL)isOpen
{
    toHour = [OperationHour createEntity];
    toHour.name = withHour.name;
    return toHour;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if(indexPath.section == EContacts && indexPath.row < _detailItem.contacts.allObjects.count)
        return YES;
    else
        return  NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		
        if(indexPath.section == EContacts && indexPath.row < _detailItem.contacts.allObjects.count)
        {
            NSArray* arr = _detailItem.contacts.allObjects;
			
            Contact* cToDel = [arr objectAtIndex:indexPath.row];
			if (cToDel.uid) {
				[[HTTPOperationController sharedHTTPOperationController] deleteContact:cToDel.uid];
			}
			
            [cToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
            [self.tableView reloadData];
            [self.tableView setNeedsDisplay];
        }
		
		
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
       
    }   
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(-15, 0, tableView.bounds.size.width+30, 25)];
    
    UIImageView* headerBg = [[UIImageView alloc] initWithFrame:headerView.frame];
    UIImage* hImg = [UIImage imageNamed:@"MenuButton.png"];
    headerBg.image = hImg;
    UILabel* headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, tableView.bounds.size.width-5, 20)];
    headerTitle.text = [sectionTitleArray objectAtIndex:section];
    headerTitle.font= [UIFont fontWithName:@"TrebuchetMS-Bold" size:16.0];
    headerTitle.textColor = [UIColor whiteColor];
    headerTitle.backgroundColor = [UIColor clearColor];
    [headerView addSubview:headerBg];
    [headerView addSubview:headerTitle];
	
    return headerView;
}
// Show the Date picker in Date mode in a popover
- (IBAction)showDatePickerView:(id)sender
{
	
	UIButton *button = (UIButton *)sender;
  /*  NSString *viewFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.parentViewController.view.frame.origin.x, self.parentViewController.view.frame.origin.y, self.parentViewController.view.frame.size.height, self.parentViewController.view.frame.size.width];*/
	
	[self.datePickerViewController.datePicker setDate:[NSDate date]];
	self.datePickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.datePickerViewController.currentTag = button.tag;
	[self.datePickerViewController.datePicker setDatePickerMode:UIDatePickerModeDate];
	
	//Position the picker out of sight
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
	
    
 /*   NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];*/
	
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.datePickerViewController.view];
    
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME_LANDSCAPE];
		} else {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		}
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.datePickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		NSNotification *notification = [NSNotification notificationWithName:UIKeyboardDidShowNotification object:nil userInfo:userInfo];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}];
	[self datePickerViewController:self.datePickerViewController didChangeDate:self.datePickerViewController.datePicker.date forTag:button.tag];
    
	[self.tableView reloadData];
	
}

-(IBAction)neverVisitToggle:(id)sender
{
    UISwitch *neverSwitch = (UISwitch*) sender;
    
    if(neverSwitch.isOn)
        _detailItem.neverVisitValue= TRUE;
    else
        _detailItem.neverVisitValue = FALSE;
}

-(IBAction)handleCustomSwitchToggle:(id)sender
{
	self.detailItem.editedValue = YES;
    UICustomSwitch *neverSwitch = (UICustomSwitch*) sender;
    
    if(neverSwitch.tag == 1100)
    {
        if(neverSwitch.isOn)
            self.detailItem.hasAccessSignValue = TRUE;
        else
            self.detailItem.hasAccessSignValue = FALSE;
        
        
    }
    else if(neverSwitch.tag == 1101)
    {
        if(neverSwitch.isOn)
            _detailItem.neverVisitValue= TRUE;
        else
            _detailItem.neverVisitValue = FALSE;
        
    }
    else if(neverSwitch.tag == 1102)
    {
        if(neverSwitch.isOn)
            _detailItem.isEligibleValue= TRUE;
        else
            _detailItem.isEligibleValue = FALSE;
        
        ProducerStatusTableViewCell *statusCell = (ProducerStatusTableViewCell *)[[neverSwitch superview] superview];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:statusCell];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    [[NSManagedObjectContext defaultContext] save];
    [self toggleSubmitButton:[self isEnableSubmit]];
    
}

- (void)showViewController:(UIViewController *)viewController
{
    [self presentModalViewController:viewController animated:YES];
}

- (void)dismissKeyboard
{
	[self.fields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

-(IBAction)showSelectionTableView:(id)sender
{
	self.detailItem.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
    
    UIButton *button = (UIButton *)sender;
    
	SelectionModelViewController *selectionView = [[SelectionModelViewController alloc] initWithNibName:@"SelectionModelViewController" bundle:nil];
    
    selectionView.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
    
    selectionView.currentTag = button.tag;
    
    [selectionView  setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [selectionView  setModalPresentationStyle:UIModalPresentationFormSheet];
    selectionView.delegate = self;
	
    switch(selectionView.currentIndexPath.section)
    {
        case EGeneral:
        { 
            switch(selectionView.currentTag)
            {
                case ESubTerritory:
                {
                    break;
                }
            }
        }
            break;
        case ERater:
        {
            switch(selectionView.currentTag)
            {
                case ERater1:
                {
					NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[Rater findAllSortedBy:@"name" ascending:YES]];
					NSDictionary *dict = [NSDictionary dictionaryWithObject:@"None" forKey:@"name"];
					[dataSource addObject:dict];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
                case ERater2:
                {
                    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[Rater2 findAllSortedBy:@"name" ascending:YES]];
					NSDictionary *dict = [NSDictionary dictionaryWithObject:@"None" forKey:@"name"];
					[dataSource addObject:dict];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
            }
        }
            break;
        case EStatus:
        {
            switch(selectionView.currentTag)
            {
                case EInEligibleReason:
                {
                      NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[IneligibleReason findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
                    break;
                }
            }
            break;
        }
        case EHoursOfOperation:
        {
            switch(selectionView.currentTag)
            {
                case EMondayStartHour:
                case EMondayEndHour:
                case ETuesdayStartHour:
                case ETuesdayEndHour:
                case EWednesdayStartHour:
                case EWednesdayEndHour:
                case EThursdayStartHour:
                case EThursdayEndHour:
                case EFridayStartHour:
                case EFridayEndHour:
                case ESaturdayStartHour:
                case ESaturdayEndHour:
                case ESundayStartHour:
                case ESundayEndHour:
                {
                    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[OperationHour findAllSortedBy:@"uid" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
					
                }
                    break;
                    
            }
            break;
        }
        case EAddresses:
        {
            switch(selectionView.currentTag)
            {
                case EAddressState:
                {
                      NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[State findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
					
                    break;
                }
            }
            break;
        }
        case EContacts:
        {
            switch(selectionView.currentTag)
            {
                case EContactTitle:
                {
                    
                      NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[ContactType findAllSortedBy:@"name" ascending:YES]];
                    [selectionView assignDataSource:dataSource];
                    
                    break;
                }
            }
            break;
        }
    }
    [self dismissKeyboard];
    [self performSelector:@selector(showViewController:) withObject:selectionView afterDelay:0.0];
}
-(IBAction)showTimePickerView:(id)sender
{
    [self nextField:0];
	UIButton *button = (UIButton *)sender;
	[self.datePickerViewController.datePicker setDate:[NSDate date]];
	self.datePickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.datePickerViewController.currentTag = button.tag;
	[self.datePickerViewController.datePicker setDatePickerMode:UIDatePickerModeTime];
	
	//Position the picker out of sight
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
    
  /*  NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
    */
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.datePickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME_LANDSCAPE];
		} else {
			[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		}
		
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.datePickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		NSNotification *notification = [NSNotification notificationWithName:UIKeyboardDidShowNotification object:nil userInfo:userInfo];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}];
	[self datePickerViewController:self.datePickerViewController didChangeDate:self.datePickerViewController.datePicker.date forTag:button.tag];
}

- (void)nextField:(NSInteger)currentTag
{	
    
	if (self.datePickerViewController.view.superview != nil) {
		self.datePickerViewController.currentIndexPath = nil;
		self.datePickerViewController.currentTag = 0;
		//Position the picker out of sight
		[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		//This animation will work on iOS 4
		//For older iOS, use "beginAnimation:context"
		[UIView animateWithDuration:0.2 animations:^{[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];} completion:^(BOOL finished){
			CIVector *frameVector = [CIVector vectorWithCGRect:self.datePickerViewController.view.frame];
			NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
			NSNotification *notification = [NSNotification notificationWithName:UIKeyboardWillHideNotification object:nil userInfo:userInfo];
			[[NSNotificationCenter defaultCenter] postNotification:notification];
			[self.datePickerViewController.view removeFromSuperview];}];
	}
    
}
#pragma mark -
#pragma mark DatePickerViewControllerDelegate

- (void)datePickerViewController:(DatePickerViewController *)controller didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	
    switch(controller.currentIndexPath.section)
    {
        case EGeneral:
        {
            switch(controller.currentTag)
            {
                case EDateEstablished:
                {
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    self.detailItem.dateEstablished = toDate;
                    break;
                }
                case EEnOExpiration:
                {
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    self.detailItem.eAndOExpires = toDate;
                    break;
                }
                    
            }
            
            break;
        }
        case EStatus:
        {
            switch (controller.currentTag) {
                case EAppointedDate:
                {
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    self.detailItem.appointedDate = toDate;
                    break;
                }
                case EStatusDate:
                {
                    [formatter setDateFormat:@"MM-dd-yyyy"];
                    self.detailItem.statusDate = toDate;
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
			
    }
    self.detailItem.edited = [NSNumber numberWithBool:YES];
    [[NSManagedObjectContext defaultContext] save];
	[self toggleSubmitButton:[self isEnableSubmit]];
	
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:controller.currentIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    
	
}


#pragma mark - TextField delegate methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *replacementString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
    
    switch(indexPath.section)
    {
        case EAddresses:
        {
            switch(tag)
            {
                case EAddressZipCode:
                {
                    if([replacementString isValidZipCode])
                    {
                        [self changeTextFieldOutline:textField :YES];
                    }
                    else
                    {
                        [self changeTextFieldOutline:textField :NO];
                    }
                }break;
            }
            
            break;
        }
			
        case ECompanyContactInfo:
        {
            switch(tag)
            {
                case EPhone1: //1
                {
					if([replacementString isValidPhoneNumber])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
                    break;
                case EFax://4
                {
					if([replacementString isValidPhoneNumber])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
					break;
                case EMainEmail: //3
                {
					if([replacementString isValidEmail])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
                    break;
                case EClaimsEmail: //5
                {
                    if([replacementString isValidEmail])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
                    
                    break;
                case EAccountingEmail: //2
                {  
                    if([replacementString isValidEmail])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
                    
                    break;
                case ECustomerServiceEmail: //4
                {  
                    if([replacementString isValidEmail])
					{
						[self changeTextFieldOutline:textField:YES];
					}
					else
					{
						[self changeTextFieldOutline:textField:NO];
					}
                }
                    
                    break;
                case EWebsiteAddress:
                {
                    
					self.detailItem.webAddress = textField.text;
                }
                    break;
            }
            
            break;
        }
        case EContacts:
        {
            switch(tag)
            {
                case EContactSSN:
                {
                }
                    break;
            }
            break;
        }
    }
	
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
        
    [self saveTextFieldToContext:textField];
    return YES;
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// Set the next form field active
    [textField resignFirstResponder];
	return YES;
}

-(void) saveTextFieldToContext:(UITextField*) textField
{
	
    NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
    self.detailItem.editedValue = YES;
    switch(indexPath.section)
    {
        case EGeneral:
        {
            switch(tag)
            {
                case EProducerName:
                {
                    self.detailItem.name = textField.text;
                }
					break;
                case ESubTerritory:
                {
                    self.detailItem.subTerritory = [SubTerritory ai_objectForProperty:@"uid" value:[NSNumber numberWithInt:[textField.text intValue]] managedObjectContext:[NSManagedObjectContext defaultContext]];
                    
                }
                    break;
                case ENumberOfLocation:
                    self.detailItem.numberOfLocationsValue = [textField.text integerValue];
                    break;
                case ENoOfEmployees:
                    self.detailItem.numberOfEmployeesValue = [textField.text integerValue];
                    break;
                case EPrimaryContact:
                {
                    self.detailItem.primaryContact = textField.text;
                }
					break;
            }
        }
            break;
        case EQuestions:
        {
            switch(tag)
            {
                case EAnswer:
                {
                    NSArray *qArray = _detailItem.questions.allObjects;
                    QuestionListItem* qItem = [qArray objectAtIndex:indexPath.row];
                    qItem.answer = textField.text;
                }
                    break;
            }
        }
			break;
        case ECompanyContactInfo:
        {
            switch(tag)
            {
                case EPhone1: //1
                {
                    [self modifyPhoneItem:textField forPhoneType:1];
                }
                    break;
                case EFax://4
                {
                    [self modifyPhoneItem:textField forPhoneType:4];                    
                }
					break;
                case EMainEmail: //1
                {
                    [self modifyEmailItem:textField forEmailType:1];
                }
                    break;
                case EClaimsEmail: //2
                {
                    [self modifyEmailItem:textField forEmailType:2];
                }
                    break;
                case EAccountingEmail: //3
                {  
                    [self modifyEmailItem:textField forEmailType:3];
                }
                    break;
                case ECustomerServiceEmail: //4
                {  
                    [self modifyEmailItem:textField forEmailType:4];
                }
                    break;
                case EWebsiteAddress:
                {
					self.detailItem.webAddress = textField.text;
                }
                    break;
            }
        }
			break;
        case EAddresses:
        {
			
            NSArray *addressArray = _detailItem.addresses.allObjects;
            AddressListItem* addressItem = nil;
            int rowIndex = indexPath.row;
            rowIndex+=1;
            for(AddressListItem* address in addressArray)
            {
                if(address.addressTypeValue == rowIndex)
                {
                    addressItem = address; 
                    break;
                }
            }
            
            if(addressItem == nil)
            {
                addressItem = [AddressListItem createEntity];
                addressItem.addressTypeValue = rowIndex;
                [self.detailItem addAddressesObject:addressItem];
            }
            
			addressItem.editedValue = YES;
            
            switch(tag)
            {
                case EAddressStreet1:
                {
                    addressItem.addressLine1 = textField.text;
                }
                    break;
                case EAddressStreet2:
                    addressItem.addressLine2 = textField.text;
                    break;
                case EAddressCity:
                    addressItem.city = textField.text;
                    break;
                case EAddressZipCode:
                {
                    if([textField.text isValidZipCode])
                    {
                        addressItem.postalCode =textField.text;
                        [self changeTextFieldOutline:textField :YES];
                    }
                    else
                    {
                        [self showAlert:VALID_ZIP_CODE_ALERT];
                        [self changeTextFieldOutline:textField :NO];
                    }
                }
                    break;
            }
        }
            break;
        case EContacts:
        {
            NSArray* contactArray = _detailItem.contacts.allObjects;
            Contact* cnt = [contactArray objectAtIndex:indexPath.row];
			cnt.editedValue = YES;
            switch(tag)
            {
                case EContactFirstName:
                    cnt.firstName = textField.text;
                    break;
                case EContactLastName:
                    cnt.lastName = textField.text;
                    break;
                case EContactMobilePhone: {
					PhoneListItem *phone;
					for (PhoneListItem *aPhone in cnt.phoneNumbers) {
						if (aPhone.typeValue == 5) {
							phone = aPhone;
							break;
						}
					}
					if (!phone) {
						phone = [PhoneListItem createEntity];
						phone.typeValue = 5;
						[cnt addPhoneNumbersObject:phone];
					}
					phone.number = textField.text;
				}
                    break;
                case EContactEmailAddress: {
					EmailListItem *email;
					for (EmailListItem *aPhone in cnt.emails) {
						if (aPhone.typeValue == 5) {
							email = aPhone;
							break;
						}
					}
					if (!email) {
						email = [EmailListItem createEntity];
						email.typeValue = 5;
						[cnt addEmailsObject:email];
					}
					email.address = textField.text;
				}
                    break;
                case EContactSSN:
                    cnt.ssn = textField.text;
                    break;
				case EContactFax: {
					PhoneListItem *phone;
					for (PhoneListItem *aPhone in cnt.phoneNumbers) {
						if (aPhone.typeValue == 4) {
							phone = aPhone;
							break;
						}
					}
					if (!phone) {
						phone = [PhoneListItem createEntity];
						phone.typeValue = 4;
						[cnt addPhoneNumbersObject:phone];
					}
					phone.number = textField.text;
				}
					break;
				default:
					break;
            }
            break;
        }
			break;
		default:
			break;
    }
    
	[[NSManagedObjectContext defaultContext] save];

   
    if(indexPath.section == ECompanyContactInfo && (tag == EMainEmail || tag == ECustomerServiceEmail || tag == EAccountingEmail || tag == EClaimsEmail) )
    {
        currentIndexPath = indexPath.section;
        [self performSelector:@selector(reloadSections) withObject:nil afterDelay:.2];
    }
	[self toggleSubmitButton:[self isEnableSubmit]];
}

- (void)reloadSections {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:currentIndexPath]
                  withRowAnimation:UITableViewRowAnimationNone];
}
-(void) modifyEmailItem:(UITextField*) textField forEmailType:(NSInteger) emailType
{
    EmailListItem *newMail=nil;
    for (EmailListItem *email in _detailItem.emails)
    {
        if(email.typeValue == emailType)
        {
            
            newMail = email;
            break;
        }
    }
    if(newMail != nil)
    {
        if([textField.text isValidEmail])
        {
            newMail.address = textField.text;
            [self changeTextFieldOutline:textField:YES];
        }
        else
        {
            [self showAlert:VALID_EMAIL_ALERT];
            [self changeTextFieldOutline:textField:NO];
        }
    }
    else
    {
        if([textField.text isValidEmail])
        {
            newMail = [EmailListItem createEntity];
            newMail.typeValue = emailType;
            newMail.address = textField.text;
            [self.detailItem addEmailsObject:newMail];
            [self changeTextFieldOutline:textField:YES];
        }
        else
        {
            [self showAlert:VALID_EMAIL_ALERT];
            [self changeTextFieldOutline:textField:NO];
			
        }
        
    }
	
}
-(void) modifyPhoneItem:(UITextField*) textField forPhoneType:(NSInteger) phoneType
{
    BOOL phoneExists = NO;
    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers)
    {
        if(phoneNumber.typeValue == phoneType)
        {
            phoneExists = YES;
            if([textField.text isValidPhoneNumber])
            {
                phoneNumber.number = textField.text;
                [self changeTextFieldOutline:textField:YES];
            }
            else
            {
                [self showAlert:VALID_PHONE_ALERT];
                [self changeTextFieldOutline:textField:NO];
            }
            break;
        }
    }
    if(!phoneExists)
    {
        if([textField.text isValidPhoneNumber])
        {
			PhoneListItem* newPhoneItem  = [PhoneListItem createEntity];
			newPhoneItem.typeValue = phoneType;
			newPhoneItem.number = textField.text;
			[self.detailItem addPhoneNumbersObject:newPhoneItem];
			[self changeTextFieldOutline:textField:YES];
        }
        else
        {
            [self showAlert:VALID_PHONE_ALERT];
            [self changeTextFieldOutline:textField:NO];
        }
    }
	
}
//Verify producer data and toggle submit button
-(BOOL) isEnableSubmit
{
    if(!_detailItem.editedValue)
        return FALSE;
    
    for(int section = 0 ;section<EAllSectionsCount;section++)
    {
        switch(section)
        {
            case EGeneral:
            {
                if(_detailItem.producerCode  == nil || 
                   _detailItem.name == nil ||
                   _detailItem.subTerritory == nil ||
                   _detailItem.numberOfLocations == nil ||
                   _detailItem.numberOfEmployees == nil ||
                   _detailItem.dateEstablished == nil ||
                   [_detailItem.primaryContact length]<=0
                   )
                    return FALSE;
            }
                break;
            case EQuestions:
            {
                if(_detailItem.questions == nil || [_detailItem.questions.allObjects count]<=0)
                    return FALSE;
            }
                break;
            case EStatus:
            {
                if(_detailItem.isEligible == nil||
                   (!(_detailItem.isEligibleValue) && _detailItem.ineligibleReason == nil))
                    return FALSE;
            }
                break;
            case ERater:
            {
                if(_detailItem.rater == nil)
                    return FALSE;
				
            }
                break;
            case ECompanyContactInfo:
            {
                
                if([_detailItem.phoneNumbers.allObjects count]<=0 || [_detailItem.emails.allObjects count]<=0)
                    return FALSE;
                BOOL isPhoneNoFound = FALSE,isEmailFound = FALSE,isFaxFound = FALSE;
                
				
                
                for(PhoneListItem *pItem in _detailItem.phoneNumbers.allObjects)
                {
                    if(pItem.typeValue == PHONE_1)
                    {
                        if([pItem.number length]>0)
                            isPhoneNoFound = TRUE;
                    }
                    
                    if(pItem.typeValue == FAX)
                    {
                        if([pItem.number length] >0)
                            isFaxFound = TRUE;
                    }
                    
                }
                for(EmailListItem *eItem in _detailItem.emails.allObjects)
                {
                    if(eItem.typeValue == MAIN_EMAIL)
                    {
                        if([eItem.address length]>0)
                            isEmailFound = TRUE;
                    }
                }
                if(!isPhoneNoFound || !isEmailFound ) 
                    return FALSE;
            }
                break;
            case EHoursOfOperation:
            {
                if(_detailItem.hoursOfOperation.mondayOpenTime== nil ||
                   _detailItem.hoursOfOperation.mondayCloseTime == nil||
                   _detailItem.hoursOfOperation.tuesdayOpenTime== nil ||
                   _detailItem.hoursOfOperation.tuesdayCloseTime == nil||
                   _detailItem.hoursOfOperation.wednesdayOpenTime== nil ||
                   _detailItem.hoursOfOperation.wednesdayCloseTime == nil||
                   _detailItem.hoursOfOperation.thursdayOpenTime== nil ||
                   _detailItem.hoursOfOperation.thursdayCloseTime == nil||
                   _detailItem.hoursOfOperation.fridayOpenTime== nil ||
                   _detailItem.hoursOfOperation.fridayCloseTime == nil||
                   _detailItem.hoursOfOperation.saturdayOpenTime== nil ||
                   _detailItem.hoursOfOperation.saturdayCloseTime == nil||
                   _detailItem.hoursOfOperation.sundayOpenTime== nil ||
                   _detailItem.hoursOfOperation.sundayCloseTime == nil)
                    return FALSE;
            }
                break;
            case EAddresses:
            {
                if([_detailItem.addresses.allObjects count]<=0)
                    return FALSE;
                
                for(AddressListItem *addrItem in _detailItem.addresses.allObjects)
                {
                    if([addrItem.addressLine1 length]<=0||
					   //  [addrItem.addressLine2 length]<=0||
                       addrItem.state == nil ||
                       [addrItem.city length]<=0 ||
                       [addrItem.postalCode length]<=0)
                        return FALSE;
                }
            }
                break;
            case EContacts:
            {
                if([_detailItem.contacts.allObjects count]<=0)
                    return FALSE;
                
             for(Contact *cItem in _detailItem.contacts.allObjects)
                {
                 /*      BOOL isEmailFilled = FALSE;
                    
                        for(EmailListItem *emailObj in cItem.emails)
                        {
                            if(emailObj.typeValue == 5 && [emailObj.address length]>0)
                                isEmailFilled = TRUE;
                        }
                    
                    BOOL isPhoneFilled = FALSE;
                    
                        for(PhoneListItem *phoneObj in cItem.phoneNumbers)
                        {
                            if(phoneObj.typeValue == 5 && [phoneObj.number length]>0)
                                isPhoneFilled = TRUE;
                        }*/
                
                    if([cItem.firstName length]<=0||
                       [cItem.lastName length]<=0||
                       cItem.type == nil||
                       (![cItem.type.name isEqualToString:@"Agent"] && [cItem.ssn length]<=0)
                      // || !isEmailFilled || !isPhoneFilled
                       )
                        return FALSE;
                }
            }
                break;
        }
    }
    
    return TRUE;
}

-(IBAction)autoFormatPhoneNumber:(id)sender
{
    if(myTextFieldSemaphore)
        return;
    UITextField *textField = (UITextField*)sender;
    
    myTextFieldSemaphore = 1;
    textField.text = [myPhoneNumberFormatter format:textField.text withLocale:@"us"];
    myTextFieldSemaphore=0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


-(void) selectedOption:(NSString*)selectedString didSelectRowAtIndexPath:(NSIndexPath*)forIndexPath forTag:(NSInteger) forTag
{
	self.detailItem.editedValue = YES;
    switch(forIndexPath.section)
    {
        case EGeneral:
        {
            switch(forTag)
            {
                case ESubTerritory:
                {
                    break;
                }
            }
            break;
        }
            
        case ERater:
        {
            switch(forTag)
            {
                case ERater1:
                {
					Rater *rater = [Rater findFirstByAttribute:@"name" withValue:selectedString];
					if (rater) {
						self.detailItem.rater = rater;
					} else {
						self.detailItem.rater = nil;
						self.detailItem.rater2 = nil;
					}
                    
                    break;
                }
                case ERater2:
                {
					Rater2 *rater2 = [Rater2 findFirstByAttribute:@"name" withValue:selectedString];
					if (rater2) {
						self.detailItem.rater2 = rater2;
					} else {
						self.detailItem.rater2 = nil;
					}
                    break;
                }
            }
        }
            break;
        case EStatus:
        {
            switch(forTag)
            {
                case EInEligibleReason:
                    self.detailItem.ineligibleReason = [IneligibleReason findFirstByAttribute:@"name" withValue:selectedString]; 
                    break;
            }
            break;
        }
        case EHoursOfOperation:
        {
            HoursOfOperation *hOfOperation = _detailItem.hoursOfOperation;
            if(hOfOperation == nil)
            {
                HoursOfOperation *hOperation = [HoursOfOperation createEntity];
                self.detailItem.hoursOfOperation = hOperation;
            }
			
            OperationHour *hour = [OperationHour findFirstByAttribute:@"name" withValue:selectedString];
            
            switch(forTag)
            {
                case EMondayStartHour:
                {
					self.detailItem.hoursOfOperation.mondayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.mondayCloseTime = hour;
					}
                    break;
                }
                case EMondayEndHour:
                {
                    
					self.detailItem.hoursOfOperation.mondayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.mondayOpenTime = hour;
					}
                    break;
                }
                    
                case ETuesdayStartHour:
                {
					self.detailItem.hoursOfOperation.tuesdayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.tuesdayCloseTime = hour;
					}
                    break;
                }
                    
                case ETuesdayEndHour:
                {
                    self.detailItem.hoursOfOperation.tuesdayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.tuesdayOpenTime = hour;
					}
                    break;
                }
                    
                case EWednesdayStartHour:
                {
					self.detailItem.hoursOfOperation.wednesdayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.wednesdayCloseTime = hour;
					}
                    break;
                }
                    
                case EWednesdayEndHour:
                {
                    self.detailItem.hoursOfOperation.wednesdayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.wednesdayOpenTime = hour;
					}
                    break;
                }
                    
                case EThursdayStartHour:
                {
                    self.detailItem.hoursOfOperation.thursdayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.thursdayCloseTime = hour;
					}
                    break;
                }
                    
                case EThursdayEndHour:
                {
                    self.detailItem.hoursOfOperation.thursdayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.thursdayOpenTime = hour;
					}
                    break;
                }
                    
                case EFridayStartHour:
                {
                    self.detailItem.hoursOfOperation.fridayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.fridayCloseTime = hour;
					}
                    break;
                }
                    
                case EFridayEndHour:
                {
                    self.detailItem.hoursOfOperation.fridayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.fridayOpenTime = hour;
					}
                    break;
                }
                    
                case ESaturdayStartHour:
                {
                    self.detailItem.hoursOfOperation.saturdayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.saturdayCloseTime = hour;
					}
                    break;
                }
                    
                case ESaturdayEndHour:
                {
                    self.detailItem.hoursOfOperation.saturdayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.saturdayOpenTime = hour;
					}
                    break;
                }
                    
                case ESundayStartHour:
                {
                    self.detailItem.hoursOfOperation.sundayOpenTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.sundayCloseTime = hour;
					}
                    break;
                }
                    
                case ESundayEndHour:
                {
                    self.detailItem.hoursOfOperation.sundayCloseTime = hour;
					if ([selectedString isEqualToString:@"CLOSED"]) {
						self.detailItem.hoursOfOperation.sundayOpenTime = hour;
					}
                    break;
                }
            }
			break;
        }
        case EAddresses:
        {
            switch(forTag)
            {
                case EAddressState:
                {
                    int indexRow = forIndexPath.row;
                    switch(indexRow)
                    {
                        case 0:
                        {
                            AddressListItem *addressItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                if (address.addressTypeValue == 1) {
                                    addressItem = address;
                                    break;
                                }
                            }
                            if(addressItem != nil)
                            {
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addressItem = [AddressListItem createEntity];
                                addressItem.addressTypeValue = 1;
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addressItem];
                            }
							addressItem.editedValue = YES;
                            
                            break;
                        }
                            
                        case 1:
                        {
                            AddressListItem *addressItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                if (address.addressTypeValue == 2) {
                                    addressItem = address;
                                    break;
                                }
                            }
                            if(addressItem != nil)
                            {
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addressItem = [AddressListItem createEntity];
                                addressItem.addressTypeValue = 2;
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addressItem];
                            }
                            addressItem.editedValue = YES;
                            break;
                        }
                            
                        case 2:
                        {
                            AddressListItem *addressItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                if (address.addressTypeValue == 3) {
                                    addressItem = address;
                                    continue;
                                }
                            }
                            if(addressItem != nil)
                            {
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addressItem = [AddressListItem createEntity];
                                addressItem.addressTypeValue = 3;
                                addressItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addressItem];
                            }
							addressItem.editedValue = YES;
                            break;
                        }
                    }
                }
                    break;
            } 
            break;
        }
        case EContacts:
        {
            switch(forTag)
            {
                case EContactTitle: {
					
					Contact *contact = [self.detailItem.contacts.allObjects objectAtIndex:forIndexPath.row];
					contact.type = [ContactType findFirstByAttribute:@"name" withValue:selectedString];
					contact.editedValue = YES;
				}
                    break;
            }       
            break;
        }
    }
	[[NSManagedObjectContext defaultContext] save];
    [self.tableView reloadData];
	[self toggleSubmitButton:[self isEnableSubmit]];
}
@end
