//
//  VideosTableViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VideosTableViewController.h"

#import "VideoViewController.h"

#import "LabelGridViewCell.h"

#import "ASIHTTPRequest.h"

#import "HTTPOperationController.h"

@implementation VideosTableViewController

@synthesize videos=_videos;

@synthesize tableView=_tableView;

@synthesize toolBar=_toolBar;

@synthesize gridView=_gridView;


-(NSString *) urlencode: (NSString *) url
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@" ",nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%20",nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [url mutableCopy];
    
    int i;
    for(i = 0; i < len; i++)
    {
        
        [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *out = [NSString stringWithString: temp];
   // out = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return out;
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
	self.baseToolbar = self.toolBar;
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//	self.videos = [NSArray arrayWithObjects:@"https://uatwww.access.com/test/intro_to_c4.mp4", @"https://uatwww.access.com/test/Intro_to_Claims_Assignor_(5-2-11).mp4", @"https://uatwww.access.com/test/Intro_to_ImageRight_(5-2-11).mp4", nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(getVideosSuccess:)
												 name:@"Get Videos Success"
											   object:nil];
	self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	[self.gridView reloadData];
    
    [[HTTPOperationController sharedHTTPOperationController] getTrainingVideos];
}
-(void) getVideosSuccess:(NSNotification*) notification
{
    NSArray *arr = [notification object];
    
    self.videos = [NSMutableArray arrayWithArray:arr];
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
    NSLog(@"%@",[self.videos objectAtIndex:index]);
	NSURL *url = [NSURL URLWithString:[self urlencode:[[self.videos objectAtIndex:index] valueForKey:@"url"]]];
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
    LabelGridViewCell * cell = (LabelGridViewCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[LabelGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 144.0, 123.0) reuseIdentifier: CellIdentifier];
    }
	UIImage *image = [UIImage imageNamed:@"video_icon.png"];
	NSDictionary *dict = [self.videos objectAtIndex:index];
	cell.label.text = [dict valueForKey:@"title"];
	[cell setIcon:image];
    
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    return CGSizeMake(144.0, 123.0);
}


@end
