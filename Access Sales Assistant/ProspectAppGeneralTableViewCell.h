//
//  ProspectAppGeneralTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PRPNibBasedTableViewCell.h"
@interface ProspectAppGeneralTableViewCell : PRPNibBasedTableViewCell

@property (nonatomic,strong) IBOutlet UITextField *producerNameField;
@property (nonatomic,strong) IBOutlet UITextField *tsmNameField;
@property (nonatomic,strong) IBOutlet UITextField *subTerritoryField;
@property (nonatomic,strong) IBOutlet UITextField *sourceField;

@end
