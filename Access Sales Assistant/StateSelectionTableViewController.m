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
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
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
    
    array = (NSMutableArray*)[tempArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    stateCodeArray = (NSMutableArray*)[tempStateCodeArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
}

@end
