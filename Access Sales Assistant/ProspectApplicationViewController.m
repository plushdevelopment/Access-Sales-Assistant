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
    
    _detailItem = [Producer ai_objectForProperty:@"uid" value:[dict valueForKey:@"uid"] managedObjectContext:context];
    
    User *user = [User findFirst];
    
    _tsmName.text =  [user username];
    
    
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
