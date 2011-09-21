//
//  VisitApplicationAUNTKViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@interface VisitApplicationAUNTKViewController : BaseDetailViewController <UITableViewDataSource, UITableViewDelegate>




@property (nonatomic, strong) Producer *detailItem;
@property (nonatomic, strong) AUNTK *auntk;
@property (nonatomic, strong) NSArray *productionData;
@property (nonatomic, strong) NSArray *lossRatioData;
@property (strong, nonatomic) IBOutlet UITableView *productionTableView;
@property (strong, nonatomic) IBOutlet UITableView *lossRatioTableView1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (nonatomic, strong) UIPopoverController *aPopoverController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITableView *lossRatioTableView2;
@property (strong, nonatomic) UINib *productionTableViewCellNib;
@property (strong, nonatomic) UINib *lossRatioTableViewCell1Nib;
@property (strong, nonatomic) UINib *lossRatioTableViewCell2Nib;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSString* titleText;

- (void)configureView;
- (IBAction)dismiss:(id)sender;

@end
