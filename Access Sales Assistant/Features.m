//
//  Features.m
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Features.h"

@implementation Features

@synthesize strFeature = _strFeature;
@synthesize strBenefit = _strBenefit;
@synthesize bIsFeatureTitle = _bIsFeatureTitle;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(Features*) initFeature:(NSString*) feature :(NSString*) benefit:(BOOL) isTitle
{
    
        Features* featureObj = [[Features alloc] init];

    if (featureObj) {
        
        _strFeature = [[NSString alloc] initWithString:feature];
        if(benefit!=nil)
            _strBenefit = [[NSString alloc] initWithString:benefit];
        else
            _strBenefit = nil;
        _bIsFeatureTitle = isTitle;

        // Initialization code here.
    }
    
    return featureObj;

    
    
    
}

@end
