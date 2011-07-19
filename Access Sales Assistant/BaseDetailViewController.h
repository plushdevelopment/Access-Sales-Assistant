//
//  DetailViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface BaseDetailViewController : UIViewController<SubstitutableDetailViewController> {
@private
    
}
@property(nonatomic,strong) UINavigationBar *baseNavigationBar;
@property(nonatomic,strong) UIToolbar *baseToolbar;

-(void) showAlert:(NSString*) alertText;
@end

