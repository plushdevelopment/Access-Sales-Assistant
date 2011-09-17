//
//  PhotoGridViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AQGridViewCell.h"

@interface PhotoGridViewCell : AQGridViewCell {
	UIImageView * _iconView;
	UIButton *_deleteButton;
}

@property (nonatomic, retain) UIImage * icon;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIButton *deleteButton;

@end
