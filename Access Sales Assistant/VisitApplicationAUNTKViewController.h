//
//  VisitApplicationAUNTKViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"
#import "PCLineChartView.h"

@class Producer;
@class AUNTK;

@interface VisitApplicationAUNTKViewController : BaseDetailViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) Producer *detailItem;
@property (nonatomic, strong) AUNTK *auntk;
@property (strong, nonatomic) IBOutlet UITableView *productionTableView;
@property (strong, nonatomic) IBOutlet UITableView *lossRatioTableView1;
@property (strong, nonatomic) IBOutlet PCLineChartView *lossRatioLineChartView;
@property (strong, nonatomic) IBOutlet PCLineChartView *claimFrequencyLineChartView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *dismissButton;
@property (nonatomic, strong) UIPopoverController *aPopoverController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITableView *lossRatioTableView2;
@property (strong, nonatomic) UINib *productionTableViewCellNib;
@property (strong, nonatomic) UINib *lossRatioTableViewCell1Nib;
@property (strong, nonatomic) UINib *lossRatioTableViewCell2Nib;

- (void)configureView;
- (IBAction)dismiss:(id)sender;

@end
