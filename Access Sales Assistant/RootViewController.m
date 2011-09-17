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
#import "ContactQAFormView.h"
#import "MyTreeViewCell.h"
#import "SplashViewController.h"
#import "FlashCardsViewController.h"
#import "TrainingVideoViewController.h"
#import "ProspectApplicationViewController.h"
#import "ContactsQATimeTableViewController.h"
#import "VisitApplicationMapViewController.h"
#import "VideosTableViewController.h"
#import "ContactsQAFormViewController.h"
#import "ProspectApplicationTableViewController.h"
#import "SearchProducerViewController.h"
#import "HTTPOperationController.h"


#define SECTION_HEADER_HEIGHT       48
#define VISIT_APPLICATION_DAYS      @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil
#define CONTACT_OPTIONS             @"Email Sales Compliance",@"Email Customer Service",@"Email Insufficient Funds",@"Email Product",@"Email QA Form",@"Email Facilities",@"Quality Assurance Timetable",@"Email Help Desk",nil
#define SECTION_TITLES              @"Visit Application",@"Prospect Application",@"Features & Benefits",@"Access Academy",@"Contacts",@"GPS",@"Search Producer",@"Total Access",nil

#define SOCIAL_MEDIA_OPTIONS @"Access.com",@"LinkedIn",@"Twitter",@"Facebook",@"Career Builder",nil
#define SOCIAL_MEDIA_IMAGE_NAME @"access_icon.png",@"linkedin_icon.png",@"twitter_icon.png",@"facebook_icon.png",@"career_builder_icon.png",nil
#define SOCIAL_MEDIA_URL @"http://www.access.com",@"http://www.linkedin.com/company/54125",@"http://www.twitter.com/AccessOnTheGo",@"http://www.facebook.com/AccessInsuranceCompany",@"http://www.accessgeneral.com/jobs",nil

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
	//if ([[[HTTPOperationController sharedHTTPOperationController] networkQueue] requestsCount] == 0) {
		NSArray *producersArray = [Producer findAllSortedBy:@"nextScheduledVisit" ascending:YES];
		NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:[producersArray count]];
		for (Producer *producer in producersArray) {
			if (![daysArray containsObject:producer.nextScheduledVisitDate] && (producer.nextScheduledVisitDate != nil)) {
				[daysArray addObject:producer.nextScheduledVisitDate];
			}
		}
		visitApplicationDaysArray = [NSArray arrayWithArray:daysArray];
		//visitApplicationDaysArray = [[NSSet setWithArray:[[Producer findAllSortedBy:@"nextScheduledVisit" ascending:YES] valueForKeyPath:@"nextScheduledVisitDate"]] allObjects];
		[self.tableView reloadData];
		//}
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
    
	self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);
	
    // Set up default values.
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
    return YES;
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
        else if(section == SOCIAL_MEDIA_INDEX)
            rowsCount = [sectionSocialMediaArray count];
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
			VisitApplicationMapViewController *detailViewController = [[VisitApplicationMapViewController alloc] initWithNibName:@"VisitApplicationMapViewController" bundle:nil];
            [self changeDetailViewController:detailViewController];
			self.detailViewController = detailViewController;
			
            [self displayTopMenuItem];
			[self.popoverController dismissPopoverAnimated:YES];
            [detailViewController setSelectedDay:[visitApplicationDaysArray objectAtIndex:indexPath.row]];
		}
            break;
        case CONTACTS_OPTIONS_INDEX:
        {
            if(indexPath.row == 4)
            {
                
                //LoginViewController *viewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                
                ContactsQAFormViewController *detailViewController = [[ContactsQAFormViewController alloc] initWithNibName:@"ContactsQAFormViewController" bundle:nil];
                [detailViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
                [detailViewController setModalPresentationStyle:UIModalPresentationFormSheet];
                [self presentModalViewController:detailViewController animated:YES];
				
				//    ContactQAFormView *detailViewController = [[ContactQAFormView alloc] initWithNibName:@"ContactQAFormView" bundle:nil];
				//      NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
				//    self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
				/*   ContactsQAFormViewController *detailViewController = [[ContactsQAFormViewController alloc] initWithNibName:@"ContactsQAFormViewController" bundle:nil];
				 
				 [self changeDetailViewController:detailViewController];
				 self.detailViewController = detailViewController;
				 //  [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
				 
				 UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
				 if(orientation == 0)
				 orientation = self.detailViewController.interfaceOrientation;;
				 
				 if(UIDeviceOrientationIsPortrait(orientation))
				 {
				 
				 [self.detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
				 }*/
				
                [self.popoverController dismissPopoverAnimated:YES];
            }
            else if(indexPath.row == CONTACT_QA_TABLE)
            {
                ContactsQATimeTableViewController* detailViewController = [[ContactsQATimeTableViewController alloc] initWithNibName:@"ContactsQATimeTableViewController" bundle:nil];
				//   NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
				//  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                
                [self changeDetailViewController:detailViewController];
                self.detailViewController = detailViewController;
				
                [self displayTopMenuItem];
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
                    VideosTableViewController* detailViewController  = [[VideosTableViewController alloc] initWithNibName:@"VideosTableViewController" bundle:nil];
                    
					//  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
                    
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
            
            //self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);
			
        }
            break;
        case PROSPECT_APP_INDEX:
        {
			//    ProspectApplicationViewController* detailViewController = [[ProspectApplicationViewController alloc] initWithNibName:@"ProspectApplicationViewController" bundle:nil];
            
            ProspectApplicationTableViewController* detailViewController = [[ProspectApplicationTableViewController alloc] initWithNibName:@"ProspectApplicationTableViewController" bundle:nil];
            
            
			//   ProspectViewController* detailViewController = [[ProspectApplicationViewController alloc] initWithNibName:@"ProspectApplicationViewController" bundle:nil];
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
			//self.contentSizeForViewInPopover = CGSizeMake(320.0, 1024);
			
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
            
        case SEARCH_PRODUCER_INDEX:
        {
            SearchProducerViewController* detailViewController  = [[SearchProducerViewController alloc] initWithNibName:@"SearchProducerViewController" bundle:nil];
            
            //  self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
            
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
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;//[[UIDevice currentDevice] orientation];
    
	// if(orientation == 0)
	//     orientation = self.detailViewController.interfaceOrientation;
    
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
    
	//self.contentSizeForViewInPopover = CGSizeMake(320.0, 600);
    
}


////MGSplitViewDelegate
#pragma mark -
#pragma mark Split view support


- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
    barButtonItem.title = @"Menu";
    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
	
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	//NSLog(@"%@", NSStringFromSelector(_cmd));
	// Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    UIViewController <SubstitutableDetailViewController> *detailViewController = [self.splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}

/*
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
 */

-(void) changeDetailViewController:(BaseDetailViewController *)detailViewController
{
    
	//  BaseDetailViewController *det = (BaseDetailViewController*) [viewControllerArr objectAtIndex:1];
    CGRect rec = detailViewController.view.frame;
    rec.origin.y = 20;
    [detailViewController.view setFrame:rec];
    
    NSArray* viewControllerArr =   [ self.splitViewController viewControllers ];
    self.splitViewController.viewControllers = [NSArray arrayWithObjects:[viewControllerArr objectAtIndex:0],detailViewController,nil];
    
    BaseDetailViewController *det = (BaseDetailViewController*) [viewControllerArr objectAtIndex:1];
    CGRect rec1 = det.view.frame;
	
	// CGRect *rec = [(BaseDetailViewController*) [viewControllerArr objectAtIndex:1]].frame; 
    detailViewController.splitviewcontroller = self.splitViewController;
    
}
@end
