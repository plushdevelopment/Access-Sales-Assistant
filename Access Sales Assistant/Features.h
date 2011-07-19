//
//  Features.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Features : NSObject

-(Features*) initFeature:(NSString*) feature :(NSString*) benefit:(BOOL) isTitle; 
@property(nonatomic,strong) NSString* strFeature;
@property(nonatomic,strong) NSString* strBenefit;
@property(nonatomic) BOOL bIsFeatureTitle;

@end
