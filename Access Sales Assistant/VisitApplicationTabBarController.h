//
//  VisitApplicationTabBarController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailViewController <NSObject>

- (void)setDetailItem:(id)detailItem;

@end

@interface VisitApplicationTabBarController : UITabBarController

@property (nonatomic, strong) id detailItem;
@property (nonatomic) BOOL isVisitApp;

- (void)configureView;

@end
