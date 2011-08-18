//
//  ContactsQAFormViewController.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"
@interface ContactsQAFormViewController : BaseDetailViewController

-(IBAction)cancelRequest:(id)sender;
-(IBAction)submitRequest:(id)sender;
@property (nonatomic,strong) IBOutlet UITextView *requestView;
@property (nonatomic,strong) IBOutlet UITextField *producerNumberField;
@property (nonatomic,strong) IBOutlet UITextField *producerCodeField;
@property (nonatomic,strong) IBOutlet UITextField *descriptionField;

@property(nonatomic,strong) NSString* strProducerNumber;
@property(nonatomic,strong) NSString* strProducerCode;
@property(nonatomic,strong) NSString* strQADescription;
@property(nonatomic,strong) NSString* strQARequest;
@end
