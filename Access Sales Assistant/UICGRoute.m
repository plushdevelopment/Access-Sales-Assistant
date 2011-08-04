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
        NSDictionary *k = [dictionaryRepresentation objectForKey:[allKeys objectAtIndex:[allKeys count] - 1]];
		NSArray *stepDics = [k objectForKey:@"Steps"];
		numerOfSteps = [stepDics count];
		steps = [[NSMutableArray alloc] initWithCapacity:numerOfSteps];
		for (NSDictionary *stepDic in stepDics) {
			[(NSMutableArray *)steps addObject:[UICGStep stepWithDictionaryRepresentation:stepDic]];
		}
		
		endGeocode = [dictionaryRepresentation objectForKey:@"MJ"];
		startGeocode = [dictionaryRepresentation objectForKey:@"dT"];
		
		distance = [k objectForKey:@"Distance"];
		duration = [k objectForKey:@"Duration"];
		NSDictionary *endLocationDic = [k objectForKey:@"Point"];
		NSArray *coordinates = [endLocationDic objectForKey:@"coordinates"];
		CLLocationDegrees longitude = [[coordinates objectAtIndex:0] doubleValue];
		CLLocationDegrees latitude  = [[coordinates objectAtIndex:1] doubleValue];
		endLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
		summaryHtml = [k objectForKey:@"summaryHtml"];
		polylineEndIndex = [[k objectForKey:@"polylineEndIndex"] integerValue];
	}
	return self;
}


- (UICGStep *)stepAtIndex:(NSInteger)index {
	return [steps objectAtIndex:index];;
}

@end
