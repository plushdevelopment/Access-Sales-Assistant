//
//  DatePickerViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerViewControllerDelegate;

@interface DatePickerViewController : UIViewController {
	UIDatePicker *datePicker;
	__weak id <DatePickerViewControllerDelegate> _delegate;
}

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
@property (nonatomic) NSInteger currentTag;

- (IBAction)datePickerValueChanged:(id)sender;
- (IBAction)nextField:(id)sender;
- (IBAction)previousField:(id)sender;

@end

@protocol DatePickerViewControllerDelegate <NSObject>

- (void)didChangeDate:(NSDate *)toDate forTag:(NSInteger)tag;
- (void)nextField:(NSInteger)currentTag;
- (void)previousField:(NSInteger)currentTag;

@end