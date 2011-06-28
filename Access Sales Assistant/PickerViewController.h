//
//  PickerViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate;

@interface PickerViewController : UIViewController {
	UIPickerView *pickerView;
	id <PickerViewControllerDelegate> _delegate;
}

@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) IBOutlet id <PickerViewControllerDelegate> delegate;
@property (nonatomic) NSInteger currentTag;

- (IBAction)nextField:(id)sender;
- (IBAction)previousField:(id)sender;


@end

@protocol PickerViewControllerDelegate <NSObject>

- (void)didChangeValue:(UIPickerView *)picker forTag:(NSInteger)tag;
- (void)nextField:(NSInteger)currentTag;
- (void)previousField:(NSInteger)currentTag;

@end

