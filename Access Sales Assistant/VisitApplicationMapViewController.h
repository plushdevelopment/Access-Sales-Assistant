//
//  VisitApplicationMapViewController.h
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseDetailViewController.h"
#import <MapKit/MapKit.h>
#import "UICGDirections.h"

@class UICRouteOverlayMapView;

@interface VisitApplicationMapViewController : BaseDetailViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UICGDirectionsDelegate>



@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UITableView *producersTableView;
@property (strong, nonatomic) IBOutlet MKMapView *directionsMapView;
@property (strong, nonatomic) NSString *selectedDay;
@property (strong, nonatomic) NSArray *producers;

@property (strong, nonatomic) UICRouteOverlayMapView *routeOverlayView;
@property (strong, nonatomic) UICGDirections *directions;
@property (strong, nonatomic) NSString *startPoint;
@property (strong, nonatomic) NSString *endPoint;
@property (strong, nonatomic) NSArray *wayPoints;
@property (nonatomic) UICGTravelModes travelMode;

- (void)configureView;
- (void)update;

@end
