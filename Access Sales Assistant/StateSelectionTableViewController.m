//
//  StateSelectionTableViewController.m
//  AccessSalesAssistantNewFeatures
//
//  Created by Easwara Reddy Illuri on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StateSelectionTableViewController.h"

@implementation StateSelectionTableViewController

@synthesize delegate = _delegate;
@synthesize currentSelectedState;

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
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

    isColorChanged = FALSE;
    selectedIndexPath =-1;
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(300.0, 500.0);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"States" ofType:@"plist"];
    
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:path];
    array = [NSMutableArray array];
    stateCodeArray = [NSMutableArray array];
    
    NSMutableArray *tempArray = (NSMutableArray*)[plistData allValues];
    NSMutableArray* tempStateCodeArray = (NSMutableArray*)[plistData allKeys];
    
    
    //[plistData allValues]
    array = (NSMutableArray*)[tempArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    stateCodeArray = (NSMutableArray*)[tempStateCodeArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    

 
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [array count];
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
    NSString *str= [array objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    
    if([str isEqualToString:self.currentSelectedState]&&!isColorChanged)
    {
        cell.textLabel.textColor = RGB(0,111,162);
        
        selectedIndexPath = indexPath.row;
        isColorChanged = TRUE;
    }
    else if(selectedIndexPath == indexPath.row)
    {
         cell.textLabel.textColor = RGB(0,111,162);
        
    }
    else
        cell.textLabel.textColor = RGB(0,0,0);
    
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
    if(self.delegate!=nil)
    {
        self.currentSelectedState = [array objectAtIndex:indexPath.row];
        selectedIndexPath = indexPath.row;
        [tableView reloadData];
        [self.delegate selectedState:[array objectAtIndex:indexPath.row] selectedStateCode:[stateCodeArray objectAtIndex:indexPath.row]];
    }
        //[self.delegate selectedState:[array objectAtIndex:indexPath.row]];
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
