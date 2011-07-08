//
//  ProducerPhoneNumberTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProducerPhoneNumberTableViewCell : UITableViewCell


@property (nonatomic, strong) IBOutlet UITextField *phoneNumberTextField;
@property (nonatomic, strong) IBOutlet UITextField *typeTextField;
@property (nonatomic, strong) IBOutlet UIButton *typeButton;

@end
