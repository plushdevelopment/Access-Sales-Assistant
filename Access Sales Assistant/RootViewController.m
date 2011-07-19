//
//  RootViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "BaseDetailViewController.h"

#import "AgenciesTableViewController.h"

#import "NSData+Base64.h"

#import "StringEncryption.h"

#import "CustomCellBackground.h"

#import "CustomHeader.h"

#import "CustomFooter.h"

#import "SectionHeaderView.h"

#import "MainViewSectionInfo.h"

#import "FeaturesAndBenefitsViewController.h"

#import "ContactsViewController.h"

#import "ContactQAFormView.h"

#import "MyTreeViewCell.h"

#define SECTION_HEADER_HEIGHT 50
#define VISIT_APPLICATION_DAYS @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil
#define CONTACT_OPTIONS @"EMAIL SSC",@"EMAIL CUSTOMER SERVICE",@"EMAIL NSF",@"EMAIL PRODUCT",@"EMAIL QA FORM",@"EMAIL FACILITIES",@"QA RESOLUTION TIMETABLE",@"EMAIL HELP DESK",nil
#define SECTION_TITLES @"Visit Application",@"Appointment Application",@"Prospect Application",@"Features & Benefits",@"Access Academy",@"Contacts",@"GPS",nil
#define SECTION_ROW_COUNT 5,0,0,0,0,5,0,nil
#define VISIT_APP_INDEX 0
#define CONTACTS_OPTIONS_INDEX 5
#define APPOINTMENTAPP_INDEX 1
#define PROSPECT_APP_INDEX 2
#define FEATURES_AND_BENEFITS_INDEX 3
#define ACCESS_ACADEMY_INDEX 4
#define GPS_INDEX 6

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation RootViewController

@synthesize detailViewController = _detailViewController;

@synthesize openSectionIndex = _openSectionIndex;

@synthesize sectionInfoArray = _sectionInfoArray;

@synthesize popoverController;

@synthesize rootPopoverButtonItem;

@synthesize splitViewController;

@synthesize treeNode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.clearsSelectionOnViewWillAppear = NO;
		self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
		self.title = @"Menu";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Add a pinch gesture recognizer to the table view.
	UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
	[self.tableView addGestureRecognizer:pinchRecognizer];
	
    
    // Set up default values.
    self.tableView.sectionHeaderHeight = SECTION_HEADER_HEIGHT;
    
    sectionTitlesArray = [[NSArray alloc] initWithObjects:SECTION_TITLES];
    _openSectionIndex = NSNotFound;
    
    sectionIdsArray = [NSMutableArray array];
    visitApplicationDaysArray = [[NSArray alloc] initWithObjects:VISIT_APPLICATION_DAYS];
    contactOptionsArray= [[NSArray alloc] initWithObjects:CONTACT_OPTIONS];
	
    
    NSMutableArray* arrayInfo = [NSMutableArray array];
    for(int s =0; s<7;s++)
    {
        MainViewSectionInfo* tSectionInfo = [[MainViewSectionInfo alloc] init];
        tSectionInfo.sectionName = [sectionTitlesArray objectAtIndex:s];
        tSectionInfo.open = NO;     
        
        [arrayInfo addObject:tSectionInfo];
    }
    self.sectionInfoArray = arrayInfo;
    
    
    
    ///access academy tree structure
	
	treeNode = [[MyTreeNode alloc] initWithValue:@"Root"];
    MyTreeNode* fCardNode = [[MyTreeNode alloc] initWithValue:@"FLASH CARDS"];
    [treeNode addChild:fCardNode];
    MyTreeNode* tVideosNode = [[MyTreeNode alloc] initWithValue:@"TRAINING VIDEOS"];
    [treeNode addChild:tVideosNode];
    MyTreeNode* fCardProspectNode = [[MyTreeNode alloc] initWithValue:@"PROSPECT"];
    [fCardNode addChild:fCardProspectNode];
    MyTreeNode* fCardZeroProducerNode = [[MyTreeNode alloc] initWithValue:@"ZERO PRODUCER"];
    [fCardNode addChild:fCardZeroProducerNode];
    MyTreeNode* fCardProducerNode = [[MyTreeNode alloc] initWithValue:@"PRODUCER"];
    [fCardNode addChild:fCardProducerNode];
    MyTreeNode* tVideosExternalNode = [[MyTreeNode alloc] initWithValue:@"EXTERNAL VIDEOS"];
    [tVideosNode addChild:tVideosExternalNode];
    MyTreeNode* tVideosInternalNode = [[MyTreeNode alloc] initWithValue:@"INTERNAL VIDEOS"];
    [tVideosNode addChild:tVideosInternalNode];
    
    fCardNode.inclusive = !fCardNode.inclusive;
    tVideosNode.inclusive = !tVideosNode.inclusive;
    
    [treeNode flattenElementsWithCacheRefresh:YES];
	
	/*
	AgenciesTableViewController *viewController = [[AgenciesTableViewController alloc] initWithNibName:@"AgenciesTableViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:YES];
	viewController.detailViewController = self.detailViewController;
	 */
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
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    barButtonItem.title = @"Menu";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.sectionInfoArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
	NSInteger rowsCount = 0;
    
	
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    
    BOOL isSectionOpen = sectionInfo.open;
    if(isSectionOpen)
    {
		
		if (section == VISIT_APP_INDEX) {
			rowsCount = [visitApplicationDaysArray count];
		}
		else if(section == CONTACTS_OPTIONS_INDEX)
			rowsCount = [contactOptionsArray count];
		else if(section == ACCESS_ACADEMY_INDEX)
			rowsCount =[treeNode descendantCount];
		else
			rowsCount =0;
        
        return rowsCount;
    }
    else 
        return 0;
    
	// return sectionInfo.open ? rowsCount : 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if(indexPath.section == ACCESS_ACADEMY_INDEX && sectionInfo.open)
    {
		static NSString *CellIdentifier1 = @"AccessCell";
        
        MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
        MyTreeViewCell *cell = [[MyTreeViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:CellIdentifier1 
                                                               level:[node levelDepth] - 1 
                                                            expanded:node.inclusive];   
        cell.backgroundView = [[CustomCellBackground alloc] init];
        cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
        ((CustomCellBackground *)cell.selectedBackgroundView).selected = YES;
        NSString* valText = [[NSString alloc] initWithFormat:@"%@",node.value];
        
        cell.valueLabel.text = valText;
        
        return cell;
		
        
    }
    else
    {
        
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.backgroundView = [[CustomCellBackground alloc] init];
			cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
			((CustomCellBackground *)cell.selectedBackgroundView).selected = YES;
		}
		
		
		NSInteger section = indexPath.section;
		NSInteger row = indexPath.row;
		
		switch (section) {
			case VISIT_APP_INDEX:
				cell.textLabel.text = [visitApplicationDaysArray objectAtIndex:row];
				break;
			case CONTACTS_OPTIONS_INDEX:
				cell.textLabel.text = [contactOptionsArray objectAtIndex:row];
				break;
			default:
				break;
		}
		cell.textLabel.backgroundColor = [UIColor clearColor];    
		cell.textLabel.highlightedTextColor = [UIColor blackColor];
		
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (self.openSectionIndex) {
        case VISIT_APP_INDEX:
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            if(indexPath.row == 4)
            {
				
                ContactQAFormView *detailViewController = [[ContactQAFormView alloc] initWithNibName:@"ContactQAFormView" bundle:nil];
                NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
                self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                self.detailViewController = detailViewController;
            }
            else
            {
                
                ContactsViewController * detailViewController = [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil];
                NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
                self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                self.detailViewController = detailViewController;
                
                
				//    ContactsViewController* contactDetailView = (ContactsViewController*) self.detailViewController;
				detailViewController.selectedContactOption = indexPath.row;
				[detailViewController launchMailComposer];
            }
        }
            break;
            
        case ACCESS_ACADEMY_INDEX:
        {
            MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
            if (!node.hasChildren) return;
            
            node.inclusive = !node.inclusive;	
            [treeNode flattenElementsWithCacheRefresh:YES];
            [tableView reloadData];
            
        }
            break;
            
        default:
            break;
    }
	/*	
	 AgenciesTableViewController *viewController = [[AgenciesTableViewController alloc] initWithNibName:@"AgenciesTableViewController" bundle:nil];
	 [self.navigationController pushViewController:viewController animated:YES];
	 viewController.detailViewController = self.detailViewController;
	 */
    
	
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
	
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    if (!sectionInfo.headerView) {
		NSString *playName = sectionInfo.sectionName;
        BOOL isDisclosure = FALSE;
        if(section == VISIT_APP_INDEX || section == CONTACTS_OPTIONS_INDEX || section == ACCESS_ACADEMY_INDEX)
            isDisclosure = TRUE;
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, SECTION_HEADER_HEIGHT) title:playName section:section displayDisclosure:isDisclosure delegate:self];
    }
    
    return sectionInfo.headerView;
}

#pragma mark Section header delegate

- (void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
    [self.tableView clearsContextBeforeDrawing];
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
	sectionInfo.open = YES;
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert;
    if(sectionOpened == VISIT_APP_INDEX)
        countOfRowsToInsert = [visitApplicationDaysArray count];
    else if(sectionOpened == CONTACTS_OPTIONS_INDEX)
        countOfRowsToInsert =[contactOptionsArray count];
    else if(sectionOpened == ACCESS_ACADEMY_INDEX)
        countOfRowsToInsert = [treeNode descendantCount];
    else
        countOfRowsToInsert =0;
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
        NSInteger countOfRowsToDelete;
        if(previousOpenSectionIndex == VISIT_APP_INDEX)
            countOfRowsToDelete = [visitApplicationDaysArray count];
        else if(previousOpenSectionIndex ==CONTACTS_OPTIONS_INDEX)
            countOfRowsToDelete =[contactOptionsArray count];
        else if(previousOpenSectionIndex == ACCESS_ACADEMY_INDEX)
            countOfRowsToDelete = [treeNode descendantCount];
        else
            countOfRowsToDelete =0;
        
        MainViewSectionInfo *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
		
        
        
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
	
    
	// MainViewSectionInfo *previousOpenSection1 = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
    //previousOpenSection1.open = NO;
	//  [previousOpenSection1.headerView toggleOpenWithUserAction:NO];
    //previousOpenSection1.headerView.darkColor = RGB(73,103,22);
	// [previousOpenSection1.headerView setNeedsDisplay];
	
	
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    [self.tableView reloadData];
	self.openSectionIndex = sectionOpened;  
    
    MainViewSectionInfo* sectInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
    
	// if(sectInfo.headerView.disclosureButton)
    //    return;
    
    switch (sectionOpened) {
        case VISIT_APP_INDEX:
        {
			VisitApplicationViewController *detailViewController = [[VisitApplicationViewController alloc] initWithNibName:@"VisitApplicationViewController" bundle:nil];
            NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
			if (UIDeviceOrientationIsPortrait(self.interfaceOrientation)) {
				[detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
			}
			self.detailViewController = detailViewController;
        }
            break;
        case APPOINTMENTAPP_INDEX:
            break;
        case PROSPECT_APP_INDEX:
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            
			/*    ContactsViewController * detailViewController = [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil];
			 NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
			 self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
			 
			 self.detailViewController = detailViewController;
			 */
			
            break;
        }
        case FEATURES_AND_BENEFITS_INDEX:
        {
			//[self.splitViewController.viewControllers]
            
            FeaturesAndBenefitsViewController * detailViewController = [[FeaturesAndBenefitsViewController alloc] initWithNibName:@"FeaturesAndBenefitsViewController" bundle:nil];
            NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
			
            self.detailViewController = detailViewController;
        }
            break;
        case GPS_INDEX:
        {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString: @"http://maps.google.com/"]];
        }
            break;
            
            
        default:
            break;
    }
	
    
    //[self.popoverController dismissPopoverAnimated:YES];
}

- (void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
	sectionInfo.open = NO;
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
			
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
		
    }
	self.openSectionIndex = NSNotFound;
    
	//   if(sectionClosed == ACCESS_ACADEMY_INDEX)
	//      [[treeNode children] removeAllObjects];
    
}

@end
