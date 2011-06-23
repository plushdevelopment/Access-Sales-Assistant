//
//  PhasesViewController.m
//  Sales Templates
//
//  Created by Michael Cantrell on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhasesViewController.h"


@implementation PhasesViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Load html content
	NSString *contentFile;
	switch (self.view.tag) {
		case 1:
			contentFile = @"Phase1Content";
			break;
		case 2:
			contentFile = @"Phase2Content";
			break;
		case 3:
			contentFile = @"Phase3Content";
			break;
		case 4:
			contentFile = @"Phase4Content";
			break;
		default:
			NSLog(@"Invalid Phase View Tag -- Cannot load content file");
			contentFile = @"";
	}
	[pageContentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:contentFile ofType:@"html"]isDirectory:NO]]];
	
	UIScrollView *scrollView = (UIScrollView *)self.view;
	scrollView.contentSize = contentView.frame.size;
	[scrollView addSubview:contentView];
	
	// Add scroll images to the header and footer of scroll
	NSString *headerImageName, *footerImageName;
	switch (scrollView.tag) {
		case 1:
			headerImageName = @"";
			footerImageName = @"phase-two-pull.png";
			break;
		case 2:
			headerImageName = @"phase-one-pull-up.png";
			footerImageName = @"phase-three-pull.png";
			break;
		case 3:
			headerImageName = @"phase-two-pull-up.png";
			footerImageName = @"phase-four-pull.png";
			break;
		case 4:
			headerImageName = @"phase-three-pull-up.png";
			footerImageName = @"";
			break;
		default:
			break;
	}
	UIImageView *headerImageView, *footerImageView;
	if (![headerImageName isEqualToString:@""]) {
		headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:headerImageName ofType:nil]]];
		headerImageView.frame = CGRectMake(0, -66, 827, 66);
		[scrollView addSubview:headerImageView];
		[headerImageView release];
	}
	if (![footerImageName isEqualToString:@""]) {
		footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:footerImageName ofType:nil]]];
		footerImageView.frame = CGRectMake(0, scrollView.contentSize.height, 827, 66);
		[scrollView addSubview:footerImageView];
		
		UIView *bgcolorView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollView.contentSize.height+66, 827, 300)];
		[bgcolorView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"little-gray-box.png"]]];
		[bgcolorView setOpaque:NO];
		[scrollView addSubview:bgcolorView];
		
		[bgcolorView release];
		[footerImageView release];
	}
}

- (void)locationError:(NSError *)error {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		return YES;
	}
	return NO;
}


- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[contentView release];
	[pageContentWebView release];
	
    [super dealloc];
}

@end
