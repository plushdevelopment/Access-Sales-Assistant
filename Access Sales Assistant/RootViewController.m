//
//  RootViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "BaseDetailViewController.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"
#import "SectionHeaderView.h"
#import "MainViewSectionInfo.h"
#import "FeaturesAndBenefitsViewController.h"
#import "ContactsViewController.h"
#import "MyTreeViewCell.h"
#import "SplashViewController.h"
#import "FlashCardsViewController.h"
#import "ContactsQATimeTableViewController.h"
#import "VisitApplicationMapViewController.h"
#import "VideosTableViewController.h"
#import "ContactsQAFormViewController.h"
#import "ProspectApplicationTableViewController.h"
#import "SearchProducerViewController.h"
#import "HTTPOperationController.h"


#define SECTION_HEADER_HEIGHT       48
#define VISIT_APPLICATION_DAYS      @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil
#define CONTACT_OPTIONS             @"Email Sales Compliance",@"Email Customer Service",@"Email Insufficient Funds",@"Email Product",@"Quality Assurance Form",@"Email Facilities",@"Quality Assurance Timetable",@"Email Help Desk",nil
#define SECTION_TITLES              @"Daily Schedule",@"Add New Prospect",@"Features & Benefits",@"Training",@"Email Atlanta",@"Get Directions",@"Search Producer",@"Total Access",nil

#define SOCIAL_MEDIA_OPTIONS @"Access.com",@"LinkedIn",@"Twitter",@"Facebook",@"Career Builder",nil
#define SOCIAL_MEDIA_IMAGE_NAME @"access_icon.png",@"linkedin_icon.png",@"twitter_icon.png",@"facebook_icon.png",@"career_builder_icon.png",nil
#define SOCIAL_MEDIA_URL @"http://www.access.com",@"http://www.linkedin.com/company/54125",@"http://www.twitter.com/AccessOnTheGo",@"http://www.facebook.com/AccessInsuranceCompany",@"http://www.accessgeneral.jobs",nil

#define SECTION_ROW_COUNT           5,0,0,0,5,0,nil
#define VISIT_APP_INDEX             0
#define CONTACTS_OPTIONS_INDEX      4
#define PROSPECT_APP_INDEX          1
#define FEATURES_AND_BENEFITS_INDEX 2
#define ACCESS_ACADEMY_INDEX        3
#define GPS_INDEX                   5
#define SEARCH_PRODUCER_INDEX       6
#define SOCIAL_MEDIA_INDEX          7
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

- (void)producersSuccessful
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Producer"
											  inManagedObjectContext:[NSManagedObjectContext defaultContext]];
	[fetchRequest setEntity:entity];
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"nextScheduledVisit" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	NSArray *properties = [NSArray arrayWithObjects:@"nextScheduledVisitDate", nil];
	[fetchRequest setPropertiesToFetch:properties];
	NSError *error = nil;
	NSArray *producersArray = [[NSManagedObjectContext defaultContext] executeFetchRequest:fetchRequest error:&error];
	if (producersArray == nil) {
		NSLog(@"No producers found!");
	}
	NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:[producersArray count]];
	for (Producer *producer in producersArray) {
		if (![daysArray containsObject:producer.nextScheduledVisitDate] && (producer.nextScheduledVisitDate != nil)) {
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
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:[HTTPOperationController sharedHTTPOperationController] action:@selector(logout)];
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[HTTPOperationController sharedHTTPOperationController] action:@selector(refreshProducers)];
	self.navigationItem.leftBarButtonItem = logoutButton;
	self.navigationItem.rightBarButtonItem = refreshButton;
    
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);
	
    self.tableView.sectionHeaderHeight = SECTION_HEADER_HEIGHT;
    
    CGRect rectFrame = self.tableView.frame;
    
    [self.tableView setFrame:CGRectMake(0, 60, rectFrame.size.width, rectFrame.size.height)];
	
    self.tableView.backgroundColor = [UIColor blackColor];
    
    sectionTitlesArray = [[NSArray alloc] initWithObjects:SECTION_TITLES];
    _openSectionIndex = NSNotFound;
    
    sectionIdsArray = [NSMutableArray array];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(producersSuccessful) name:@"Producers Successful" object:nil];
	
	[self producersSuccessful];
	
    contactOptionsArray= [[NSArray alloc] initWithObjects:CONTACT_OPTIONS];
    
	sectionSocialMediaArray = [[NSArray alloc] initWithObjects:SOCIAL_MEDIA_OPTIONS];
    sectionSocialMediaImageArray = [[NSArray alloc] initWithObjects:SOCIAL_MEDIA_IMAGE_NAME];
    sectionSocialMediaUrlArray = [[NSArray alloc] initWithObjects:SOCIAL_MEDIA_URL];
    
    NSMutableArray* arrayInfo = [NSMutableArray array];
    for(int s =0; s<[sectionTitlesArray count];s++)
    {
        MainViewSectionInfo* tSectionInfo = [[MainViewSectionInfo alloc] init];
        tSectionInfo.sectionName = [sectionTitlesArray objectAtIndex:s];
        tSectionInfo.open = NO;     
        
        [arrayInfo addObject:tSectionInfo];
    }
    self.sectionInfoArray = arrayInfo;
    
    // Access Academy Tree Structure
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
    return YES;
}

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
        else if(section == SOCIAL_MEDIA_INDEX)
            rowsCount = [sectionSocialMediaArray count];
		else
			rowsCount =0;
        
        return rowsCount;
    }
    else 
        return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MainViewSectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    if(indexPath.section == ACCESS_ACADEMY_INDEX && sectionInfo.open) {
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
		
        
    } else	{
        
		
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			cell.backgroundView = [[CustomCellBackground alloc] init];
			cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
			((CustomCellBackground *)cell.selectedBackgroundView).selected = YES;
		}
		
		
		NSInteger section = indexPath.section;
		NSInteger row = indexPath.row;
        cell.imageView.image = nil;
		
		switch (section) {
			case VISIT_APP_INDEX:
            {
				cell.textLabel.text = [visitApplicationDaysArray objectAtIndex:row];
            }
				break;
			case CONTACTS_OPTIONS_INDEX:
            {
				cell.textLabel.text = [contactOptionsArray objectAtIndex:row];
            }
				break;
            case SOCIAL_MEDIA_INDEX:
            {
                cell.textLabel.text = [sectionSocialMediaArray objectAtIndex:row];
                cell.imageView.image = [UIImage imageNamed:[sectionSocialMediaImageArray objectAtIndex:row]];
            }
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
			VisitApplicationMapViewController *aDetailViewController = [[VisitApplicationMapViewController alloc] initWithNibName:@"VisitApplicationMapViewController" bundle:nil];
			self.detailViewController = aDetailViewController;
            [self changeDetailViewController:aDetailViewController];
            [self displayTopMenuItem];
			[self.popoverController dismissPopoverAnimated:YES];
            [aDetailViewController setSelectedDay:[visitApplicationDaysArray objectAtIndex:indexPath.row]];
		}
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            if(indexPath.row == 4)
            {
                
                ContactsQAFormViewController *detailViewController = [[ContactsQAFormViewController alloc] initWithNibName:@"ContactsQAFormViewController" bundle:nil];
                [detailViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                [detailViewController setModalPresentationStyle:UIModalPresentationFormSheet];
                [self presentModalViewController:detailViewController animated:YES];
				
							
                [self.popoverController dismissPopoverAnimated:YES];
            }
            else if(indexPath.row == CONTACT_QA_TABLE)
            {
                ContactsQATimeTableViewController* detailViewController = [[ContactsQATimeTableViewController alloc] initWithNibName:@"ContactsQATimeTableViewController" bundle:nil];
                
                [self changeDetailViewController:detailViewController];
                self.detailViewController = detailViewController;
				
                [self displayTopMenuItem];
                [self.popoverController dismissPopoverAnimated:YES];
                
            }
            else
            {
                
                ContactsViewController * detailViewController = [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil];
				                
                [self changeDetailViewController:detailViewController];
                
                detailViewController.rootPopoverButtonItem = self.rootPopoverButtonItem;
                self.detailViewController = detailViewController;
                
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
                    
                    [self changeDetailViewController:detailViewController];
					self.detailViewController = detailViewController;
                }
                else if((indexPath.row == TRAINING_VIDEO || indexPath.row == TRAINING_VIDEO_EXPANDED) && levelDepth == 1)
                {
                    VideosTableViewController* detailViewController  = [[VideosTableViewController alloc] initWithNibName:@"VideosTableViewController" bundle:nil];
                    
                    [self changeDetailViewController:detailViewController];
                    self.detailViewController = detailViewController;
                    
                }
                [self.popoverController dismissPopoverAnimated:YES];
                [self displayTopMenuItem];
            }
            else
            {
				node.inclusive = !node.inclusive;	
				[treeNode flattenElementsWithCacheRefresh:YES];
				[tableView reloadData];
            }
            
        }
            break;
        case SOCIAL_MEDIA_INDEX:
        {
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString: [sectionSocialMediaUrlArray objectAtIndex:indexPath.row]]];
            break;
        }
            
			
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
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(4.0, 2.0, 315, SECTION_HEADER_HEIGHT+2) title:playName section:section displayDisclosure:isDisclosure delegate:self];
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
    else if(sectionOpened == SOCIAL_MEDIA_INDEX)
        countOfRowsToInsert = [sectionSocialMediaArray count];
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
        else if(previousOpenSectionIndex == SOCIAL_MEDIA_INDEX)
            countOfRowsToDelete = [sectionSocialMediaArray count];
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
	
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    [self.tableView reloadData];
	self.openSectionIndex = sectionOpened;  
    
    BOOL closePopOver = FALSE;
    
    switch (sectionOpened) {
        case VISIT_APP_INDEX:
        {
			            
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
			
            
			
            
            detailViewController.titleLabel.text = @"HOME SCREEN";
			
            self.detailViewController = detailViewController;
			
        }
            break;
        case PROSPECT_APP_INDEX:
        {
            ProspectApplicationTableViewController* detailViewController = [[ProspectApplicationTableViewController alloc] initWithNibName:@"ProspectApplicationTableViewController" bundle:nil];
            
            [self changeDetailViewController:detailViewController];
			
			
            self.detailViewController = detailViewController;
			
            closePopOver = TRUE;
        }
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
            detailViewController.titleLabel.text = @"CONTACTS";
			
            self.detailViewController = detailViewController;
			
            break;
        }
        case FEATURES_AND_BENEFITS_INDEX:
        {
            FeaturesAndBenefitsViewController * detailViewController = [[FeaturesAndBenefitsViewController alloc] initWithNibName:@"FeaturesAndBenefitsViewController" bundle:nil];
            
            [self changeDetailViewController:detailViewController];
			
            self.detailViewController = detailViewController;
            closePopOver = TRUE;
        }
            break;
        case ACCESS_ACADEMY_INDEX:
        {
            SplashViewController* detailViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
            
			detailViewController.titleLabel.text = @"ACCESS ACADEMY";
			
            self.detailViewController = detailViewController;
			
        }
            break;
            
        case GPS_INDEX:
        {
            NSString *url = [NSString stringWithFormat:@"motionxgpsdrivehd://"];
            UIApplication *app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:url]];

            closePopOver = TRUE;
        }
            break;
            
        case SEARCH_PRODUCER_INDEX:
        {
            SearchProducerViewController* detailViewController  = [[SearchProducerViewController alloc] initWithNibName:@"SearchProducerViewController" bundle:nil];
            
            [self changeDetailViewController:detailViewController];
            self.detailViewController = detailViewController;
            
            closePopOver = TRUE;
            break;
        }
			
        default:
            break;
    }
    
	
    [self displayTopMenuItem];
    if(closePopOver)
        [self.popoverController dismissPopoverAnimated:YES];
	
    
}
-(void) displayTopMenuItem
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIDeviceOrientationIsPortrait(orientation))
    {
		
		[self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
		
    }
    else
        [self.detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
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
    
}



#pragma mark -
#pragma mark Split view support


- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc
{
    barButtonItem.title = @"Menu";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
	
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	// Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}

-(void) changeDetailViewController:(BaseDetailViewController *)detailViewController
{
		RootViewController *rootViewController = [[self.splitViewController viewControllers] objectAtIndex:0];
		self.splitViewController.viewControllers = [NSArray arrayWithObjects:rootViewController, detailViewController, nil];
	
		detailViewController.splitviewcontroller = self.splitViewController;
}
@end
