//
//  ProspectAppContactTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
@interface ProspectAppContactTableViewCell : PRPNibBasedTableViewCell


@property(nonatomic,strong) IBOutlet UITextField* ownerFirstName;
@property(nonatomic,strong) IBOutlet UITextField* ownerLastName;
@property(nonatomic,strong) IBOutlet UITextField* primaryContactFirstName;
@property(nonatomic,strong) IBOutlet UITextField* primaryContactLastName;

@end
