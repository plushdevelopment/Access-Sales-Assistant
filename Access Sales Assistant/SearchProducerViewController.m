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
	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchProducerDone:) 
                                                 name:@"searchProducer"
                                               object:nil];
	
    [[HTTPOperationController sharedHTTPOperationController] searchProducer:searchBar.text];  
	
}

-(void) searchProducerDone:(NSNotification*) notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"searchProducer" object:nil];
    [producerNamesArray removeAllObjects];
    producerNamesArray = (NSMutableArray*) [notification object];
    if (producerNamesArray.count == 1) {
		NSDictionary* dict = [producerNamesArray lastObject];
		Producer *producer = [Producer findFirstByAttribute:@"uid" withValue:[dict valueForKey:@"uid"]];
		[_tabBarController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
		[_tabBarController setModalPresentationStyle:UIModalPresentationPageSheet];
		[self presentModalViewController:_tabBarController animated:YES];
        self.tabBarController.isVisitApp = FALSE;
		[_tabBarController setDetailItem:producer];
	}
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 80.0;
    
    return height;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [producerNamesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString* str= [[NSString alloc] initWithFormat:@"%@ - %@\n%@",[[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"producerCode"],[[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"name"],[[producerNamesArray objectAtIndex:indexPath.row] objectForKey:@"producerAddress"]];
    cell.textLabel.text = str;
    cell.textLabel.numberOfLines = 0;
	
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary* dict = [producerNamesArray objectAtIndex:indexPath.row];
    Producer *producer = [Producer findFirstByAttribute:@"uid" withValue:[dict valueForKey:@"uid"]];
    NSLog(@"Selected producer: %@",[producer jsonStringValue]);
	[_tabBarController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[_tabBarController setModalPresentationStyle:UIModalPresentationPageSheet];
    [self presentModalViewController:_tabBarController animated:YES];
	[_tabBarController setDetailItem:producer];
}

@end
