//
//  VisitApplicationProducerProfileTableViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationProducerProfileTableViewController.h"
#import "ProducerQuestionTableViewCell.h"
#import "ProducerStatusTableViewCell.h"
#import "ProducerRaterTableViewCell.h"
#import "ProducerHoursTableViewCell.h"
#import "ProducerContactInfoTableViewCell.h"
#import "ProducerAddressTableViewCell.h"
#import "ProducerContactTableViewCell.h"

@implementation VisitApplicationProducerProfileTableViewController

#define PRODUCER_PROFILE_SECTIONS @"GENERAL",@"STATUS",@"RATER",@"COMPANY CONTACT INFO",@"HOURS OF OPERATION",@"ADDRESSES",@"CONTACTS",nil

enum producerProfileSectionIndex
{
    EGeneral = 0,
    EStatus,
    ERater,
    ECompanyContactInfo,
    EHoursOfOperation,
    EAddresses,
    EContacts
};

//@synthesize producerGeneralTableViewCell = _producerGeneralTableViewCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];
    
    sectionTitleArray = [[NSArray alloc] initWithObjects:PRODUCER_PROFILE_SECTIONS];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
            return 2;
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
  
            if(indexPath.row == 0)
            {
            ProducerGeneralTableViewCell* cell = [ProducerGeneralTableViewCell cellForTableView:tableView fromNib:[ProducerGeneralTableViewCell nib]];
            return cell;
            }
            else if(indexPath.row > 0)
            {
                ProducerQuestionTableViewCell* cell = [ProducerQuestionTableViewCell cellForTableView:tableView fromNib:[ProducerQuestionTableViewCell nib]];
                return cell;
            }
        }
        case EStatus:
        {
            ProducerStatusTableViewCell* cell = [ProducerStatusTableViewCell cellForTableView:tableView fromNib:[ProducerStatusTableViewCell nib]];
            return cell;
        }
        case ERater:
        {
            ProducerRaterTableViewCell* cell = [ProducerRaterTableViewCell cellForTableView:tableView fromNib:[ProducerRaterTableViewCell nib]];
            return cell;
        }
        case ECompanyContactInfo:
        {
            ProducerContactInfoTableViewCell* cell = [ProducerContactInfoTableViewCell cellForTableView:tableView fromNib:[ProducerContactInfoTableViewCell nib]];
            return cell;
        }
        case EHoursOfOperation:
        {
            ProducerHoursTableViewCell* cell = [ProducerHoursTableViewCell cellForTableView:tableView fromNib:[ProducerHoursTableViewCell nib]];
            return cell;
        }
        case EAddresses:
        {
            ProducerAddressTableViewCell* cell = [ProducerAddressTableViewCell cellForTableView:tableView fromNib:[ProducerAddressTableViewCell nib]];
            return cell;
        }
        case EContacts:
        {
            ProducerContactTableViewCell* cell = [ProducerContactTableViewCell cellForTableView:tableView fromNib:[ProducerContactTableViewCell nib]];
            return cell;
        }
            
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.0;
    switch (indexPath.section) {
        case EGeneral:
        {
            if(indexPath.row == 0)
                height = 188.0;
            else
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
