//
//  ProducerHoursTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
@interface ProducerHoursTableViewCell : PRPNibBasedTableViewCell {
	UITextField *_startTextField;
	UITextField *_stopTextField;
}


@property (nonatomic, strong) IBOutlet UILabel *weekdayLabel;
@property (nonatomic, strong) IBOutlet UITextField *startTextField;
@property (nonatomic, strong) IBOutlet UITextField *stopTextField;

@end
