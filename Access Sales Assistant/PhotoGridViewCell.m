//
//  PhotoGridViewCell.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoGridViewCell.h"

@implementation PhotoGridViewCell

@synthesize iconView=_iconView;
@synthesize deleteButton=_deleteButton;

- (id) initWithFrame: (CGRect) frame reuseIdentifier:(NSString *) reuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: reuseIdentifier];
    if ( self == nil )
        return ( nil );
	
	[self.contentView setBackgroundColor:[UIColor clearColor]];
    
    _iconView = [[UIImageView alloc] initWithFrame: CGRectMake(0.0, 10.0, 134.0, 134.0)];
    [self.contentView addSubview: _iconView];
	
	_deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(114.0, 0.0, 30.0, 30.0)];
	[_deleteButton setImage:[UIImage imageNamed:@"red x.png"] forState:UIControlStateNormal];
	[_deleteButton setImage:[UIImage imageNamed:@"red x.png"] forState:UIControlStateHighlighted];
	[_deleteButton setImage:[UIImage imageNamed:@"red x.png"] forState:UIControlStateSelected];
    [self.contentView addSubview:_deleteButton];
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
