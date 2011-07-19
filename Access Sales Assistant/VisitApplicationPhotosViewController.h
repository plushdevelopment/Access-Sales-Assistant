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

@class Producer;

@interface VisitApplicationPhotosViewController : UIViewController <UIImagePickerControllerDelegate, AQGridViewDataSource, AQGridViewDelegate>

@property (nonatomic, strong) Producer *detailItem;
@property (nonatomic, strong) IBOutlet AQGridView *gridView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, unsafe_unretained) UIViewController *parent;

- (void)configureView;
- (IBAction)uploadPhoto:(id)sender;
- (void)getImageSuccess:(ASIHTTPRequest *)request;
- (NSString *)applicationDocumentsDirectory;

@end
