//
//  ProducerQuestionTableViewCell.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProducerQuestionTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *questionLabel;
@property (nonatomic, strong) IBOutlet UITextField *answerTextField;

@end
