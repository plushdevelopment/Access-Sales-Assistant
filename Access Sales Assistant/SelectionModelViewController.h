//
//  SelectionModelViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString-Validation.h"
@protocol optionSelectedDelegate <NSObject>

-(void) selectedOption:(NSString*) selectedString:(NSIndexPath*) forIndexPath:(NSInteger) forTag;

@end

@interface SelectionModelViewController : UIViewController <UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;
@property(nonatomic,strong) IBOutlet UISearchBar* searchBar;
@property(nonatomic,strong) IBOutlet UITableView* tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *tableData;
@property (nonatomic,strong) NSMutableArray *searchData;

@property(nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic) NSInteger currentTag;

@property (nonatomic,assign) id<optionSelectedDelegate> delegate;

//@property (nonatomic,strong) IBOutlet UISearchDisplayController *searchDisplayController;
-(void) assignDataSource:(NSMutableArray*) datasource;
-(IBAction)closeAction:(id)sender;
@end
