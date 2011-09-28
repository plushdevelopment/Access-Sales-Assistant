//
//  SearchProducerViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"

#import "VisitApplicationTabBarController.h"
@interface SearchProducerViewController : BaseDetailViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* producerNamesArray;
}


@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;
@property(nonatomic,strong) IBOutlet UISearchBar* searchBar;
@property(nonatomic,strong) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet VisitApplicationTabBarController *tabBarController;
@end
