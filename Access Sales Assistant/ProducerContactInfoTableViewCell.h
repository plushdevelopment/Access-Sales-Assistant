//
//  ProducerContactInfoTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
#import "BaseDetailViewController.h"
@interface ProducerContactInfoTableViewCell : PRPNibBasedTableViewCell

@property(nonatomic,strong) IBOutlet BaseTextField* phone1TextField;
@property(nonatomic,strong) IBOutlet BaseTextField* faxTextField;
@property(nonatomic,strong) IBOutlet BaseTextField* mainMailTextField;
@property(nonatomic,strong) IBOutlet BaseTextField* claimsMailTextField;
@property(nonatomic,strong) IBOutlet BaseTextField* acctMailTextField;
@property(nonatomic,strong) IBOutlet BaseTextField* custServMailTextField;
@property(nonatomic,strong) IBOutlet BaseTextField* webAddrTextField;



@end
