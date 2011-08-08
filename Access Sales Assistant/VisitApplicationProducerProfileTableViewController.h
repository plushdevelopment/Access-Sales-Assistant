//
//  VisitApplicationProducerProfileTableViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProducerGeneralTableViewCell.h"
@interface VisitApplicationProducerProfileTableViewController : UITableViewController
{
    NSArray* sectionTitleArray;
}


-(UITableViewCell*) tableViewCellForNibName:(NSString*)nibName;
@end
