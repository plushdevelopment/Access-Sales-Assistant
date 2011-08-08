//
//  VideosTableViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@interface VideosTableViewController : BaseDetailViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *videos;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) IBOutlet UIToolbar* toolBar;

@end
