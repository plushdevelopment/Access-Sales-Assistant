//
//  CLLocationController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CLLocationController.h"

#import "SynthesizeSingleton.h"

@implementation CLLocationController

@synthesize manager=_manager;

@synthesize updateInProgress=_updateInProgress;

@synthesize currentLocation=_currentLocation;

@synthesize currentCoordinate=_currentCoordinate;

@synthesize monitoredRegions=_monitoredRegions;

SYNTHESIZE_SINGLETON_FOR_CLASS(CLLocationController);

- (id)init
{
    self = [super init];
    if (self) {
        _manager = [[CLLocationManager alloc] init];
		[_manager setDelegate:self];
		[_manager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
		//[_manager setPurpose:@"The better to track you with"];
		_currentLocation = nil;
		_currentCoordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);
		_updateInProgress = NO;
    }
    
    return self;
}

- (void)startUpdatingCurrentLocation
{
    if (_updateInProgress) {
        NSLog(@"SSLocationManager::startUpdatingCurrentLocation - cannot start a new update, one is already in progress");
        return;
    }
    _updateInProgress = YES;
    [_manager startUpdatingLocation];
}

- (void)stopUpdatingCurrentLocation
{
    _updateInProgress = NO;
    [_manager stopUpdatingLocation];
}

- (void)monitorRegion:(CLRegion *)region
{
	[_manager startMonitoringForRegion:region];
}

- (void)monitorProducers:(NSArray *)producers
{
	for (CLRegion *region in [_manager monitoredRegions]) {
		[_manager stopMonitoringForRegion:region];
	}
	
	for (Producer *producer in producers) {
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(producer.latitudeValue, producer.longitudeValue);
		CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:coordinate radius:100.0 identifier:producer.producerCode];
		[self monitorRegion:region];
	}
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
     didUpdateToLocation:(CLLocation *)newLocation
            fromLocation:(CLLocation *)oldLocation
{
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[newLocation description], @"New Location", [oldLocation description], @"Old Location", nil];
	[FlurryAnalytics logEvent:@"Did update to new location" withParameters:dict];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	_updateInProgress = NO;
    _currentCoordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);
	[FlurryAnalytics logError:@"Location Error" message:[error localizedDescription] error:error];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[region description], @"Region", nil];
	[FlurryAnalytics logEvent:@"Did Enter Region" withParameters:dict];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[region description], @"Region", nil];
	[FlurryAnalytics logEvent:@"Did Exit Region" withParameters:dict];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[region description], @"Region", nil];
	[FlurryAnalytics logEvent:@"Failed Monitoring Region" withParameters:dict];
}

@end
