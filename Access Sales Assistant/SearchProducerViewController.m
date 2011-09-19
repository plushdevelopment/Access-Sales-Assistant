//
//  SearchProducerViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchProducerViewController.h"

#import "HTTPOperationController.h"

#import "Producer.h"
#import "DailySummary.h"
@implementation SearchProducerViewController
@synthesize toolBar = _toolBar;
@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
@synthesize tabBarController = _tabBarController;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.baseToolbar = _toolBar;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
  //  [self showAlert:searchBar.text];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchProducerDone:) 
                                                 name:@"searchProducer"
                                               object:nil];
    
       
   // NSString* escapedString = parentCell.producerNameField.text;
    [[HTTPOperationController sharedHTTPOperationController] searchProducer:searchBar.text];  

}

-(void) searchProducerDone:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchProducer" object:nil];
    [producerNamesArray removeAllObjects];
    producerNamesArray = (NSMutableArray*) [notification object];
    
    NSString *strResults = [[NSString alloc] initWithFormat:@"searchProducer Array : %@",producerNamesArray];
    
    [self.tableView reloadData];
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
    
    
    NSString* str= [[NSString alloc] initWithFormat:@"%@ - %@",[[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"name"],[[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"producerCode"]] ;    cell.textLabel.text = str;

    // Configure the cell...
  /*  NSString *str= [array objectAtIndex:indexPath.row];
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
        cell.textLabel.textColor = RGB(0,0,0);*/
    
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
    
     NSDictionary* dict = [producerNamesArray objectAtIndex:indexPath.row];
    Producer *producer = [Producer findFirstByAttribute:@"uid" withValue:[dict valueForKey:@"uid"]];
    //Producer *producer = (Producer*)[Producer ai_objectForProperty:@"uid" value:[dict valueForKey:@"uid"] managedObjectContext:[NSManagedObjectContext defaultContext]];
    
        
	[_tabBarController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[_tabBarController setModalPresentationStyle:UIModalPresentationPageSheet];
	//[self.splitviewcontroller presentModalViewController:self.tabBarController animated:YES];
    [self presentModalViewController:_tabBarController animated:YES];
        self.tabBarController.isVisitApp = FALSE;
	[_tabBarController setDetailItem:producer];
}

@end
