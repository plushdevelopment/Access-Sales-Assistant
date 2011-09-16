//
//  TeamWithCountGridViewCell.h
//  Fan Scan
//
//  Created by Ross Chapman on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AQGridViewCell.h"

@interface LabelGridViewCell : AQGridViewCell {
	
	UIImageView * _iconView;
	UILabel *_label;
}

@property (nonatomic, retain) UIImage * icon;
@property (nonatomic, retain) UILabel *label;

@end
