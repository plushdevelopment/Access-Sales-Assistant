//
//  SelectionModelViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionModelViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;
@property(nonatomic,strong) IBOutlet UISearchBar* searchBar;
@property(nonatomic,strong) IBOutlet UITableView* tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSMutableArray *searchData;


-(void) AssignDataSource:(NSMutableArray*) datasource;
@end
