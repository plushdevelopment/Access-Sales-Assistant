//
//  NSString-Validation.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Validation)

-(BOOL)isValidEmail;
-(BOOL) isValidPhoneNumber;
-(BOOL) isValidZipCode;

@end
