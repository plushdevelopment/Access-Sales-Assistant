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

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager
     didUpdateToLocation:(CLLocation *)newLocation
            fromLocation:(CLLocation *)oldLocation
{
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	_updateInProgress = NO;
    _currentCoordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
	
}

@end
