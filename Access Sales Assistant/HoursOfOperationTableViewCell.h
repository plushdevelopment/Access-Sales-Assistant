//
//  HoursOfOperationTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoursOfOperationTableViewCell : UITableViewCell {
	UIButton *aButton;
	UIImageView *imageView;
}

@property (nonatomic, strong) IBOutlet UIButton *aButton;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
