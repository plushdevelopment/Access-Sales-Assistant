//
//  ProducerHoursTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PRPNibBasedTableViewCell.h"
@interface ProducerHoursTableViewCell : PRPNibBasedTableViewCell {
	UITextField *_startTextField;
	UITextField *_stopTextField;
}


@property (nonatomic, strong) IBOutlet UILabel *weekdayLabel;

@property (nonatomic, strong) IBOutlet UITextField *monStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *monStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *tueStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *tueStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *wedStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *wedStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *thuStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *thuStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *friStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *friStopTextField;
@property (nonatomic, strong) IBOutlet UITextField *satStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *satStopTextField;

@property (nonatomic, strong) IBOutlet UITextField *sunStartTextField;
@property (nonatomic, strong) IBOutlet UITextField *sunStopTextField;

@property (nonatomic, strong) IBOutlet UIButton *monStartButton;
@property (nonatomic, strong) IBOutlet UIButton *monStopButton;
@property (nonatomic, strong) IBOutlet UIButton *tueStartButton;
@property (nonatomic, strong) IBOutlet UIButton *tueStopButton;
@property (nonatomic, strong) IBOutlet UIButton *wedStartButton;
@property (nonatomic, strong) IBOutlet UIButton *wedStopButton;
@property (nonatomic, strong) IBOutlet UIButton *thuStartButton;
@property (nonatomic, strong) IBOutlet UIButton *thuStopButton;
@property (nonatomic, strong) IBOutlet UIButton *friStartButton;
@property (nonatomic, strong) IBOutlet UIButton *friStopButton;
@property (nonatomic, strong) IBOutlet UIButton *satStartButton;
@property (nonatomic, strong) IBOutlet UIButton *satStopButton;

@property (nonatomic, strong) IBOutlet UIButton *sunStartButton;
@property (nonatomic, strong) IBOutlet UIButton *sunStopButton;

@end
