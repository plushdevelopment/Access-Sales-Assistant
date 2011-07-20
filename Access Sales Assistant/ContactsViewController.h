//
//  ContactsViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

#import <MessageUI/MFMailComposeViewController.h>

#import "BaseDetailViewController.h"

@interface ContactsViewController: BaseDetailViewController<MFMailComposeViewControllerDelegate>

@property(nonatomic,strong) IBOutlet UIToolbar *toolBar;
@property(nonatomic) NSInteger selectedContactOption;
@property (nonatomic, strong) UIBarButtonItem *rootPopoverButtonItem;

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
-(void)launchMailComposer;
@end
