//
//  LastVisitedTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
@interface LastVisitedTableViewCell : PRPNibBasedTableViewCell

@property (nonatomic,strong) IBOutlet UILabel *visitedLabel;
@property (nonatomic,strong) IBOutlet UITextView *summaryNotesTextView;

@end
