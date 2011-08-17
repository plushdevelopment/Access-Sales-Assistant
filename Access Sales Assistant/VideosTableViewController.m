//
//  VideosTableViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VideosTableViewController.h"

#import "VideoViewController.h"

#import "SpringBoardIconCell.h"

@implementation VideosTableViewController

@synthesize videos=_videos;

@synthesize tableView=_tableView;

@synthesize toolBar=_toolBar;

@synthesize gridView=_gridView;

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
	self.baseToolbar = self.toolBar;
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.videos = [NSArray arrayWithObjects:@"http://uatwww.access.com/test/intro_to_c4.mp4", @"http://uatwww.access.com/test/Intro_to_Claims_Assignor_(5-2-11).mp4", @"http://uatwww.access.com/test/Intro_to_ImageRight_(5-2-11).mp4", nil];
	
	self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	[self.gridView reloadData];
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

#pragma mark -
#pragma mark GridView Delegate


// Called after the user changes the selection
- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
	// Navigation logic may go here. Create and push another view controller.
    
	VideoViewController *detailViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
	// ...
	// Pass the selected object to the new view controller.
	[self.splitviewcontroller presentViewController:detailViewController animated:YES completion:NULL];
	NSURL *url = [NSURL URLWithString:[self.videos objectAtIndex:index]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[detailViewController.webView loadRequest:request];
}


- (void) gridView: (AQGridView *) gridView didDeselectItemAtIndex: (NSUInteger) index
{
	
}


// Called after animated updates finished
- (void) gridViewDidEndUpdateAnimation:(AQGridView *) gridView
{
	
}


#pragma mark -
#pragma mark GridView Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    return self.videos.count;
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * CellIdentifier = @"CellIdentifier";
    SpringBoardIconCell * cell = (SpringBoardIconCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[SpringBoardIconCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 144.0, 94.0) reuseIdentifier: CellIdentifier];
    }
	UIImage *image = [UIImage imageNamed:@"video_icon.png"];
	
	[cell setIcon:image];
    
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    return CGSizeMake(144.0, 144.0);
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.videos objectAtIndex:indexPath.row];
	
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
    
     VideoViewController *detailViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	[self.splitviewcontroller presentViewController:detailViewController animated:YES completion:NULL];
	NSURL *url = [NSURL URLWithString:[self.videos objectAtIndex:indexPath.row]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[detailViewController.webView loadRequest:request];
     
}

@end