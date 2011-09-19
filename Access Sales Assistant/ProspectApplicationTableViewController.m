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

@implementation ProspectApplicationTableViewController

@synthesize tableView = _tableView;
@synthesize raterTableViewCell = _raterTableViewCell;
@synthesize contactInfoTableViewCell = _contactInfoTableViewCell;
@synthesize contactTableViewCell = _contactTableViewCell;
@synthesize generalTableViewCell = _generalTableViewCell;
@synthesize addressTableViewCell = _addressTableViewCell;
@synthesize detailItem = _detailItem;
@synthesize pickerViewController = _pickerViewController;
@synthesize datePickerViewController = _datePickerViewController;
@synthesize popoverController;
@synthesize toolBar = _toolBar;
@synthesize submitButton = _submitButton;
@synthesize spaceButton = _spaceButton;
@synthesize pListTableViewController = _pListTableViewController;
@synthesize prospectPopoverController = _prospectPopoverController;

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
    
    
    self.baseToolbar = _toolBar;
    myTextFieldSemaphore =0;
    myPhoneNumberFormatter = [[PhoneNumberFormatter alloc] init];
    
    self.detailItem = [Producer createEntity];
	Contact *contact = [Contact createEntity];
    contact.type = [ContactType findFirstByAttribute:@"name" withValue:@"Owner"];
    [self.detailItem addContactsObject:contact];
    self.detailItem.editedValue = YES;
	contact.editedValue = YES;
	[[NSManagedObjectContext defaultContext] save];
	[self toggleSubmitButton:[self isEnableSubmit]];
}

- (void)viewDidUnload
{
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
			rows = [_detailItem.contacts.allObjects count];
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
            [[NSBundle mainBundle] loadNibNamed:@"ProspectAppGeneralTableViewCell" owner:self options:nil];
            ProspectAppGeneralTableViewCell* cell = _generalTableViewCell;
            cell.producerNameField.text = _detailItem.name;
            cell.subTerritoryField.text = _detailItem.subTerritory.uid.stringValue;
			User *user = [User findFirst];
            cell.tsmNameField.text = [user username];
            
            [self disableTextField:cell.sourceField :NO];
            
            [self disableTextField:cell.tsmNameField :NO];
            return cell;
        }
            break;
        case EAddresses:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProspectAppAddressTableViewCell" owner:self options:nil];
            ProducerAddressTableViewCell* cell = _addressTableViewCell;
            cell = [self addressTableViewCell:cell :(indexPath.row)+1];
            return cell;
        }
			//  break;
        case EContactInfo:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProspectAppCompanyContactInfoTableViewCell" owner:self options:nil];
            ProducerContactInfoTableViewCell* cell = _contactInfoTableViewCell;
            
            for (PhoneListItem *phoneNumber in _detailItem.phoneNumbers) {
                if (phoneNumber.typeValue == 3) {
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
            
            return cell;
        }
            break;
        case ERater:
        {
            [[NSBundle mainBundle] loadNibNamed:@"ProspectAppRaterTableViewCell" owner:self options:nil];
            ProducerRaterTableViewCell* cell = _raterTableViewCell;
            [cell.raterTextField setText:_detailItem.rater.name];
            [cell.rater2TextField setText:_detailItem.rater2.name];
            return cell;
        }
            break;
        case EContact:
        {[[NSBundle mainBundle] loadNibNamed:@"ProspectAppContactTableViewCell" owner:self options:nil];
            ProspectAppContactTableViewCell* cell = _contactTableViewCell;
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
			/*  if (indexPath.row == _detailItem.contacts.allObjects.count) {
			 height =44.0;
			 }
			 else
			 */
			height = CONTACT_HEIGHT;
            break;
        }
        default:
            height = 110.0;
            //case 
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
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME_LANDSCAPE];
	} else {
		[self.pickerViewController.view setFrame:PICKER_HIDDEN_FRAME];
	}
	
	//Add the picker to the view
	[self.view.superview addSubview:self.pickerViewController.view];
	
	//This animation will work on iOS 4
	//For older iOS, use "beginAnimation:context"
	[UIView animateWithDuration:0.2 animations:^{
		//Position of the picker in sight
		if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
			[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME_LANDSCAPE];
		} else {
			[self.pickerViewController.view setFrame:PICKER_VISIBLE_FRAME];
		}
		
	} completion:^(BOOL finished){
		CIVector *frameVector = [CIVector vectorWithCGRect:self.pickerViewController.view.frame];
		NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:frameVector, UIKeyboardFrameEndUserInfoKey, nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Picker Did Show" object:userInfo];
	}];
	//[self.pickerViewController.pickerView reloadAllComponents];
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
	[self hideKeyboard];
	[self.parentViewController presentViewController:selectionView animated:YES completion:^(void){}];
	
}


#pragma mark -
#pragma mark DatePickerViewControllerDelegate

- (void)datePickerViewController:(DatePickerViewController *)controller didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag
{
	
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
		case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EAddressState:
                    rows = [[State findAll] count];
                    break;
            }
        }
        case EContact:
        {
            break;
        }
            
    }
    
	
    return rows;
}

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
                    break;
                    //  self.
                    
                }
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
		case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EAddressState:
                {
                    switch(self.pickerViewController.currentIndexPath.row)
                    {
                        case 0:
                        {
                            AddressListItem *addrItem = nil;
                            for (AddressListItem *address in _detailItem.addresses) {
                                if (address.addressTypeValue == 1) {
                                    addrItem = address;
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
                                if (address.addressTypeValue == 2) {
                                    addrItem = address;
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
                                if (address.addressTypeValue == 3) {
                                    addrItem = address;
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
    }
    [[NSManagedObjectContext defaultContext]save];
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    
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
                {
					// theTitle = [[[SubTerritory findAll] objectAtIndex:row] name];
                    theTitle = [NSString stringWithFormat:@"%d", row];
                    break;
                }
            }
        }
            break;
        case EContactInfo:
            break;
        case EAddresses:
        {
            switch(self.pickerViewController.currentTag)
            {
                case EAddressState:
                {
					theTitle = [[[State findAll] objectAtIndex:row] name];
                    break;
                }
            }
        }
            break;
        case ERater:
        {
            switch(self.pickerViewController.currentTag)
            {
                case ERater1:
                {
                    theTitle = [[[Rater findAll] objectAtIndex:row] name];
                    break;
                }
                case ERater2:
                {
                    theTitle = [[[Rater2 findAll] objectAtIndex:row] name];
                    break;
                }
					
            }
        }
            break;
        case EContact:
            break;
    }
	return theTitle;
}

-(IBAction)searchProducer:(id)sender
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchProducerDone:) 
                                                 name:@"searchProducer"
                                               object:nil];
    
    UIButton *btn = (UIButton*)sender;
	
    ProspectAppGeneralTableViewCell *parentCell = (ProspectAppGeneralTableViewCell *)[[btn superview] superview];
    
    [parentCell.producerNameField resignFirstResponder];
    
    NSString* escapedString = parentCell.producerNameField.text;
    [[HTTPOperationController sharedHTTPOperationController] searchProducer:escapedString];  
}

-(void) searchProducerDone:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchProducer" object:nil];
    [producerNamesArray removeAllObjects];
    producerNamesArray = (NSMutableArray*) [notification object];
}

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
                        if(phoneNumber.typeValue == 3)
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
                            phNo.typeValue = 3;
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
                if([_detailItem.phoneNumbers.allObjects count]<=0 || [_detailItem.emails.allObjects count]<=0)
                    return FALSE;
                BOOL isPhoneNoFound = FALSE/*,isEmailFound = FALSE,isFaxFound = FALSE*/;
                
                
                
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
