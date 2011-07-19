//
//  ContactQAFormView.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseDetailViewController.h"

@interface ContactQAFormView : BaseDetailViewController

@property(nonatomic,strong) IBOutlet UIToolbar* toolBar;

@property(nonatomic,strong) IBOutlet UITextField* producerNumber;

@property(nonatomic,strong) IBOutlet UITextField* producerCode;

@property(nonatomic,strong) IBOutlet UITextField* qaDescription;

@property(nonatomic,strong) IBOutlet UITextView* qaRequest;

@property(nonatomic,strong) IBOutlet UIButton* qaSubmitButton;

@property(nonatomic,strong) NSString* strProducerNumber;
@property(nonatomic,strong) NSString* strProducerCode;
@property(nonatomic,strong) NSString* strQADescription;
@property(nonatomic,strong) NSString* strQARequest;



-(IBAction)submitQARequest:(id)sender;
@end
