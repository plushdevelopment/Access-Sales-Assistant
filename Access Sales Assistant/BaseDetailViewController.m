//
//  DetailViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 6/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseDetailViewController.h"

#import "RootViewController.h"

#import <QuartzCore/QuartzCore.h>

@implementation BaseDetailViewController

@synthesize baseNavigationBar;

@synthesize baseToolbar;

@synthesize hidemaster;

@synthesize showHideMaster;

@synthesize splitviewcontroller;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
 
    
    NSMutableArray *items1 = [[self.baseToolbar items] mutableCopy];
    
    UIBarButtonItem *prospectSubmitBtn = nil,*prospectSpaceButton = nil;
    
    for(UIBarButtonItem* btn in items1)
    {
        if(btn.tag == 1001)
        {
            prospectSubmitBtn = btn;
        }
        else if(btn.tag == 1002)
        {
            prospectSpaceButton = btn;
        }
        
    }

    
    if(items1)
        [items1 removeAllObjects];
  
    [items1 insertObject:barButtonItem atIndex:0];
    
    if(prospectSpaceButton)
        [items1 insertObject:prospectSpaceButton atIndex:[items1 count]]; 
    if(prospectSubmitBtn)
        [items1 insertObject:prospectSubmitBtn atIndex:[items1 count]];
    
    [self.baseToolbar setItems:items1 animated:YES];
	
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    NSMutableArray *items = [[self.baseToolbar items] mutableCopy];
    
    UIBarButtonItem *prospectSubmitBtn = nil,*prospectSpaceButton = nil;
    
    for(UIBarButtonItem* btn in items)
    {
        if(btn.tag == 1001)
        {
            prospectSubmitBtn = btn;
        }
        else if(btn.tag == 1002)
        {
            prospectSpaceButton = btn;
        }
     
    }

    if([items count])
        [items removeAllObjects];
    if(prospectSpaceButton)
        [items insertObject:prospectSpaceButton atIndex:[items count]];
    if(prospectSubmitBtn)
        [items insertObject:prospectSubmitBtn atIndex:[items count]];


    [self.baseToolbar setItems:items animated:YES];

    
}


-(void)insertBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    
    NSMutableArray *items = [[self.baseToolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:[items count]];
    [self.baseToolbar setItems:items animated:YES];
}

-(void) toggleMaster:(id) sender
{
}
-(BOOL) isShowMaster
{
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}
-(void) showAlert:(NSString *)alertText
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:alertText delegate:nil cancelButtonTitle:nil otherButtonTitles: @"OK", nil];
	[alertView show];
}

-(void) changeTextFieldOutline:(UITextField *)textField:(BOOL) toOriginal
{
    if(!toOriginal)
    {
        [textField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
        [textField.layer setBorderColor: [[UIColor redColor] CGColor]];
        [textField.layer setBorderWidth: 3.0f];
        [textField.layer setCornerRadius:8.0f];
        [textField.layer setMasksToBounds:YES];
    }
    else
    {
        textField.layer.borderColor=[[UIColor clearColor]CGColor];
    }
}

-(void) disableTextField:(UITextField*) textField: (BOOL) isEnable
{
    if(!isEnable)
    {
       
        textField.backgroundColor = [UIColor lightGrayColor];
        [textField.layer setMasksToBounds:YES];
        [textField setEnabled:FALSE];
    }
    else
    {
          textField.backgroundColor = [UIColor clearColor];
                [textField setEnabled:TRUE];
    }

}
@end

@implementation BaseTextField

@synthesize showOriginal;

@end
