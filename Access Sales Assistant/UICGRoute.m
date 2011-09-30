//
//  UICGRoute.m
//  MapDirections
//
//  Created by KISHIKAWA Katsumi on 09/08/10.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "UICGRoute.h"

@implementation UICGRoute

@synthesize dictionaryRepresentation;
@synthesize numerOfSteps;
@synthesize steps;
@synthesize distance;
@synthesize duration;
@synthesize summaryHtml;
@synthesize startGeocode;
@synthesize endGeocode;
@synthesize endLocation;
@synthesize polylineEndIndex;

+ (UICGRoute *)routeWithDictionaryRepresentation:(NSDictionary *)dictionary {
	UICGRoute *route = [[UICGRoute alloc] initWithDictionaryRepresentation:dictionary];
	return route;
}

- (id)initWithDictionaryRepresentation:(NSDictionary *)dictionary {
	self = [super init];
	if (self != nil) {
		dictionaryRepresentation = dictionary;
        NSArray *allKeys = [dictionaryRepresentation allKeys];
		id k = [dictionaryRepresentation objectForKey:[allKeys objectAtIndex:[allKeys count] - 1]];
		NSArray *stepDics;
		NSDictionary *endLocationDic;
        if ([k isKindOfClass:[NSDictionary class]]) {
			stepDics = [k objectForKey:@"Steps"];
			distance = [k objectForKey:@"Distance"];
			duration = [k objectForKey:@"Duration"];
			endLocationDic = [k objectForKey:@"Point"];
			summaryHtml = [k objectForKey:@"summaryHtml"];
			polylineEndIndex = [[k objectForKey:@"polylineEndIndex"] integerValue];
		} else {
			stepDics = [k lastObject];
			distance = [[k lastObject] objectForKey:@"Distance"];
			duration = [[k lastObject] objectForKey:@"Duration"];
			endLocationDic = [[k lastObject] objectForKey:@"Point"];
			summaryHtml = [[k lastObject] objectForKey:@"summaryHtml"];
			polylineEndIndex = [[[k lastObject] objectForKey:@"polylineEndIndex"] integerValue];
		}
		numerOfSteps = [stepDics count];
		steps = [[NSMutableArray alloc] initWithCapacity:numerOfSteps];
		for (id stepDic in stepDics) {
			if ([stepDic isKindOfClass:[NSDictionary class]]) {
				UICGStep *step = [UICGStep stepWithDictionaryRepresentation:stepDic];
				if (step) {
					[(NSMutableArray *)steps addObject:step];
				}
			}
			
		}
		
		endGeocode = [dictionaryRepresentation objectForKey:@"MJ"];
		startGeocode = [dictionaryRepresentation objectForKey:@"dT"];
		NSArray *coordinates = [endLocationDic objectForKey:@"coordinates"];
		CLLocationDegrees longitude = [[coordinates objectAtIndex:0] doubleValue];
		CLLocationDegrees latitude  = [[coordinates objectAtIndex:1] doubleValue];
		endLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		
	}
	return self;
}


- (UICGStep *)stepAtIndex:(NSInteger)index {
	return [steps objectAtIndex:index];;
}

@end
