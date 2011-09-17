//
//  VisitApplicationPhotosViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "AQGridView.h"
#import "VisitApplicationTabBarController.h"

@class Producer;

@interface VisitApplicationPhotosViewController : UIViewController <UIImagePickerControllerDelegate, AQGridViewDataSource, AQGridViewDelegate, DetailViewController, UITextFieldDelegate>

@property (nonatomic, strong) Producer *detailItem;
@property (nonatomic, strong) IBOutlet AQGridView *gridView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, unsafe_unretained) UIViewController *parent;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) NSString* titleText;
@property (nonatomic) NSUInteger deleteIndex;

- (void)configureView;
- (IBAction)deletePhoto:(id)sender;
- (IBAction)uploadPhoto:(id)sender;
- (void)getImageSuccess:(ASIHTTPRequest *)request;
- (NSString *)applicationDocumentsDirectory;
- (IBAction)dismiss:(id)sender;

@end
