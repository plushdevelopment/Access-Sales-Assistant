//
//  DetailViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSplitViewController.h"
@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void) insertBarButtonItem:(UIBarButtonItem*)barButtonItem;
@end

@interface BaseDetailViewController : UIViewController<SubstitutableDetailViewController> {
@private
    
}
@property(nonatomic,strong) UINavigationBar *baseNavigationBar;
@property(nonatomic,strong) UIToolbar *baseToolbar;

@property(nonatomic,strong) UIBarButtonItem *showHideMaster;

@property (nonatomic,strong) MGSplitViewController* splitviewcontroller;

@property (nonatomic) BOOL hidemaster;

-(void) showAlert:(NSString*) alertText;
-(BOOL) isShowMaster;
-(void) changeTextFieldOutline:(UITextField *)textField:(BOOL) toOriginal;
@end

@interface BaseTextField : UITextField {

  
}
@property(nonatomic) BOOL showOriginal;
@end