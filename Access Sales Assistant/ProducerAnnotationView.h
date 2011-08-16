//
//  ProducerAnnotationView.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface ProducerAnnotationView : MKAnnotationView

@property (nonatomic, strong) UILabel *numberLabel;

- (void)setNumber:(NSUInteger)number;

@end
