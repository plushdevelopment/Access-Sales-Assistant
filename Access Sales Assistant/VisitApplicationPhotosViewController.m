//
//  VisitApplicationPhotosViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationPhotosViewController.h"

#import "Producer.h"

#import "ProducerImage.h"

#import "HTTPOperationController.h"

#import "PhotoGridViewCell.h"

#import "VisitApplicationProducerImageViewController.h"

@implementation VisitApplicationPhotosViewController

@synthesize detailItem=_detailItem;

@synthesize gridView=_gridView;

@synthesize images=_images;

@synthesize managedObjectContext=_managedObjectContext;

@synthesize parent=_parent;

@synthesize titleLabel = _titleLabel;

@synthesize titleText;

@synthesize deleteIndex=_deleteIndex;

- (IBAction)deletePhoto:(id)sender
{
	UIButton *button = (UIButton *)sender;
	ProducerImage *producerImage = [self.images objectAtIndex:button.tag];
	NSString *imageName = producerImage.imagePath;
	[[HTTPOperationController sharedHTTPOperationController] deleteImage:producerImage.imageName forProducer:self.detailItem.uid];
	[producerImage deleteInContext:self.managedObjectContext];
}

- (IBAction)dismiss:(id)sender
{
	[self.presentingViewController viewWillAppear:YES];
	[self dismissModalViewControllerAnimated:YES];
}

- (NSManagedObjectContext *)managedObjectContext
{
	if (_managedObjectContext == nil) {
		self.managedObjectContext = [NSManagedObjectContext defaultContext];
	}
	return _managedObjectContext;
}

- (void)getImageSuccess:(ASIHTTPRequest *)request
{
	[self.managedObjectContext refreshObject:self.detailItem mergeChanges:YES];
	self.images = self.detailItem.images.allObjects;
	[self.gridView reloadData];
}

- (void)postImageSuccess:(ASIHTTPRequest *)request
{
	[[HTTPOperationController sharedHTTPOperationController] getImagesForProducer:self.detailItem.uid];
}

- (void)deleteImageSuccess:(NSNotification*) notification
{
	[self configureView];
}

#pragma mark -
#pragma mark Detail item

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
	
	[[NSManagedObjectContext defaultContext] save];
		
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    titleText = [[NSString alloc]initWithFormat:@"%@ - %@",_detailItem.name,_detailItem.producerCode];  
}

- (void)configureView
{
	self.deleteIndex = self.detailItem.images.count;
	self.images = self.detailItem.images.allObjects;
	[self.gridView reloadData];
}

- (IBAction)uploadPhoto:(id)sender
{
	
}

#pragma mark -
#pragma mark Init

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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImageSuccess:) name:@"Get Image Successful" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postImageSuccess:) name:@"Post Image Successful" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteImageSuccess:) name:@"Delete Image Successful" object:nil];
	
	self.images = self.detailItem.images.allObjects;
	
	self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	self.gridView.autoresizesSubviews = YES;
	
	[self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[HTTPOperationController sharedHTTPOperationController] getImagesForProducer:self.detailItem.uid];
	self.images = self.detailItem.images.allObjects;
	[self.gridView reloadData];
    
     _titleLabel.text = titleText;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// Access the uncropped image from info dictionary
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	[[HTTPOperationController sharedHTTPOperationController] postImage:image forProducer:self.detailItem.uid];
	[self.tabBarController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark GridView Delegate


// Called after the user changes the selection
- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
	if (!self.detailItem) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select a producer from the menu" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alertView show];
	} else {
		[gridView deselectItemAtIndex:index animated:YES];
		if (index == self.images.count) {
			// Create image picker controller
			UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
			
			// Delegate is self
			imagePicker.delegate = self;
			
			[imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
			
			// Show image picker
			[self.tabBarController presentModalViewController:imagePicker animated:YES];
		} else {
			VisitApplicationProducerImageViewController *viewController = [[VisitApplicationProducerImageViewController alloc] initWithNibName:@"VisitApplicationProducerImageViewController" bundle:nil];
			ProducerImage *producerImage = [self.images objectAtIndex:index];
			NSString *imageName = producerImage.imagePath;
			UIImage *image = [UIImage imageWithContentsOfFile:imageName];
			[viewController.imageView setImage:image];
			[self.tabBarController presentModalViewController:viewController animated:YES];
		}
	}
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
	NSUInteger rows = 0;
	if (self.images.count < 3) {
		rows = self.images.count + 1;
	} else {
		rows = self.images.count;
	}
    return rows;
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
	/*
	static NSString * CellIdentifier = @"PhotoGridViewCell";
    PhotoGridViewCell * cell = (PhotoGridViewCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[PhotoGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 144.0, 123.0) reuseIdentifier: CellIdentifier];
    }
	UIImage *image;
	if (index == self.images.count) {
		image = [UIImage imageNamed:@"button-plus.png"];
		cell.textField.hidden = YES;
		cell.textField.text = @"";
	} else {
		ProducerImage *producerImage = [self.images objectAtIndex:index];
		NSString *imageName = producerImage.imagePath;
		image = [UIImage imageWithContentsOfFile:imageName];
		cell.textField.hidden = NO;
		cell.textField.text = [[self.images objectAtIndex:index] title];
	}
	[cell.textField setDelegate:self];
	[cell setIcon:image];
	*/
	
    static NSString * CellIdentifier = @"CellIdentifier";
    PhotoGridViewCell * cell = (PhotoGridViewCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[PhotoGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 144.0, 144.0) reuseIdentifier: CellIdentifier];
    }
	UIImage *image;
	if (index == self.images.count) {
		[cell.iconView setFrame:CGRectMake(0.0, 0.0, 144.0, 144.0)];
		[cell.deleteButton setHidden:YES];
		image = [UIImage imageNamed:@"button-plus.png"];
	} else {
		[cell.iconView setFrame:CGRectMake(0.0, 10.0, 134.0, 134.0)];
		[cell.deleteButton setHidden:NO];
		ProducerImage *producerImage = [self.images objectAtIndex:index];
		NSString *imageName = producerImage.imagePath;
		image = [UIImage imageWithContentsOfFile:imageName];
		cell.deleteButton.tag = index;
	}
	[cell.deleteButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
	[cell setIcon:image];
    
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    return CGSizeMake(144.0, 144.0);
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory
{
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documentPaths objectAtIndex:0];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	return YES;
}

@end
