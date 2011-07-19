//
//  VisitApplicationNotesViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DailySummary;

@interface VisitApplicationNotesViewController : UIViewController <UITextFieldDelegate> {
	UITextField *_opportunityTextField;
	UITextField *_summaryTextField;
	UITextField *_committmentTextField;
	UITextField *_followUpTextField;
}



@property (nonatomic, strong) DailySummary *detailItem;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet UITextField *opportunityTextField;
@property (nonatomic, strong) IBOutlet UITextField *summaryTextField;
@property (nonatomic, strong) IBOutlet UITextField *committmentTextField;
@property (nonatomic, strong) IBOutlet UITextField *followUpTextField;


- (void)configureView;

@end
