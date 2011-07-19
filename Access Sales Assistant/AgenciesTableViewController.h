//
//  AgenciesTableViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@class BaseDetailViewController;

@interface AgenciesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, ASIHTTPRequestDelegate>

@property (strong, nonatomic) IBOutlet BaseDetailViewController *detailViewController;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
