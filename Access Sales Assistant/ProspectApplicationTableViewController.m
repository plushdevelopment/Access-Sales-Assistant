//
//  ProspectApplicationTableViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProspectApplicationTableViewController.h"
#import "UITableView+PRPSubviewAdditions.h"
#import "ProspectAppConstants.h"
#import "State.h"
#import "Rater.h"
#import "Rater2.h"
#import "SubTerritory.h"
#import "HTTPOperationController.h"
#import "Contact.h"
#import "User.h"
#import "ContactType.h"
#import "AddressListItem.h"
#import "PhoneListItem.h"
#import "EmailListItem.h"
#import "NSString-Validation.h"
#import "SelectionModelViewController.h"
#import "UIHelpers.h"

@implementation ProspectApplicationTableViewController

@synthesize tableView = _tableView;
@synthesize raterTableViewCell = _raterTableViewCell;
@synthesize contactInfoTableViewCell = _contactInfoTableViewCell;
@synthesize contactTableViewCell = _contactTableViewCell;
@synthesize generalTableViewCell = _generalTableViewCell;
@synthesize addressTableViewCell = _addressTableViewCell;
@synthesize detailItem = _detailItem;
@synthesize datePickerViewController = _datePickerViewController;
@synthesize popoverController;
@synthesize toolBar = _toolBar;
@synthesize submitButton = _submitButton;
@synthesize spaceButton = _spaceButton;
@synthesize prospectPopoverController = _prospectPopoverController;
@synthesize fields=_fields;

- (void)postProducerSuccess:(id)notification
{
	[UIHelpers showAlertWithTitle:@"Success" msg:@"Successfully submitted Prospect Application" buttonTitle:@"OK"];
	[self.detailItem deleteEntity];
	[[NSManagedObjectContext defaultContext] save];
	self.detailItem = [Producer ai_objectForProperty:@"prospect" value:[NSNumber numberWithBool:YES] managedObjectContext:[NSManagedObjectContext defaultContext]];
	Contact *contact = [Contact createEntity];
    contact.type = [ContactType findFirstByAttribute:@"name" withValue:@"Owner"];
    [self.detailItem addContactsObject:contact];
    self.detailItem.editedValue = YES;
	contact.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	[self toggleSubmitButton:[self isEnableSubmit]];
	[self.tableView reloadData];
}

- (void)hideKeyboard
{
    [self.generalTableViewCell hideKeyboard];
    [self.contactInfoTableViewCell hideKeyboard];
    [self.contactTableViewCell hideKeyboard];
    [self.addressTableViewCell hideKeyboard];
    [self.raterTableViewCell hideKeyboard];
	
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
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    sectionTitleArray = [[NSArray alloc] initWithObjects:PROSPECT_APP_SECTIONS];
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postProducerSuccess:) name:@"Post Producer Successful" object:nil];
    
    self.baseToolbar = _toolBar;
    myTextFieldSemaphore =0;
    myPhoneNumberFormatter = [[PhoneNumberFormatter alloc] init];
    
    self.detailItem = [Producer ai_objectForProperty:@"prospect" value:[NSNumber numberWithBool:YES] managedObjectContext:[NSManagedObjectContext defaultContext]];
    
    Contact *ownerContact = nil;
    for (Contact *contact in _detailItem.contacts) {
        if ([contact.type.name isEqualToString:@"Owner"]) {
            ownerContact = contact;
            break;
        }
    }
	//Contact *contact = [Contact createEntity];
        
        if(!ownerContact)
        {
            ownerContact = [Contact createEntity];
    ownerContact.type = [ContactType findFirstByAttribute:@"name" withValue:@"Owner"];
    [self.detailItem addContactsObject:ownerContact];
   
	ownerContact.editedValue = YES;
        }
         self.detailItem.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	[self toggleSubmitButton:[self isEnableSubmit]];
	
	self.fields = [NSMutableSet set];
}

- (void)viewDidUnload
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.tableView setNeedsDisplay];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionTitleArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows =0;
    // Return the number of rows in the section.
    switch (section) {
        case EGeneral:
            rows = 1;
            break;
        case EAddresses:
            rows =3;
            break;
        case EContactInfo:
            rows = 1;
            break;
        case ERater:
            rows = 1;
            break;
        case EContact:
			rows = 1;//[_detailItem.contacts.allObjects count];
            break;
            
        default:
            break;
    }
    return rows;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    switch(indexPath.section)
    {
        case EGeneral:
        {
            
            ProspectAppGeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProspectAppGeneralTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProspectAppGeneralTableViewCell" owner:self options:nil];
                cell = (ProspectAppGeneralTableViewCell*)_generalTableViewCell;
            }
			
            cell.producerNameField.text = _detailItem.name;
            cell.subTerritoryField.text = _detailItem.subTerritory.uid.stringValue;
			User *user = [User findFirst];
            cell.tsmNameField.text = [user username];
            
            [self disableTextField:cell.sourceField :NO];
            
            [self disableTextField:cell.tsmNameField :NO];
			
			[self.fields addObject:cell.producerNameField];
			[self.fields addObject:cell.subTerritoryField];
			
            return cell;
        }
            break;
        case EAddresses:
        {
            ProducerAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProspectAppAddressTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProspectAppAddressTableViewCell" owner:self options:nil];
                cell = (ProducerAddressTableViewCell*)_addressTableViewCell;
            }
            cell = [self addressTableViewCell:cell :(indexPath.row)+1];
			
			[self.fields addObject:cell.streetAddress1TextField];
			[self.fields addObject:cell.streetAddress2TextField];
			[self.fields addObject:cell.cityTextField];
			[self.fields addObject:cell.zipTextField];
			
            return cell;
        }
			//  break;
        case EContactInfo:
        {
            ProducerContactInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProspectAppCompanyContactInfoTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProspectAppCompanyContactInfoTableViewCell" owner:self options:nil];
                cell = (ProducerContactInfoTableViewCell*)_contactInfoTableViewCell;
            }
            
            for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers) {
                if (phoneNumber.typeValue == PHONE_1) {
                    [cell.phone1TextField setText:phoneNumber.number];
                } else if (phoneNumber.typeValue == 4) {
                    [cell.faxTextField setText:phoneNumber.number];
                }
            }
			
            for (EmailListItem *email in _detailItem.emails) {
                
                if (email.typeValue == 3) {
                    [cell.mainMailTextField setText:email.address];
                    break;
                } 
            }
            [self.fields addObject:cell.phone1TextField];
			[self.fields addObject:cell.faxTextField];
			[self.fields addObject:cell.mainMailTextField];
            return cell;
        }
            break;
        case ERater:
        {
            ProducerRaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProspectAppRaterTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProspectAppRaterTableViewCell" owner:self options:nil];
                cell = (ProducerRaterTableViewCell*)_raterTableViewCell;
            }
			if (self.detailItem.rater) {
				[cell.rater2Button setEnabled:YES];
				[self disableTextField:cell.rater2TextField :YES];
			} else {
				[cell.rater2Button setEnabled:NO];
				[self disableTextField:cell.rater2TextField :NO];
			}
            [cell.raterTextField setText:_detailItem.rater.name];
            [cell.rater2TextField setText:_detailItem.rater2.name];
			
			[self.fields addObject:cell.raterTextField];
			[self.fields addObject:cell.rater2TextField];
			
            return cell;
        }
            break;
        case EContact:
        {
            ProspectAppContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProspectAppContactTableViewCell"];
            if (cell == nil) {
                // Load the top-level objects from the custom cell XIB.
                [[NSBundle mainBundle] loadNibNamed:@"ProspectAppContactTableViewCell" owner:self options:nil];
                cell = (ProspectAppContactTableViewCell*)_contactTableViewCell;
            }
			
			cell.primaryContactFirstName.text = _detailItem.primaryContact;
			
			for (Contact *contact in _detailItem.contacts) {
				if ([contact.type.name isEqualToString:@"Owner"]) {
					cell.ownerFirstName.text = contact.firstName;
					cell.ownerLastName.text = contact.lastName;
				}
			}
			
			[self.fields addObject:cell.primaryContactFirstName];
			[self.fields addObject:cell.ownerFirstName];
			[self.fields addObject:cell.ownerLastName];
			
            return cell;
            
        }
            break;
    }
	
	return nil;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
    switch (indexPath.section) {
        case EGeneral:
        {
            height = GENERAL_HEIGHT;
        }
            break;
        case ERater:
        {
            height = RATER_HEIGHT;
        }
            break;
        case EContactInfo:
        {
            height = CONTACT_INFO_HEIGHT;
            break;
        }
            
        case EAddresses:
        {
            height = ADDRESS_HEIGHT;
            break;
        }
        case EContact:
        {
			height = CONTACT_HEIGHT;
            break;
        }
        default:
            height = 110.0;
    }
    
    return height;
}


#pragma mark - Fill the table view cell with entity values
-(ProducerAddressTableViewCell*) addressTableViewCell:(ProducerAddressTableViewCell*) addressCell:(NSInteger)forType
{
    for(AddressListItem *addrItem in _detailItem.addresses)
    {
        if(addrItem.addressTypeValue == forType)
        {
            addressCell.streetAddress1TextField.text = addrItem.addressLine1;
            addressCell.streetAddress2TextField.text = addrItem.addressLine2;
            addressCell.cityTextField.text = addrItem.city;
            addressCell.stateTextField.text = addrItem.state.name;
            addressCell.zipTextField.text = addrItem.postalCode;
			//  if()
            break;
        }
        
    }
    if(forType == 1)
        addressCell.addressTitle.text = @"Mailing Address*";
    else if(forType == 2)
        addressCell.addressTitle.text = @"Commission Address*";
    else if(forType == 3)
        addressCell.addressTitle.text = @"Physical Address*";
    
	
    return addressCell;
}


// Show the Date picker in Date mode in a popover
- (IBAction)showDatePickerView:(id)sender
{
	UIButton *button = (UIButton *)sender;
	[self.datePickerViewController.datePicker setDate:[NSDate date]];
	self.datePickerViewController.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
	self.datePickerViewController.currentTag = button.tag;
	[self.datePickerViewController.datePicker setDatePickerMode:UIDatePickerModeDate];
	
	//Position the picker out of sight
	[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
    
    NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
	
	//Add the picker to the view
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.datePickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
	
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
		NSString *pickerFrame = [NSString stringWithFormat:@"NSRect: {{%f, %f}, {%f, %f}}", self.datePickerViewController.view.frame.origin.x, self.datePickerViewController.view.frame.origin.y, self.datePickerViewController.view.frame.size.height, self.datePickerViewController.view.frame.size.width];
        
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:UIKeyboardFrameEndUserInfoKey, pickerFrame, nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Picker Did Show" object:userInfo];
	}];
	[self datePickerViewController:self.datePickerViewController didChangeDate:self.datePickerViewController.datePicker.date forTag:button.tag];
    
}

- (void)dismissKeyboard
{
	[self.fields makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

-(IBAction)showSelectionTableView:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    SelectionModelViewController *selectionView = [[SelectionModelViewController alloc] initWithNibName:@"SelectionModelViewController" bundle:nil];
    
    selectionView.currentIndexPath = [self.tableView prp_indexPathForRowContainingView:sender];
    
    selectionView.currentTag = button.tag;
    
    [selectionView  setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [selectionView  setModalPresentationStyle:UIModalPresentationFormSheet];
    selectionView.delegate = self;
    
    
    switch(selectionView.currentIndexPath.section)
    {
        case EAddresses:
        {
            switch(selectionView.currentTag)
            {
                case EAddressState:
                {
                    [selectionView assignDataSource:(NSMutableArray*)[State findAllSortedBy:@"name" ascending:YES]];
					
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
                }
					break;
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
			
    }
	[self dismissKeyboard];
	[self.parentViewController presentViewController:selectionView animated:YES completion:^(void){}];
	
}


#pragma mark -
#pragma mark DatePickerViewControllerDelegate

- (void)datePickerViewController:(DatePickerViewController *)controller didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	
}


#pragma mark -
#pragma mark Textfield delegate methods
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
                case EAddressZip:
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
        case EContactInfo:
        {
            
            switch(tag)
            {
                case EContactInfoPhone:
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
                case EContactInfoFax:
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
                case EContactInfoEmail:
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
			}
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
	[textField resignFirstResponder];
	return YES;
}

-(void) saveTextFieldToContext:(UITextField*) textField
{
    Producer *producer = (Producer *)self.detailItem;
	if (!producer.editedValue) {
		producer.editedValue = YES;
		[[NSManagedObjectContext defaultContext] save];
	}
    
    NSIndexPath *indexPath = [self.tableView prp_indexPathForRowContainingView:textField];
	NSInteger tag = textField.tag;
    
    switch(indexPath.section)
    {
        case EGeneral:
        {
            switch(tag)
            {
                case EProducerName:
                    self.detailItem.name = textField.text;
                    break;
                case ETSMName:
                    break;
                case ESubTerritory:
                {
                    self.detailItem.subTerritory = [SubTerritory ai_objectForProperty:@"uid" value:textField.text managedObjectContext:[NSManagedObjectContext defaultContext]];
                    break;
                }
					
                case ESource:
                    break;
            }
        }
            break;
        case EAddresses:
        {
            NSArray *addrArray = _detailItem.addresses.allObjects;
            AddressListItem* addrItem = nil;
            int rowInd = indexPath.row;
            rowInd+=1;
            for(AddressListItem* addr in addrArray)
            {
                if(addr.addressTypeValue == rowInd)
                {
                    addrItem = addr;
                    break;
                }
            }
            
            if(addrItem == nil)
            {
                addrItem = [AddressListItem createEntity];
                addrItem.addressTypeValue = rowInd;
                [self.detailItem addAddressesObject:addrItem];
            }
            
			addrItem.editedValue = YES;
            
            switch(tag)
            {
                case EAddressStreet1:
                {
                    addrItem.addressLine1= textField.text;
                }
                    break;
                case EAddressStreet2:
                    addrItem.addressLine2 = textField.text;
                    break;
                case EAddressCity:
                    addrItem.city = textField.text;
                    break;
                case EAddressZip:
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
        case EContactInfo:
        {
            
            switch(tag)
            {
				case EContactInfoPhone:
                {
                    
                    BOOL phoneExists = FALSE;
                    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers)
                    {
                        if(phoneNumber.typeValue == PHONE_1)
                        {
                            phoneExists= TRUE;
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
                            PhoneListItem *phNo = [PhoneListItem createEntity];
                            phNo.typeValue = PHONE_1;
                            phNo.number = textField.text;
                            
                            [self.detailItem addPhoneNumbersObject:phNo];
                            [self changeTextFieldOutline:textField:YES];
                        }
                        else
                        {
                            [self showAlert:VALID_PHONE_ALERT];
                            [self changeTextFieldOutline:textField:NO];
                        }
						
                    }
                }
                    break;
				case EContactInfoFax:
                {
                    BOOL phoneExists = FALSE;
                    for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers)
                    {
                        if(phoneNumber.typeValue == 4)
                        {
                            phoneExists= TRUE;
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
							PhoneListItem *phNo = [PhoneListItem createEntity];
							phNo.typeValue = 4;
							phNo.number = textField.text;
							
							[self.detailItem addPhoneNumbersObject:phNo];
                            [self changeTextFieldOutline:textField:YES];
                        }
                        else
                        {
                            [self showAlert:VALID_PHONE_ALERT];
                            [self changeTextFieldOutline:textField:NO];
                        }
					}
                    break;
				case EContactInfoEmail:
					{
						BOOL isMailExists = FALSE;
						for (EmailListItem *email in _detailItem.emails)
						{
							if(email.typeValue == 3)
							{
								isMailExists = TRUE;
								if([textField.text isValidEmail])
								{
									
									email.address = textField.text;
									[self changeTextFieldOutline:textField:YES];
								}
								else
								{
									[self showAlert:VALID_EMAIL_ALERT];
									[self changeTextFieldOutline:textField:NO];
								}
								break;
							}
						}
						if(!isMailExists)
						{
							
							if([textField.text isValidEmail])
							{
								EmailListItem* emailItem = [EmailListItem createEntity];
								emailItem.typeValue = 3;
								emailItem.address = textField.text;
								[self.detailItem addEmailsObject:emailItem];
								[self changeTextFieldOutline:textField:YES];
							}
							else
							{
								[self showAlert:VALID_EMAIL_ALERT];
								[self changeTextFieldOutline:textField:NO];
							}
                            
						}
					}
                    break;
				}
            }
        }
            break;
        case EContact:
        {
            switch(tag)
            {
				case EOwnerFirstName:
					for (Contact *contact in _detailItem.contacts) {
						if ([contact.type.name isEqualToString:@"Owner"]) {
							contact.firstName = textField.text;
							break;
						}
					}
					break;
				case EOwnerLastName:
					for (Contact *contact in _detailItem.contacts) {
						if ([contact.type.name isEqualToString:@"Owner"]) {
							contact.lastName = textField.text;
							break;
						}
					}
					break;
				case EPrimaryFirstName:
					_detailItem.primaryContact = textField.text;
					break;
				default:
					break;
			}
        }
            break;
    }
    [[NSManagedObjectContext defaultContext] save];
	//[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
	
    [self toggleSubmitButton:[self isEnableSubmit]];
}

-(IBAction)submitProspectApp:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showInfo:) name:@"Post Producer Successful" object:nil];
    Producer *producer = (Producer *)self.detailItem;
    [[HTTPOperationController sharedHTTPOperationController] postProducerProfile:[producer jsonStringValue]];
}
-(void) showInfo:(id) sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Post Producer Successful" object:nil];
    [self showAlert:@"Prospect Application submitted Successfully!"];
}

-(void) toggleSubmitButton:(BOOL)isEnabled
{
	[_submitButton setEnabled:isEnabled];
}
-(BOOL) isEnableSubmit
{
    
    for(int section =0;section<EProspectNumSections;section++)
    {
        switch(section)
        {
            case EGeneral:
            {
                if([_detailItem.name length]<=0||
                   _detailItem.subTerritory == nil)
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
                       addrItem.state == nil ||
                       [addrItem.city length]<=0 ||
                       [addrItem.postalCode length]<=0)
                        return FALSE;
                }
				
            }
                break;
            case EContactInfo:
            {
                if([_detailItem.phoneNumbers.allObjects count]<=0 /*|| [_detailItem.emails.allObjects count]<=0*/)
                    return FALSE;
                BOOL isPhoneNoFound = FALSE;
                
                
                
                for(PhoneListItem *pItem in _detailItem.phoneNumbers.allObjects)
                {
                    if(pItem.typeValue == PHONE_1)
                    {
                        if([pItem.number length]>0)
                            isPhoneNoFound = TRUE;
                    }
                    
					
                }
                if(!isPhoneNoFound ) 
                    return FALSE;
				
            }
                break;
            case ERater:
            {
                if(_detailItem.rater == nil)
                    return FALSE;
				
            }
                break;
            case EContact:
                break;
                
                
        }
    }
    return YES;
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

-(void) selectedOption:(NSString*) selectedString:(NSIndexPath*) forIndexPath:(NSInteger) forTag
{
	self.detailItem.editedValue = YES;
    switch(forIndexPath.section)
    {
        case EAddresses:
        {
            switch(forTag)
            {
                case EAddressState:
                {
                    int indRow = forIndexPath.row;
                    switch(forIndexPath.row)
                    {
                        case 0:
                        {
                            AddressListItem *addrItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                int addrValue = address.addressTypeValue;
                                if (address.addressTypeValue == 1) {
                                    addrItem = address;
                                    continue;
                                }
                            }
                            if(addrItem != nil)
                            {
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addrItem = [AddressListItem createEntity];
                                addrItem.addressTypeValue = 1;
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addrItem];
                            }
							
							addrItem.editedValue = YES;
                            
                            break;
                        }
                            
                        case 1:
                        {
                            AddressListItem *addrItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                int addrValue = address.addressTypeValue;
                                if (address.addressTypeValue == 2) {
                                    addrItem = address;
                                    break;
                                }
                            }
                            if(addrItem != nil)
                            {
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addrItem = [AddressListItem createEntity];
                                addrItem.addressTypeValue = 2;
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addrItem];
                            }
							addrItem.editedValue = YES;
							
                            break;
                        }
                            
                        case 2:
                        {
                            AddressListItem *addrItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                int addrValue = address.addressTypeValue;
                                if (address.addressTypeValue == 3) {
                                    addrItem = address;
                                    break;
                                }
                            }
                            if(addrItem != nil)
                            {
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                            }
                            else
                            {
                                addrItem = [AddressListItem createEntity];
                                addrItem.addressTypeValue = 3;
                                addrItem.state = [State findFirstByAttribute:@"name" withValue:selectedString];
                                [self.detailItem addAddressesObject:addrItem];
                            }
							
							addrItem.editedValue = YES;
                            break;
                        }
							
							break;
					}
                }
					break;
            }
        }
        case ERater:
        {
            switch(forTag)
            {
                case ERater1:
                    self.detailItem.rater = [Rater findFirstByAttribute:@"name" withValue:selectedString];
					if (!self.detailItem.rater) {
						self.detailItem.rater2 = nil;
					}
                    break;
                case ERater2:
                    self.detailItem.rater2 = [Rater2 findFirstByAttribute:@"name" withValue:selectedString];
                    break;
            }
            break;
        }
    }
    
	[[NSManagedObjectContext defaultContext] save];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:forIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
	[self toggleSubmitButton:[self isEnableSubmit]];
}


@end
