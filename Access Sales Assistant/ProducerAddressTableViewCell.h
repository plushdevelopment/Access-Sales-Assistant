//
//  ProducerAddressTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProducerAddressTableViewCell : UITableViewCell


@property (nonatomic, strong) IBOutlet UITextField *streetAddress1TextField;
@property (nonatomic, strong) IBOutlet UITextField *streetAddress2TextField;
@property (nonatomic, strong) IBOutlet UITextField *cityTextField;
@property (nonatomic, strong) IBOutlet UITextField *stateTextField;
@property (nonatomic, strong) IBOutlet UITextField *zipTextField;
@property (nonatomic, strong) IBOutlet UIButton *stateButton;

@end
