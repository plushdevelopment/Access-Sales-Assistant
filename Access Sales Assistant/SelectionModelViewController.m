//
//  SelectionModelViewController.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectionModelViewController.h"

@implementation SelectionModelViewController


@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
@synthesize tableData = _tableData;
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

@synthesize  currentTag;
@synthesize currentIndexPath = _currentIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(void) assignDataSource:(NSMutableArray *)datasource
{
    if(_dataSource)
    {
        [_dataSource removeAllObjects];
    }
    if(_tableData)
    {
        [_tableData removeAllObjects];
    }
    self.dataSource =  [[NSMutableArray alloc] initWithArray:datasource];
    
    self.tableData = [[NSMutableArray alloc] initWithArray:datasource];
    
    [_tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_tableData removeAllObjects];
    [_tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    if(tableView == self.searchDisplayController.searchResultsTableView)
        return [_tableData count];
    else 
        return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSString* str= [[NSString alloc] initWithFormat:@"%@",[[_tableData objectAtIndex:indexPath.row] valueForKey:@"name"]] ;
        cell.textLabel.text = str;
    }
    else
    {
		NSString* str= [[NSString alloc] initWithFormat:@"%@",[[_dataSource objectAtIndex:indexPath.row] valueForKey:@"name"]] ;
        cell.textLabel.text = str;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSLog(@"current indexpath:%d",indexPath.row);
        NSLog(@"selected %@",[[_tableData objectAtIndex:indexPath.row] valueForKey:@"name"]);
        [_delegate selectedOption:[[_tableData objectAtIndex:indexPath.row] valueForKey:@"name"] didSelectRowAtIndexPath:_currentIndexPath forTag:self.currentTag];
    }
    else
    {
        NSLog(@"current indexpath:%d",indexPath.row);
        NSLog(@"selected %@",[[_dataSource objectAtIndex:indexPath.row] valueForKey:@"name"]);
        
        [_delegate selectedOption:[[_dataSource objectAtIndex:indexPath.row] valueForKey:@"name"] didSelectRowAtIndexPath:_currentIndexPath forTag:self.currentTag];
        
    }
    [self dismissModalViewControllerAnimated:YES];
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    for(int index = 0; index<[_dataSource count];index++)
    {
        NSString *name = [[_dataSource objectAtIndex:index] valueForKey:@"name"];
        
        NSComparisonResult result = [name compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame)
        {
            [_tableData addObject:[_dataSource objectAtIndex:index]];
        }
    }    
    return YES;
}
-(IBAction)closeAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
