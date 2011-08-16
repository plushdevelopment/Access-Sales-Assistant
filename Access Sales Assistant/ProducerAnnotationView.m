//
//  ProducerAnnotationView.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProducerAnnotationView.h"

@implementation ProducerAnnotationView

@synthesize numberLabel=_numberLabel;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super init];
	if (self != nil) {
		[self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, 32.0, 36.0)];
		self.numberLabel = [[UILabel alloc] init];
		self.image = [UIImage imageNamed:@"red_square_pin.png"];
		[self addSubview:self.numberLabel];
		[self.numberLabel setFrame:CGRectMake(self.frame.origin.x + 4.0, self.frame.origin.y + 4.0, 24.0, 17.0)];
		[self.numberLabel setAdjustsFontSizeToFitWidth:YES];
		[self.numberLabel setMinimumFontSize:10.0];
		self.numberLabel.textColor = [UIColor blackColor];
		self.numberLabel.backgroundColor = [UIColor clearColor];
		self.numberLabel.textAlignment = UITextAlignmentCenter;
		NSLog(@"%f, %f, %f, %f", self.frame.origin.x, self.frame.origin.y, self.frame.size.height, self.frame.size.width);
		NSLog(@"%f, %f, %f, %f", self.numberLabel.frame.origin.x, self.numberLabel.frame.origin.y, self.numberLabel.frame.size.height, self.numberLabel.frame.size.width);
		[self setCenterOffset:CGPointMake(0.0, -18.0)];
	}
	return self;
}

- (void)setNumber:(NSUInteger)number
{
	self.numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

@end
