//
//  ProducerContactInfoTableViewCell.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
@interface ProducerContactInfoTableViewCell : PRPNibBasedTableViewCell

@property(nonatomic,strong) IBOutlet UITextField* phone1TextField;
@property(nonatomic,strong) IBOutlet UITextField* faxTextField;
@property(nonatomic,strong) IBOutlet UITextField* mainMailTextField;
@property(nonatomic,strong) IBOutlet UITextField* claimsMailTextField;
@property(nonatomic,strong) IBOutlet UITextField* acctMailTextField;
@property(nonatomic,strong) IBOutlet UITextField* custServMailTextField;
@property(nonatomic,strong) IBOutlet UITextField* webAddrTextField;



@end
