//
//  AddRowTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRPNibBasedTableViewCell.h"
@interface AddRowTableViewCell : PRPNibBasedTableViewCell

@property(nonatomic,strong) IBOutlet UILabel *addRowType;
@property(nonatomic,strong) IBOutlet UIButton *addButton;
@property(nonatomic,strong) IBOutlet UIButton *editButton;
@property(nonatomic,strong) IBOutlet UILabel *delRowType;
@property(nonatomic) IBOutlet BOOL isContactsEdited;
@end
