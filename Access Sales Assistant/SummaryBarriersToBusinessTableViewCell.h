//
//  SummaryBarriersToBusinessTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"

@interface SummaryBarriersToBusinessTableViewCell : PRPNibBasedTableViewCell


@property (nonatomic, strong) IBOutlet UITextField *barrierToBusinessTextField;
@property (nonatomic, strong) IBOutlet UIButton *barrierToBusinessButton;


@end
