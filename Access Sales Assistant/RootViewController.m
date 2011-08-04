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

#import "SplashViewController.h"

#import "FlashCardsViewController.h"

#import "TrainingVideoViewController.h"

#import "ProspectApplicationViewController.h"

#import "ContactsQATimeTableViewController.h"

#import "Producer.h"

#import "VisitApplicationMapViewController.h"

#define SECTION_HEADER_HEIGHT       56
#define VISIT_APPLICATION_DAYS      @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil
#define CONTACT_OPTIONS             @"Email SSC",@"Email Customer Service",@"Email NSF",@"Email Product",@"Email QA Form",@"Email Facilities",@"QA Resolution Timetable",@"Email help desk",nil
#define SECTION_TITLES              @"Visit Application",@"Appointment Application",@"Prospect Application",@"Features & Benefits",@"Access Academy",@"Contacts",@"GPS",nil
#define SECTION_ROW_COUNT           5,0,0,0,0,5,0,nil
#define VISIT_APP_INDEX             0
#define CONTACTS_OPTIONS_INDEX      5
#define APPOINTMENTAPP_INDEX        1
#define PROSPECT_APP_INDEX          2
#define FEATURES_AND_BENEFITS_INDEX 3
#define ACCESS_ACADEMY_INDEX        4
#define GPS_INDEX                   6
#define FLASH_CARD_PROSPECT         1
#define FLASH_CARD_ZERO_PRODUCER    2
#define FLASH_CARD_PRODUCER         3
#define TRAINING_VIDEO              1
#define TRAINING_VIDEO_EXPANDED     4
#define CONTACT_QA_TABLE            6


#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation RootViewController

@synthesize detailViewController = _detailViewController;

@synthesize openSectionIndex = _openSectionIndex;

@synthesize sectionInfoArray = _sectionInfoArray;

@synthesize popoverController;

@synthesize rootPopoverButtonItem;

@synthesize splitViewController;

@synthesize treeNode;

@synthesize mgSplitViewController = _mgSplitViewController;

- (void)producersSuccessful
{
	NSArray *producersArray = [Producer findAllSortedBy:@"nextScheduledVisit" ascending:YES];
	NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:[producersArray count]];
	for (Producer *producer in producersArray) {
		if (![daysArray containsObject:producer.nextScheduledVisitDate]) {
			[daysArray addObject:producer.nextScheduledVisitDate];
		}
	}
	visitApplicationDaysArray = [NSArray arrayWithArray:daysArray];
	
	[self.tableView reloadData];
}

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
    
       
    // Set up default values.
    self.tableView.sectionHeaderHeight = SECTION_HEADER_HEIGHT;
    

    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    sectionTitlesArray = [[NSArray alloc] initWithObjects:SECTION_TITLES];
    _openSectionIndex = NSNotFound;
    
    sectionIdsArray = [NSMutableArray array];
    
	//visitApplicationDaysArray = [[NSArray alloc] initWithObjects:VISIT_APPLICATION_DAYS];
	[self producersSuccessful];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(producersSuccessful) name:@"Producers Successful" object:nil];
	
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
    
   // [self.mgSplitViewController toggleMasterView:@""];
    
    ///access academy tree structure
	
	treeNode = [[MyTreeNode alloc] initWithValue:@"Root"];
    MyTreeNode* fCardNode = [[MyTreeNode alloc] initWithValue:@"Flash Cards"];
    [treeNode addChild:fCardNode];
    MyTreeNode* tVideosNode = [[MyTreeNode alloc] initWithValue:@"Training Videos"];
    [treeNode addChild:tVideosNode];
    MyTreeNode* fCardProspectNode = [[MyTreeNode alloc] initWithValue:@"Prospect"];
    [fCardNode addChild:fCardProspectNode];
    MyTreeNode* fCardZeroProducerNode = [[MyTreeNode alloc] initWithValue:@"Zero Producer"];
    [fCardNode addChild:fCardZeroProducerNode];
    MyTreeNode* fCardProducerNode = [[MyTreeNode alloc] initWithValue:@"Producer"];
    [fCardNode addChild:fCardProducerNode];
    
    fCardNode.inclusive = !fCardNode.inclusive;
 
    
    [treeNode flattenElementsWithCacheRefresh:YES];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"Producers Successful" object:nil];
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
	//return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    return YES;
}
/*
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
*/
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
        case VISIT_APP_INDEX: {
            
            //VisitApplicationViewController *detailViewController = [[VisitApplicationViewController alloc] initWithNibName:@"VisitApplicationViewController" bundle:nil];
			VisitApplicationMapViewController *detailViewController = [[VisitApplicationMapViewController alloc] initWithNibName:@"VisitApplicationMapViewController" bundle:nil];
            //NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
            [self changeDetailViewController:detailViewController];
			self.detailViewController = detailViewController;
            [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
			[self.popoverController dismissPopoverAnimated:YES];
			NSLog(@"%@", [visitApplicationDaysArray objectAtIndex:indexPath.row]);
            [detailViewController setSelectedDay:[visitApplicationDaysArray objectAtIndex:indexPath.row]];
            /*
			AgenciesTableViewController *viewController = [[AgenciesTableViewController alloc] initWithNibName:@"AgenciesTableViewController" bundle:nil];
			[self.navigationController pushViewController:viewController animated:YES];
			viewController.detailViewController = self.detailViewController;
			 */
		}
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            if(indexPath.row == 4)
            {
				
                ContactQAFormView *detailViewController = [[ContactQAFormView alloc] initWithNibName:@"ContactQAFormView" bundle:nil];
          //      NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
            //    self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                [self changeDetailViewController:detailViewController];
                self.detailViewController = detailViewController;
              //  [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
                
                UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
                if(orientation == 0)
                    orientation = self.detailViewController.interfaceOrientation;;
                
                if(UIDeviceOrientationIsPortrait(orientation))
                {
                    
                    [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
                }

                [self.popoverController dismissPopoverAnimated:YES];
            }
            else if(indexPath.row == CONTACT_QA_TABLE)
            {
                ContactsQATimeTableViewController* detailViewController = [[ContactsQATimeTableViewController alloc] initWithNibName:@"ContactsQATimeTableViewController" bundle:nil];
             //   NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
              //  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                [self changeDetailViewController:detailViewController];
                self.detailViewController = detailViewController;
               // [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
                UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
                if(orientation == 0)
                    orientation = self.detailViewController.interfaceOrientation;;
                
                if(UIDeviceOrientationIsPortrait(orientation))
                {
                    
                    [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
                }

                [self.popoverController dismissPopoverAnimated:YES];
                
            }
            else
            {
                
                ContactsViewController * detailViewController = [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil];
             //   NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
              //  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                [self changeDetailViewController:detailViewController];
                
                detailViewController.rootPopoverButtonItem = self.rootPopoverButtonItem;
                self.detailViewController = detailViewController;
                
                
				//    ContactsViewController* contactDetailView = (ContactsViewController*) self.detailViewController;
				detailViewController.selectedContactOption = indexPath.row;
                [self.popoverController dismissPopoverAnimated:YES];
				[detailViewController launchMailComposer];
            }
        }
            break;
            
        case ACCESS_ACADEMY_INDEX:
        {
            MyTreeNode *node = [[treeNode flattenElements] objectAtIndex:indexPath.row + 1];
            
            int levelDepth = [node levelDepth];
            
        
            if (!node.hasChildren) 
            {
              //   NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
                int index = indexPath.row;
                if(indexPath.row >= FLASH_CARD_PROSPECT && indexPath.row <= FLASH_CARD_PRODUCER && levelDepth == 2)
                {
                
                FlashCardsViewController* detailViewController = [[FlashCardsViewController alloc] initWithNibName:@"FlashCardsViewController" bundle:nil];
               
             
                switch(indexPath.row)
                {
                    case FLASH_CARD_PROSPECT:
                        detailViewController.selectedFlashCard = 0;
                        break;
                    case FLASH_CARD_ZERO_PRODUCER:
                        detailViewController.selectedFlashCard = 1;
                        break;
                    case FLASH_CARD_PRODUCER:
                        detailViewController.selectedFlashCard = 2;
                        break;
                    
                        
                }
             //   self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                    
                    [self changeDetailViewController:detailViewController];
                self.detailViewController = detailViewController;
                }
                else if((indexPath.row == TRAINING_VIDEO || indexPath.row == TRAINING_VIDEO_EXPANDED) && levelDepth == 1)
                {
                    TrainingVideoViewController* detailViewController  = [[TrainingVideoViewController alloc] initWithNibName:@"TrainingVideoViewController" bundle:nil];
                    
                  //  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                    
                    [self changeDetailViewController:detailViewController];
                    self.detailViewController = detailViewController;
                    
                }
                [self.popoverController dismissPopoverAnimated:YES];
                UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
                if(orientation == 0)
                    orientation = self.detailViewController.interfaceOrientation;;
                
                if(UIDeviceOrientationIsPortrait(orientation))
                {
                  
                    [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
                }
            }
            else
            {
            node.inclusive = !node.inclusive;	
            [treeNode flattenElementsWithCacheRefresh:YES];
            [tableView reloadData];
            }
            
        }
            break;
            
        default:
            break;
    }
	
    
	
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
	
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    if (!sectionInfo.headerView) {
		NSString *playName = sectionInfo.sectionName;
        BOOL isDisclosure = FALSE;
        if(section == VISIT_APP_INDEX || section == CONTACTS_OPTIONS_INDEX || section == ACCESS_ACADEMY_INDEX)
            isDisclosure = TRUE;
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(4.0, 4.0, 315, SECTION_HEADER_HEIGHT+4) title:playName section:section displayDisclosure:isDisclosure delegate:self];
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
    BOOL closePopOver = FALSE;
    
    switch (sectionOpened) {
        case VISIT_APP_INDEX:
        {
		/*	VisitApplicationViewController *detailViewController = [[VisitApplicationViewController alloc] initWithNibName:@"VisitApplicationViewController" bundle:nil];
            NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
            self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
			self.detailViewController = detailViewController;
            detailViewController.pc = self.popoverController;
         */
            
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
          //  NSArray* viewControllerArr =   [ self.mgSplitViewController viewControllers ];
           // self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
           
            
            detailViewController.titleLabel.text = @"HOME SCREEN";
            
           //  [self changeDetailViewController:detailViewController];
			
            self.detailViewController = detailViewController;
            
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);

        }
            break;
        case APPOINTMENTAPP_INDEX:
        {
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
         //   NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
          //  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
            [self changeDetailViewController:detailViewController];
            detailViewController.titleLabel.text = @"APPOINTMENT APPLICATION";
			
            self.detailViewController = detailViewController;

            closePopOver = TRUE;
           // [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
        }
            break;
        case PROSPECT_APP_INDEX:
        {
            ProspectApplicationViewController* detailViewController = [[ProspectApplicationViewController alloc] initWithNibName:@"ProspectApplicationViewController" bundle:nil];
      //      NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
       //     self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
            [self changeDetailViewController:detailViewController];
             
			
            self.detailViewController = detailViewController;

            closePopOver = TRUE;
        }
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
      //      NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
        //    self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
          //  [self changeDetailViewController:detailViewController];
            detailViewController.titleLabel.text = @"CONTACTS";
			
            self.detailViewController = detailViewController;
           self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);

            break;
        }
        case FEATURES_AND_BENEFITS_INDEX:
        {
			//[self.splitViewController.viewControllers]
            
            FeaturesAndBenefitsViewController * detailViewController = [[FeaturesAndBenefitsViewController alloc] initWithNibName:@"FeaturesAndBenefitsViewController" bundle:nil];
     //       NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
       //     self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
            [self changeDetailViewController:detailViewController];
			
            self.detailViewController = detailViewController;
            closePopOver = TRUE;
        }
            break;
        case ACCESS_ACADEMY_INDEX:
        {
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
        //    NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
        //    self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
          //  [self changeDetailViewController:detailViewController];
            
             detailViewController.titleLabel.text = @"ACCESS ACADEMY";
			
            self.detailViewController = detailViewController;

        }
            break;
            
        case GPS_INDEX:
        {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString: @"http://maps.google.com/"]];
            closePopOver = TRUE;
        }
            break;
            
            
        default:
            break;
    }
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;//[[UIDevice currentDevice] orientation];
    
   // if(orientation == 0)
   //     orientation = self.detailViewController.interfaceOrientation;
    
    if(UIDeviceOrientationIsPortrait(orientation))
    {
	
		[self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
        	
    }
    else
        [self.detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    if(closePopOver)
        [self.popoverController dismissPopoverAnimated:YES];

    
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
    
     self.contentSizeForViewInPopover = CGSizeMake(320.0, 600);
    
}


////MGSplitViewDelegate
#pragma mark -
#pragma mark Split view support


- (void)splitViewController:(MGSplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController: (UIPopoverController*)pc
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
    barButtonItem.title = @"Menu";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.mgSplitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];

}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(MGSplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.mgSplitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
    
    

    
 
}


- (void)splitViewController:(MGSplitViewController*)svc 
		  popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willChangeSplitOrientationToVertical:(BOOL)isVertical
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)splitViewController:(MGSplitViewController*)svc willMoveSplitToPosition:(float)position
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (float)splitViewController:(MGSplitViewController *)svc constrainSplitPosition:(float)proposedPosition splitViewSize:(CGSize)viewSize
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	return proposedPosition;
}


-(void) changeDetailViewController:(BaseDetailViewController *)detailViewController
{
    NSArray* viewControllerArr =   [ self.mgSplitViewController viewControllers ];
    self.mgSplitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
    detailViewController.splitviewcontroller = self.mgSplitViewController;
}
@end
