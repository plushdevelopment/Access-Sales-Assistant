//
//  VisitApplicationNotesViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitApplicationTabBarController.h"

@class DailySummary;

@interface VisitApplicationNotesViewController : UIViewController <UITextFieldDelegate, DetailViewController> {
/*	UITextField *_opportunityTextField;
	UITextField *_summaryTextField;
	UITextField *_committmentTextField;
	UITextField *_followUpTextField;*/
}



@property (nonatomic, strong) DailySummary *detailItem;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UITextView *opportunityTextField;
@property (nonatomic, strong) IBOutlet UITextView *summaryTextField;
@property (nonatomic, strong) IBOutlet UITextView *committmentTextField;
@property (nonatomic, strong) IBOutlet UITextView *followUpTextField;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSString* titleText;

- (void)configureView;
- (IBAction)dismiss:(id)sender;
- (IBAction)submit:(id)sender;

@end
