//
//  ProducerDetailViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Producer.h"

@interface ProducerDetailViewController : UIViewController {
	
}


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *code;
@property (strong, nonatomic) IBOutlet UILabel *street;
@property (strong, nonatomic) IBOutlet UILabel *address;

- (void)setProducer:(Producer *)producer;

@end
