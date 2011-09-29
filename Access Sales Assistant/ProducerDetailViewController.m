//
//  ProducerDetailViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerDetailViewController.h"
#import "Producer.h"
#import "ProducerImage.h"
#import "AddressListItem.h"
#import "PhoneListItem.h"
#import "State.h"

@implementation ProducerDetailViewController

@synthesize imageView=_imageView;
@synthesize name = _name;
@synthesize code = _code;
@synthesize street = _street;
@synthesize address = _address;

- (void)setProducer:(Producer *)producer
{
	ProducerImage *producerImage = [producer.images.allObjects lastObject];
	NSString *imageName = producerImage.imagePath;
	[self.imageView setImage:[UIImage imageWithContentsOfFile:imageName]];
	
	self.name.text = producer.name;
	self.code.text = producer.producerCode;
	for (AddressListItem *addressItem in producer.addresses) {
		if (addressItem.addressTypeValue == 3) {
			self.street.text = addressItem.addressLine1;
			self.address.text = [NSString stringWithFormat:@"%@, %@ %@", addressItem.city, addressItem.state.name, addressItem.postalCode];
		}
	}
	
	
}

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
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[self setImageView:nil];
	[self setName:nil];
	[self setCode:nil];
	[self setStreet:nil];
	[self setAddress:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
