//
//  NSString-Validation.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString-Validation.h"



@implementation NSString(Validation)

-(BOOL)isValidEmail
{
    
  //  [self lowercaseString];
    if([self length]<=0)
        return YES;
       NSLog(@"%@",self);
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:self];
}

-(BOOL) isValidPhoneNumber
{    
    
    if([self length]<=0)
        return YES;
     NSString *phoneNoRegEx =@"^\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$";
    
   // [self stringByMatching:phoneNoRegEx];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNoRegEx]; 
    
    return [phoneTest evaluateWithObject:self];
}
-(BOOL) isValidZipCode
{
    if([self length]<=0)
        return YES;
    NSString *zipCodeEx =@"^(\\d{5}-\\d{4}|\\d{5}|\\d{9})$|^([a-zA-Z]\\d[a-zA-Z] \\d[a-zA-Z]\\d)$";
    
    // [self stringByMatching:phoneNoRegEx];
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeEx]; 
    
    return [zipCodeTest evaluateWithObject:self];
    
}
-(BOOL) isvalidSSN
{
    if([self length]<=0)
        return YES;
    NSString *ssnEx =@"^\\d{3}-\\d{2}-\\d{4}$";
    
    NSLog(@"%@",self);
    // NSString *ssnEx =@"^(?!000)([0-6]\\d{2}|7([0-6]\\d|7[012]))([ -]?)(?!00)\\d\\d\\3(?!0000)\\d{4}$";
    // [self stringByMatching:phoneNoRegEx];
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ssnEx]; 
    
    BOOL isValid = [zipCodeTest evaluateWithObject:self];
    
    return isValid;
}
-(BOOL) isValidWebSite
{
    
    if([self length]<=0)
        return YES;
    NSString *webSiteEx =@"(http|https)://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    
    // [self stringByMatching:phoneNoRegEx];
    NSPredicate *webSiteTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", webSiteEx]; 
    
    return [webSiteTest evaluateWithObject:self];
    
}
@end
