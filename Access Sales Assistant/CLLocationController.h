//
//  CLLocationController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CLLocationController : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;
@property (nonatomic) BOOL updateInProgress;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (nonatomic) CLLocationCoordinate2D currentCoordinate;
@property (strong, nonatomic) NSSet *monitoredRegions;

+ (CLLocationController *)sharedCLLocationController;
- (void)startUpdatingCurrentLocation;
- (void)stopUpdatingCurrentLocation;
- (void)monitorRegion:(CLRegion *)region;
- (void)monitorProducers:(NSArray *)producers;

@end
