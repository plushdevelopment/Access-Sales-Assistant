//
//  RootViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTreeNode.h"

@class  BaseDetailViewController;

@interface RootViewController : UITableViewController <UISplitViewControllerDelegate>
{
	NSMutableIndexSet *expandedSections;
    NSArray* sectionTitlesArray;
    NSArray* visitApplicationDaysArray;
    NSArray* contactOptionsArray;
    NSMutableArray* sectionIdsArray;
    NSMutableArray* sectionRowCountArray;
    NSArray* sectionSocialMediaArray;
    NSArray* sectionSocialMediaImageArray;
    NSArray* sectionSocialMediaUrlArray;
}

@property (strong, nonatomic) IBOutlet BaseDetailViewController *detailViewController;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property(nonatomic,strong) NSMutableArray *sectionInfoArray;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) UIBarButtonItem *rootPopoverButtonItem;
@property (nonatomic,strong) UIBarButtonItem* showHideMaster;

@property (nonatomic, assign) UISplitViewController *splitViewController;
@property (nonatomic,strong) MyTreeNode* treeNode;

-(void) changeDetailViewController:(BaseDetailViewController*)detailViewController;
-(void) displayTopMenuItem;

@end
