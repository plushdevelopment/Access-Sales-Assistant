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
    
//    self.dataSource = 
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
    NSLog(searchText);	
    [_tableData removeAllObjects];// remove all data that belongs to previous search
    NSInteger counter = 0;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@" argumentArray:[NSArray arrayWithObject:searchText]];
    
    NSArray *fetchedArray = [_dataSource filteredArrayUsingPredicate:pred];
    
    
   /* for(int index = 0; index<[_dataSource count];index++)
    {
        NSString *name = [[_dataSource objectAtIndex:index] name];
        NSLog(name);
     
        NSRange r = [name rangeOfString:searchText];
        if(r.location != NSNotFound)
        {
            if(r.location== 0)//that is we are checking only the start of the names.
            {
                [_tableData addObject:name];
            }
        }
        counter++;
    
    }*/
    [_tableView reloadData];
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
   
   // int count =[_dataSource count];
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
        //      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]];
    }
  
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSString* str= [[NSString alloc] initWithFormat:@"%@",[[_tableData objectAtIndex:indexPath.row] name]] ;
        cell.textLabel.text = str;
    }
    else
    {
    NSString* str= [[NSString alloc] initWithFormat:@"%@",[[_dataSource objectAtIndex:indexPath.row] name]] ;
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
        NSLog(@"selected %@",[[_tableData objectAtIndex:indexPath.row] name]);
         [_delegate selectedOption:[[_tableData objectAtIndex:indexPath.row] name] :_currentIndexPath :self.currentTag];
    }
    else
    {
        NSLog(@"current indexpath:%d",indexPath.row);
        NSLog(@"selected %@",[[_dataSource objectAtIndex:indexPath.row] name]);
        [_delegate selectedOption:[[_dataSource objectAtIndex:indexPath.row] name] :_currentIndexPath :self.currentTag];
        
    }
    [self dismissModalViewControllerAnimated:YES];
   
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    for(int index = 0; index<[_dataSource count];index++)
    {
        NSString *name = [[_dataSource objectAtIndex:index] name];
        NSLog(name);
        
        
        NSComparisonResult result = [name compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame)
        {
            [_tableData addObject:[_dataSource objectAtIndex:index]];
        }

      /*  NSRange r = [name rangeOfString:searchString];
        if(r.location != NSNotFound)
        {
            if(r.location== 0)//that is we are checking only the start of the names.
            {
                [_tableData addObject:name];
            }
        }*/
        //counter++;
        
    }
  /*  NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@" argumentArray:[NSArray arrayWithObject:searchString]];
    
    NSArray *fetchedArray = [_dataSource filteredArrayUsingPredicate:pred];
    
    NSLog(@"Filtered Array:%@",fetchedArray);*/
    
    return YES;
}
-(IBAction)closeAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
