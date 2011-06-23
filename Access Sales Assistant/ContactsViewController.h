//
//  ContactsViewController.h
//  Sales Templates
//
//  Created by Michael Cantrell on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ContactsViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
}

- (IBAction)closeModal:(id)sender;

- (IBAction)emailButton:(id)sender;

@end
