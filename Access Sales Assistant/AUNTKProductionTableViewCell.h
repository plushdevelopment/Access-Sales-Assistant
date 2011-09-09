//
//  AUNTKProductionTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPNibBasedTableViewCell.h"

@interface AUNTKProductionTableViewCell : PRPNibBasedTableViewCell


@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;

@end
