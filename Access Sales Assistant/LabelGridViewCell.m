//
//  TeamWithCountGridViewCell.m
//  Fan Scan
//
//  Created by Ross Chapman on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LabelGridViewCell.h"

@implementation LabelGridViewCell

@synthesize label=_label;

- (id) initWithFrame: (CGRect) frame reuseIdentifier:(NSString *) reuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: reuseIdentifier];
    if ( self == nil )
        return ( nil );
	
	[self.contentView setBackgroundColor:[UIColor clearColor]];
    
    _iconView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 0.0, 144.0, 94.0)];
    [self.contentView addSubview: _iconView];
	
	_label = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 102.0, 144.0, 21.0)];
	[_label setBackgroundColor:[UIColor clearColor]];
	[_label setTextColor:[UIColor blackColor]];
	[_label setTextAlignment:UITextAlignmentCenter];
	[_label setMinimumFontSize:8.0];
	[_label setAdjustsFontSizeToFitWidth:YES];
	[self.contentView addSubview:_label];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView.opaque = NO;
    self.opaque = NO;
    
    return ( self );
}

- (CALayer *) glowSelectionLayer
{
    return ( _iconView.layer );
}

- (UIImage *) icon
{
    return ( _iconView.image );
}

- (void) setIcon: (UIImage *) anIcon
{
    _iconView.image = anIcon;
}

@end
