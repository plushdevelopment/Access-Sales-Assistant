//
//  VisitTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPNibBasedTableViewCell.h"

@interface VisitTableViewCell : PRPNibBasedTableViewCell




@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *visitNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *producerNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *iconButton;


@end
