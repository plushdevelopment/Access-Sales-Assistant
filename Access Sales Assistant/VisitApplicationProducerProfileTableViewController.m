//
//  VisitApplicationProducerProfileTableViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationProducerProfileTableViewController.h"
#import "UITableView+PRPSubviewAdditions.h"
#import "ProducerQuestionTableViewCell.h"
#import "ProducerStatusTableViewCell.h"
#import "ProducerRaterTableViewCell.h"
#import "ProducerHoursTableViewCell.h"
#import "ProducerContactInfoTableViewCell.h"
#import "ProducerAddressTableViewCell.h"
#import "ProducerContactTableViewCell.h"
#import "AddRowTableViewCell.h"
#import "Producer.h"
#import "Contact.h"
#import "Status.h"
#import "AddressListItem.h"
#import "QuestionListItem.h"
#import "State.h"
#import "PhoneListItem.h"
#import "EmailListItem.h"
#import "Rater.h"
#import "Rater2.h"
#import "HoursOfOperation.h"
#import "SubTerritory.h"
#import "SuspensionReason.h"
#import "OperationHour.h"
#import "IneligibleReason.h"
#import "ProducerProfileConstants.h"
#import "HTTPOperationController.h"
#import "NSString-Validation.h"
#import <QuartzCore/QuartzCore.h>
#import "ContactType.h"

@implementation VisitApplicationProducerProfileTableViewController

@synthesize detailItem = _detailItem;
@synthesize pickerViewController = _pickerViewController;
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

@synthesize dismissButton = _dismissButton;
@synthesize submitButton = _submitButton;
//@synthesize producerGeneralTableViewCell = _producerGeneralTableViewCell;

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender
{
	[[HTTPOperationController sharedHTTPOperationController] postProducerProfile:[self.detailItem jsonStringValue]];
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
  //  [_submitButton setEnabled:FALSE];
    [super viewDidLoad];
    
    sectionTitleArray = [[NSArray alloc] initWithObjects:PRODUCER_PROFILE_SECTIONS];
    
    self.tableView.allowsSelection = NO;
    
  //  [self toggleSubmitButton:NO];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.detailItem addObserver:self forKeyPath:@"edited" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    //[self toggleSubmitButton:NO];
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void) toggleSubmitButton:(BOOL) isEnable
{
    
    [_submitButton setEnabled:isEnable];
}
- (void)setDetailItem:(id)newDetailItem
{
	if (self.detailItem) {
		if ([self.detailItem valueForKey:@"editedValue"]) {
			[[NSManagedObjectContext defaultContext] save];
           //  [self toggleSubmitButton:YES];
           //  [self toggleSubmitButton:[self isEnableSubmit]];
		}
       // else
        //    [self toggleSubmitButton:NO];
	}
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
     /*   if([self.detailItem valueForKey:@"editedValue"])
            [self toggleSubmitButton:YES];
        else
            [self toggleSubmitButton:NO];
       */
            
        
     //   [self toggleSubmitButton:[self.detailItem valueForKey:@"editedValue"]?YES:NO];
    }
    
     [self toggleSubmitButton:[self isEnableSubmit]];
   
	
 //   if (self.aPopoverController != nil) {
   //     [self.aPopoverController dismissPopoverAnimated:YES];
 //   }        
}

- (void)configureView
{
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [sectionTitleArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch(section)
    {
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
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitleArray objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  static NSString *CellIdentifier = @"Cell";
  
    switch(indexPath.section)
    {
        case EGeneral:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerGeneralTableViewCell" owner:self options:nil];
            ProducerGeneralTableViewCell* cell = _generalTableViewCell;//[ProducerGeneralTableViewCell cellForTableView:tableView fromNib:[ProducerGeneralTableViewCell nib]];
                cell.producerCodeTextField.text = self.detailItem.producerCode;
            
            [self disableTextField:cell.producerCodeTextField :NO];
                cell.producerNameTextField.text = self.detailItem.name;
            cell.numberOfEmployeesTextField.text = [[NSString alloc]initWithFormat:@"%@",_detailItem.numberOfEmployees];
            cell.accessSignTextField.text = _detailItem.hasAccessSignValue?@"Yes":@"No";
            cell.subTerritoryTextField.text = _detailItem.subTerritory.uid.stringValue;
            cell.numberOfLocationsTextField.text = _detailItem.numberOfLocations.stringValue;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            
            cell.eOExpiresTextField.text = [dateFormatter stringFromDate:_detailItem.eAndOExpires];
             [self disableTextField:cell.eOExpiresTextField :NO];
            cell.dateEstablishedTextField.text = [dateFormatter stringFromDate:_detailItem.dateEstablished];
            return cell;
        }
        case EQuestions:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerQuestionTableViewCell" owner:self options:nil];
            ProducerQuestionTableViewCell* cell = _questionTableViewCell;//[ProducerQuestionTableViewCell cellForTableView:tableView fromNib:[ProducerQuestionTableViewCell nib]];
            NSArray* questionArray=_detailItem.questions.allObjects;
            QuestionListItem *qListItem = (QuestionListItem *)[questionArray objectAtIndex:indexPath.row];
            cell.questionLabel.text = qListItem.text;
            cell.answerTextField.text = qListItem.answer;
            return cell;

        }
            
        case EStatus:
        {
            
            [[NSBundle mainBundle] loadNibNamed:@"ProducerStatusTableViewCell" owner:self options:nil];
            ProducerStatusTableViewCell* cell = _statusCell;//[ProducerStatusTableViewCell cellForTableView:tableView fromNib:[ProducerStatusTableViewCell nib]];
            [self statusTableViewCell:cell :indexPath.row];
            return cell;
        }
        case ERater:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerRaterTableViewCell" owner:self options:nil];
            ProducerRaterTableViewCell* cell = _raterTableViewCell;//[ProducerRaterTableViewCell cellForTableView:tableView fromNib:[ProducerRaterTableViewCell nib]];
            [self raterTableViewCell:cell :indexPath.row];
            return cell;
        }
        case ECompanyContactInfo:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerContactInfoTableViewCell" owner:self options:nil];
            ProducerContactInfoTableViewCell* cell = _contactInfoTableViewCell;//[ProducerContactInfoTableViewCell cellForTableView:tableView fromNib:[ProducerContactInfoTableViewCell nib]];
            [self contactInfoTableViewCell:cell :indexPath.row];
            return cell;
        }
        case EHoursOfOperation:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerHoursTableViewCell" owner:self options:nil];
            ProducerHoursTableViewCell* cell = _hoursTableViewCell;//[ProducerHoursTableViewCell cellForTableView:tableView fromNib:[ProducerHoursTableViewCell nib]];
            [self hoursOfOperationCell:cell :indexPath.row];
            return cell;
        }
        case EAddresses:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProducerAddressTableViewCell" owner:self options:nil];
            ProducerAddressTableViewCell* cell = _addressTableViewCell;//[ProducerAddressTableViewCell cellForTableView:tableView fromNib:[ProducerAddressTableViewCell nib]];
            if(indexPath.row ==0)
            {
                cell.addressTitle.text = @"Mailing Address";
                cell = [self addressTableViewCell:cell :1];
            
            }
            else if(indexPath.row==1)
            {
             cell.addressTitle.text = @"Commission Address";
             cell = [self addressTableViewCell:cell :2];
             
            }
            else if(indexPath.row == 2)
            {
                cell.addressTitle.text = @"Physical Address";
                cell = [self addressTableViewCell:cell :3];
                          
            }
            
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
                [[NSBundle mainBundle] loadNibNamed:@"ProducerContactTableViewCell" owner:self options:nil];
                ProducerContactTableViewCell* cell = _contactTableViewCell;//[ProducerContactTableViewCell cellForTableView:tableView fromNib:[ProducerContactTableViewCell nib]];
            cell = [self contactTableViewCell:cell :indexPath.row];
            return cell;
            }
        }
            
    }
    
    
}

-(void) AddContact:(id) sender
{
    UIButton* btn = (UIButton*) sender;
 
    if(btn.tag == 1001)
    {
        Contact* newContact = [Contact createEntity];
        [self.detailItem addContactsObject:newContact];
        [self.tableView reloadData];
    }
    else if(btn.tag == 1002)
    {
        
        BOOL editing = [self.tableView isEditing]?NO:YES;
        
        if(editing)
        {
    [btn setTitle:@"Done" forState:UIControlStateNormal];
               isContactsEdited = TRUE;
            
            
         //   cell.addButton.enabled = FALSE;
            
        }
        else
        {
            [btn setTitle:@"Edit" forState:UIControlStateNormal];
            isContactsEdited = FALSE;
         
            
           // cell.addButton.enabled = TRUE;
        }
       // [super setEditing:editing animated:YES];
        [self setEditing:editing animated:YES];
    }
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
    switch (indexPath.section) {
        case EGeneral:
        {
            height = 188.0;
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
                height = 188.0;
            break;
        }
        default:
            height = 110.0;
      //case 
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

#pragma mark - Fill the table view cell with entity values
-(ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*) addressCell:(NSInteger)forType
{
    BOOL isCommissionAddrFound = FALSE,isPhysicalAddrFound,isMailingAddrFound=FALSE,isCurrentAddrFound=FALSE;
    
    AddressListItem *mailingAddress=nil, *commissionAddress=nil, *physicalAddress=nil;
    for(AddressListItem *addrItem in _detailItem.addresses)
    {
        if(addrItem.addressTypeValue == forType)
        {
            [self FillAddressCellForType:addressCell :addrItem];      
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
            [self FillAddressCellForType:addressCell :mailingAddress];
        }
        else if(isCommissionAddrFound)
        {
            [self FillAddressCellForType:addressCell :commissionAddress];
        }
        else if(isPhysicalAddrFound)
        {
            [self FillAddressCellForType:addressCell :physicalAddress];
        }
        return addressCell;
    }
     return addressCell;

}
-(void)FillAddressCellForType:(ProducerAddressTableViewCell*)addressCell:(AddressListItem*) withAddrItem
{
    addressCell.streetAddress1TextField.text = withAddrItem.addressLine1;
    addressCell.streetAddress2TextField.text = withAddrItem.addressLine2;
    addressCell.cityTextField.text = withAddrItem.city;
    addressCell.stateTextField.text = withAddrItem.state.name;
    addressCell.zipTextField.text = withAddrItem.postalCode;
}

-(ProducerContactTableViewCell*) contactTableViewCell:(ProducerContactTableViewCell*) contactCell:(NSInteger)forRow
{
    NSArray* contactArray = _detailItem.contacts.allObjects;
    
    Contact* tContact = [contactArray objectAtIndex:forRow];
    
  //  contactCell.numberOfEmployeesTextField.text = [[NSString alloc]initWithFormat:@"%@",_detailItem.numberOfEmployees];
    contactCell.firstNameTextField.text = tContact.firstName;
    contactCell.lastNameTextField.text = tContact.lastName;
    contactCell.socialSecurityNumberTextField.text = tContact.ssn;
	contactCell.titleTextField.text = tContact.type.name;
    
    return contactCell;
}
-(ProducerContactInfoTableViewCell*) contactInfoTableViewCell:(ProducerContactInfoTableViewCell*) contactInfoCell:(NSInteger)forRow
{
    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers) {
        if (phoneNumber.typeValue == 1) {
          //  [self.mobilePhoneTextField setText:phoneNumber.number];
        } else if (phoneNumber.typeValue == 2) {
          //  [self.fax2TextField setText:phoneNumber.number];
        } else if (phoneNumber.typeValue == 3) {
            [contactInfoCell.phone1TextField setText:phoneNumber.number];
        } else if (phoneNumber.typeValue == 4) {
            [contactInfoCell.faxTextField setText:phoneNumber.number];
        }
        
    }
    int eCount  = _detailItem.emails.allObjects.count;
    for (EmailListItem *email in _detailItem.emails) {
        
        int typevalue = email.typeValue;
        if (email.typeValue == 1) {
          //  [self.emailAddressTextField setText:email.address];
        } else if (email.typeValue == 2) {
            [contactInfoCell.acctMailTextField setText:email.address];
        } else if (email.typeValue == 3) {
            [contactInfoCell.mainMailTextField setText:email.address];
        } else if (email.typeValue == 4) {
            [contactInfoCell.custServMailTextField setText:email.address];
        } else if (email.typeValue == 5) {
            [contactInfoCell.claimsMailTextField setText:email.address];
        }
    }
    
    [contactInfoCell.webAddrTextField setText:_detailItem.webAddress];
    return contactInfoCell;

}

-(void) raterTableViewCell:(ProducerRaterTableViewCell*) raterCell:(NSInteger)forRow
{
    [raterCell.raterTextField setText:_detailItem.rater.name];
    [raterCell.rater2TextField setText:_detailItem.rater2.name];
}

-(void) statusTableViewCell:(ProducerStatusTableViewCell*) statusCell:(NSInteger)forRow
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];

    Status * tStatus = _detailItem.status;
    statusCell.statusTextField.text = tStatus.name;
    [self disableTextField:statusCell.statusTextField :NO];
    statusCell.appointedDateTextField.text = [dateFormatter stringFromDate:_detailItem.appointedDate];
    [self disableTextField:statusCell.appointedDateTextField :NO];
    BOOL b = _detailItem.isEligibleValue;
    statusCell.eligibleTextField.text = _detailItem.isEligibleValue?@"YES":@"NO";
    statusCell.statusDateTextField.text = [dateFormatter stringFromDate:_detailItem.statusDate];
    [self disableTextField:statusCell.statusDateTextField :NO];
    statusCell.suspensionReasonTextField.text = _detailItem.suspensionReason.name;
    [self disableTextField:statusCell.suspensionReasonTextField :NO];
    
    //if(_detailItem.isEligible)
    {
        statusCell.reasonIneligibleTextField.text = _detailItem.ineligibleReason.name;
        statusCell.reasonIneligibleTextField.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
        statusCell.reasonIneligibleButton.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
        statusCell.reasonIneligibleLabel.hidden = _detailItem.isEligibleValue?TRUE:FALSE;
        
   //     [statusCell.reasonIneligibleButton setEnabled:_detailItem.isEligibleValue?FALSE:TRUE];
    }
   
}

-(void) hoursOfOperationCell:(ProducerHoursTableViewCell*)hoursCell:(NSInteger)forRow
{
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    
    HoursOfOperation *hOfOperation = _detailItem.hoursOfOperation;
    
    
    [hoursCell.monStartTextField setText:hOfOperation.mondayOpenTime.name];
    [hoursCell.monStopTextField setText:hOfOperation.mondayCloseTime.name];
    [hoursCell.tueStartTextField setText:hOfOperation.tuesdayOpenTime.name];
    [hoursCell.tueStopTextField setText:hOfOperation.tuesdayCloseTime.name];
    [hoursCell.wedStartTextField setText:hOfOperation.wednesdayOpenTime.name];
    [hoursCell.wedStopTextField setText:hOfOperation.wednesdayCloseTime.name];
    [hoursCell.thuStartTextField setText:hOfOperation.thursdayOpenTime.name];
    [hoursCell.thuStopTextField setText:hOfOperation.thursdayCloseTime.name];
    [hoursCell.friStartTextField setText:hOfOperation.fridayOpenTime.name];
    
    [hoursCell.friStopTextField setText:hOfOperation.fridayCloseTime.name];
    [hoursCell.satStartTextField setText:hOfOperation.saturdayOpenTime.name];
    [hoursCell.satStopTextField setText:hOfOperation.saturdayCloseTime.name];
    [hoursCell.sunStartTextField setText:hOfOperation.sundayOpenTime.name];
    [hoursCell.sunStopTextField setText:hOfOperation.sundayCloseTime.name];
    
    
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
/*
-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}
*/
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
       
        if(indexPath.section == EContacts && indexPath.row < _detailItem.contacts.allObjects.count)
        {
            NSArray* arr = _detailItem.contacts.allObjects;
          
            Contact* cToDel = [arr objectAtIndex:indexPath.row];
        
            
            [cToDel deleteInContext:[NSManagedObjectContext defaultContext]];
            [[NSManagedObjectContext defaultContext] save];
          //  UITableViewCellEditingStyleNone
           // [self.tableView set]
            [self.tableView reloadData];
            
        }
       
       
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - pickerView methods

// Show the pickerView inside of a popover
- (IBAction)showPickerView:(id)sender
{
	[self nextField:0];
	UIButton *button = (UIButton *)sender;
	
	self.pickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.pickerViewController.currentTag = button.tag;
	
	UIPickerView *pickerView = self.pickerViewController.pickerView;
	[pickerView setDelegate:self];
	[pickerView setDataSource:self];
	[pickerView setShowsSelectionIndicator:YES];
	[pickerView selectRow:0 inComponent:0 animated:NO];
	[pickerView reloadAllComponents];
	[self pickerView:pickerView didSelectRow:0 inComponent:0];
	
	//Position the picker out of sight
	[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.pickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.pickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		NSNotification *notification = [NSNotification notificationWithName:UIKeyboardDidShowNotification object:nil userInfo:userInfo];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}];
	
}

// Show the Date picker in Date mode in a popover
- (IBAction)showDatePickerView:(id)sender
{
	//[self nextField:0];
	

	UIButton *button = (UIButton *)sender;
	[self.datePickerViewController.datePicker setDate:[NSDate date]];
	self.datePickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.datePickerViewController.currentTag = button.tag;
	[self.datePickerViewController.datePicker setDatePickerMode:UIDatePickerModeDate];
	
	//Position the picker out of sight
	[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
    
    NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
	NSLog(@"%@", pickerFrame);
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.datePickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.datePickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		NSNotification *notification = [NSNotification notificationWithName:UIKeyboardDidShowNotification object:nil userInfo:userInfo];
		[[NSNotificationCenter defaultCenter] postNotification:notification];
	}];
	[self datePickerViewController:self.datePickerViewController didChangeDate:self.datePickerViewController.datePicker.date forTag:button.tag];
   
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
	[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
    
    NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
    
	
	//Add the picker to the view
	[self.parentViewController.view addSubview:self.datePickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		[self.datePickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		
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
	
	if (self.pickerViewController.view.superview != nil) {
		self.pickerViewController.currentIndexPath = nil;
		self.pickerViewController.currentTag = 0;
		//Position the picker out of sight
		[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		//This animation will work on iOS 4
		//For older iOS, use "beginAnimation:context"
		[UIView animateWithDuration:0.2 animations:^{[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME];} completion:^(BOOL finished){
			CIVector *frameVector = [CIVector vectorWithCGRect:self.pickerViewController.view.frame];
			NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
			NSNotification *notification = [NSNotification notificationWithName:UIKeyboardWillHideNotification object:nil userInfo:userInfo];
			[[NSNotificationCenter defaultCenter] postNotification:notification];
			[self.pickerViewController.view removeFromSuperview];}];
	} else if (self.datePickerViewController.view.superview != nil) {
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
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSInteger rows = 0;
    switch(self.pickerViewController.currentIndexPath.section)
    {
        case EGeneral:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ESubTerritory:
                    rows = 21;
                    break;
                case ENumberOfLocation:
                    rows = 100;
                    break;
                case ENoOfEmployees:
                    rows = 100;
                    break;
                case EIsAccessSign:
                    rows = 2;
                    break;
            }
            break;
        }
        case EStatus:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EStatusName:
                    rows = [[Status findAll] count];
                    break;
                case ESuspensionReason:
                    rows = [[SuspensionReason findAll] count];
                    break;
                case EIsEligible:
                    rows = 2;
                    break;
                case EInEligibleReason:
                    rows = [[IneligibleReason findAll] count];
                    break;
            }
            break;
        }
        case ERater:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ERater1:
                    rows = [[Rater findAll] count];
                    break;
                case ERater2:
                    rows = [[Rater2 findAll] count];
                    break;
                    
            }
            break;
        }
        case EHoursOfOperation:
        {
            switch(self.pickerViewController.currentTag)
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
                    rows = [[OperationHour findAll] count];
                }
                    break;
                    
            }
            break;
        }
        case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
        case EAddressState:
            rows = [[State findAll] count];
            break;
            }
        }
        case EContacts:
        {
           switch(self.pickerViewController.currentTag)
            {
                case EContactTitle:
                {
                    rows = [[ContactType findAll] count];
                    break;
                }
            }
            break;
        }
            
    }
		return rows;
}


//NSArray *sorted = [unsorted sortedArrayUsingFunction:dateSort context:nil];

#pragma mark -
#pragma mark UIPickerViewDelegate

// Set the appropriate value for a text field based on what the current tag is
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{	
	NSString *titleForRow = [pickerView.delegate
							 pickerView:pickerView
							 titleForRow:row
							 forComponent:component];
	
	NSIndexPath *indexPath = self.pickerViewController.currentIndexPath;
    
    switch(indexPath.section)
    {
        case EGeneral:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ESubTerritory:
                {
                    self.detailItem.subTerritory = [SubTerritory ai_objectForProperty:@"uid" value:titleForRow managedObjectContext:[NSManagedObjectContext defaultContext]];
                  //  self.
                    
                }
                    break;
                case ENumberOfLocation:
                    self.detailItem.numberOfLocationsValue = [titleForRow integerValue];
                    break;
                case ENoOfEmployees:
                    self.detailItem.numberOfEmployeesValue = [titleForRow integerValue];
                    break;
                case EIsAccessSign:
                    self.detailItem.hasAccessSignValue = [titleForRow boolValue];
                    break;
            }
            break;
            
        }
        case EQuestions:
        {
            
            break;
        }
        case EStatus:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EStatusName:
                    self.detailItem.status = [Status findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                case ESuspensionReason:
                    self.detailItem.suspensionReason = [SuspensionReason findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                case EIsEligible:
                    self.detailItem.isEligibleValue = [titleForRow boolValue];
                    break;
                case EInEligibleReason:
                    self.detailItem.ineligibleReason = [IneligibleReason findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
            }
            break;
        }
        case ERater:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ERater1:
                    self.detailItem.rater = [Rater findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                case ERater2:
                    self.detailItem.rater2 = [Rater2 findFirstByAttribute:@"name" withValue:titleForRow];
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

            
            switch(self.pickerViewController.currentTag)
            {
                case EMondayStartHour:
                {
                    self.detailItem.hoursOfOperation.mondayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }
                case EMondayEndHour:
                {
                    self.detailItem.hoursOfOperation.mondayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ETuesdayStartHour:
                {
                    self.detailItem.hoursOfOperation.tuesdayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ETuesdayEndHour:
                {
                    self.detailItem.hoursOfOperation.tuesdayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EWednesdayStartHour:
                {
                    self.detailItem.hoursOfOperation.wednesdayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EWednesdayEndHour:
                {
                    self.detailItem.hoursOfOperation.wednesdayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EThursdayStartHour:
                {
                    self.detailItem.hoursOfOperation.thursdayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EThursdayEndHour:
                {
                    self.detailItem.hoursOfOperation.thursdayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EFridayStartHour:
                {
                    self.detailItem.hoursOfOperation.fridayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case EFridayEndHour:
                {
                    self.detailItem.hoursOfOperation.fridayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ESaturdayStartHour:
                {
                    self.detailItem.hoursOfOperation.saturdayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ESaturdayEndHour:
                {
                    self.detailItem.hoursOfOperation.saturdayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ESundayStartHour:
                {
                    self.detailItem.hoursOfOperation.sundayOpenTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                case ESundayEndHour:
                {
                    self.detailItem.hoursOfOperation.sundayCloseTime = [OperationHour findFirstByAttribute:@"name" withValue:titleForRow];
                    break;
                }

                 
            }

            break;
        }
        case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EAddressState:
                {
                    int indRow = self.pickerViewController.currentIndexPath.row;
                    switch(self.pickerViewController.currentIndexPath.row)
                           {
                           case 0:
                               {
                                   AddressListItem *addrItem = nil;
                                   for (AddressListItem *address in _detailItem.addresses) {
                                       int addrValue = address.addressTypeValue;
                                       if (address.addressTypeValue == 1) {
                                           addrItem = address;
                                    
                                       //    address.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                           continue;
                                       }
                                    }
                                   if(addrItem != nil)
                                   {
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                   }
                                   else
                                   {
                                       addrItem = [AddressListItem createEntity];
                                       addrItem.addressTypeValue = 1;
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                       [self.detailItem addAddressesObject:addrItem];
                                   }

                                   break;
                               }
                                   
                           case 1:
                               {
                                   AddressListItem *addrItem = nil;
                                   for (AddressListItem *address in _detailItem.addresses) {
                                       int addrValue = address.addressTypeValue;
                                       if (address.addressTypeValue == 2) {
                                           addrItem = address;
                                           
                                           //    address.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                           break;
                                       }
                                   }
                                   if(addrItem != nil)
                                   {
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                   }
                                   else
                                   {
                                       addrItem = [AddressListItem createEntity];
                                       addrItem.addressTypeValue = 2;
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                       [self.detailItem addAddressesObject:addrItem];
                                   }
                                   
                                   break;
                               }

                           case 2:
                               {
                                   AddressListItem *addrItem = nil;
                                   for (AddressListItem *address in _detailItem.addresses) {
                                       int addrValue = address.addressTypeValue;
                                       if (address.addressTypeValue == 3) {
                                           addrItem = address;
                                           
                                           //    address.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                           continue;
                                       }
                                   }
                                   if(addrItem != nil)
                                   {
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                   }
                                   else
                                   {
                                       addrItem = [AddressListItem createEntity];
                                       addrItem.addressTypeValue = 3;
                                       addrItem.state = [State findFirstByAttribute:@"name" withValue:titleForRow];
                                       [self.detailItem addAddressesObject:addrItem];
                                   }
                                   
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
            switch(self.pickerViewController.currentTag)
            {
                case EContactTitle: {
					
					Contact *contact = [self.detailItem.contacts.allObjects objectAtIndex:self.pickerViewController.currentIndexPath.row];
					contact.type = [ContactType findFirstByAttribute:@"name" withValue:titleForRow];
					NSLog(@"%@", contact.type.name);
				}
                    break;
            }       
            break;
        }
    }
	
	//	[self.managedObjectContext save];
    [[NSManagedObjectContext defaultContext]save];
	//[self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
   // [self toggleSubmitButton:YES];
     [self toggleSubmitButton:[self isEnableSubmit]];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *theTitle = @"NOT SET";
    
   switch(self.pickerViewController.currentIndexPath.section)
    {
        case EGeneral:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ESubTerritory:
                case ENumberOfLocation:
                case ENoOfEmployees:
                    theTitle = [NSString stringWithFormat:@"%d", row];
                    break;
                case EIsAccessSign:
                    theTitle = (row == 0)?@"Yes":@"No";
                    break;
            }
            break;
        }
        case EStatus:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EStatusName:
                    theTitle = [[[Status findAll] objectAtIndex:row] name];
                    break;
                case ESuspensionReason:
                    theTitle = [[[SuspensionReason findAll] objectAtIndex:row] name];
                    break;
                case EInEligibleReason:
                    theTitle = [[[IneligibleReason findAll] objectAtIndex:row] name];
                    break;
                case EIsEligible:
                    theTitle = (row == 0)?@"Yes":@"No";
                    break;
            }
            break;
        }
        case ERater:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ERater1:
                    theTitle = [[[Rater findAll] objectAtIndex:row] name];
                    break;
                case ERater2:
                    theTitle = [[[Rater2 findAll] objectAtIndex:row] name];
                    break;
            }
            break;
        }
        case ECompanyContactInfo:
        {
            break;
        }
        case EHoursOfOperation:
        {
            switch(self.pickerViewController.currentTag)
            {
        case EMondayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EMondayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ETuesdayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ETuesdayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EWednesdayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EWednesdayEndHour:
                {
                    theTitle = theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EThursdayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EThursdayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EFridayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case EFridayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ESaturdayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ESaturdayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ESundayStartHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                    break;
                }
        case ESundayEndHour:
                {
                    theTitle = [[[OperationHour findAllSortedBy:@"uid" ascending:YES] objectAtIndex:row] name];
                }
            break;
            }

            break;
        }
        case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EAddressState:
                    theTitle = [[[State findAll] objectAtIndex:row] name];
                    break;
            }
            break;
        }
        case EContacts:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EContactTitle:
					theTitle = [[[ContactType findAll] objectAtIndex:row] name];
                    break;
            }
            break;
        }
    }
	return theTitle;
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
//	[self.tableView reloadData];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:controller.currentIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - TextField delegate methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	//[self saveTextFieldToContext:textField];
    
    Producer *producer = (Producer *)self.detailItem;
	if (!producer.editedValue) {
		producer.editedValue = YES;
		[[NSManagedObjectContext defaultContext] save];
	}
	// NSString *text = [NSString stringWithFormat:@"%@%@", textField.text, string];
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
                        //  addrItem.postalCode =textField.text;
                        [self changeTextFieldOutline:textField :YES];
                    }
                    else
                    {
                        //[self showAlert:VALID_ZIP_CODE_ALERT];
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
                case EPhone1: //3
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
                    if([replacementString isValidWebSite])
                    {
                        self.detailItem.webAddress = textField.text;
                        [self changeTextFieldOutline:textField:YES];
                    }
                    else
                    {
                        [self changeTextFieldOutline:textField:NO];
                    }
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
                    if([replacementString isvalidSSN])
                    {
                        [self changeTextFieldOutline:textField :YES];
                    }
                    else
                        [self changeTextFieldOutline:textField :NO];
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
    
    [self saveTextFieldToContext:textField];
 //   [[NSManagedObjectContext defaultContext] save];
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
	// Set the next form field active
	//[self nextField:textField.tag];
	return YES;
}

-(void) saveTextFieldToContext:(UITextField*) textField
{
    //if([textField.text length]<=0)
      //  return;
   
    
    NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
    
    switch(indexPath.section)
    {
        case EGeneral:
        {
            
            switch(tag)
            {
                case EProducerName:
                {
                    self.detailItem.name = textField.text;
                    break;
                }
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
            break;
        }
        case EStatus:
        {
            break;
        }
        case EHoursOfOperation:
            break;
        case ERater:
            break;
        case ECompanyContactInfo:
        {
            switch(tag)
            {
                    
                    
                case EPhone1: //3
                {
                    [self modifyPhoneItem:textField :3];
                }
                    break;
                case EFax://4
                {
                    [self modifyPhoneItem:textField :4];                    
                    break;
                }
                case EMainEmail: //3
                {
                    [self modifyEmailItem:textField :3];
                }
                    break;
                case EClaimsEmail: //5
                {
                    [self modifyEmailItem:textField :5];
                }
                    
                    break;
                case EAccountingEmail: //2
                {  
                    [self modifyEmailItem:textField :2];
                }
                    
                    break;
                case ECustomerServiceEmail: //4
                {  
                    [self modifyEmailItem:textField :4];
                }
                    
                    break;
                case EWebsiteAddress:
                {
                    if([textField.text isValidWebSite])
                    {
                        self.detailItem.webAddress = textField.text;
                        [self changeTextFieldOutline:textField:YES];
                    }
                    else
                    {
                        [self showAlert:VALID_WEB_ADDRESS];
                        [self changeTextFieldOutline:textField:NO];
                    }
                }
                    break;
            }
            
            break;
        }
        case EAddresses:
        {
          /*  AddressListItem* addrItem = nil;
            NSArray *addrArray = _detailItem.addresses.allObjects;
            switch(indexPath.row)
             {
                 case 0:
                 {
                     
                   //  int rowInd = indexPath.row;
                    // rowInd+=1;
                     for(AddressListItem* addr in addrArray)
                     {
                         if(addr.addressTypeValue == 1)
                         {
                             addrItem = addr; 
                             break;
                         }
                     }

                 }
                     
             }*/
             
            NSArray *addrArray = _detailItem.addresses.allObjects;
            AddressListItem* addrItem = nil;
            int rowInd = indexPath.row;
            rowInd+=1;
            for(AddressListItem* addr in addrArray)
            {
                if(addr.addressTypeValue == rowInd)
                {
                    addrItem = addr;//[addrArray objectAtIndex:indexPath.row]; 
                    break;
                }
            }
            
            if(addrItem == nil)
            {
                addrItem = [AddressListItem createEntity];
                addrItem.addressTypeValue = rowInd;
                [self.detailItem addAddressesObject:addrItem];
            }
            
            
            switch(tag)
            {
                case EAddressStreet1:
                {
                    addrItem.addressLine1 = textField.text;
                }
                    break;
                case EAddressStreet2:
                    addrItem.addressLine2 = textField.text;
                    break;
                case EAddressCity:
                    addrItem.city = textField.text;
                    break;
                case EAddressZipCode:
                {
                    if([textField.text isValidZipCode])
                    {
                        addrItem.postalCode =textField.text;
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
            switch(tag)
            {
                case EContactFirstName:
                    cnt.firstName = textField.text;
                    break;
                case EContactLastName:
                    cnt.lastName = textField.text;
                    break;
                case EContactMobilePhone:
                    
                    break;
                case EContactEmailAddress:
                    //  cnt.e
                    break;
                case EContactSSN:
                    cnt.ssn = textField.text;
                    break;
                
            }
            break;
        }
    }
    
    if ([self.detailItem valueForKey:@"editedValue"]) {
    [[NSManagedObjectContext defaultContext] save];
  
        [self toggleSubmitButton:[self isEnableSubmit]];
        
        
    }
}
-(void)modifyEmailItem:(UITextField *)textField :(NSInteger)emailType
{
 //   if([textField.text length]<=0)
 //       return;
    
    EmailListItem *newMail=nil;
    for (EmailListItem *email in _detailItem.emails)
    {
      //  int emailType = email.typeValue;
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
-(void) modifyPhoneItem:(UITextField *)textField :(NSInteger)phoneType
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
                   _detailItem.eAndOExpires == nil ||
                   _detailItem.dateEstablished == nil
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
                if(/*_detailItem.appointedDate == nil||
                   _detailItem.status == nil ||
                   _detailItem.statusDate == nil ||
                   _detailItem.suspensionReason == nil ||*/
                   _detailItem.isEligible == nil)
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
                if(!isPhoneNoFound || !isEmailFound || !isFaxFound) 
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
                    if([cItem.firstName length]<=0||
                       [cItem.lastName length]<=0||
                       cItem.type == nil||
                       [cItem.ssn length]<=0
                       )
                        return FALSE;
                }
            }
                break;
        }
    }
    
    return TRUE;
}
/*
-(void) changeTextFieldOutline:(UITextField *)textField:(BOOL) toOriginal
{
    if(!toOriginal)
    {
    [textField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [textField.layer setBorderColor: [[UIColor redColor] CGColor]];
    [textField.layer setBorderWidth: 3.0f];
    [textField.layer setCornerRadius:8.0f];
    [textField.layer setMasksToBounds:YES];
    }
    else
    {
        textField.layer.borderColor=[[UIColor clearColor]CGColor];
    }
}
  */  
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
