//
//  SummaryGeneralTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummaryGeneralTableViewCell : PRPNibBasedTableViewCell

@property (nonatomic, strong) IBOutlet UITextField *producerNameTextField;
@property (nonatomic, strong) IBOutlet UITextField *reportDateTextField;
@property (nonatomic, strong) IBOutlet UITextField *callTypeTextField;
@property (nonatomic, strong) IBOutlet UIButton *reportDateButton;

@end
