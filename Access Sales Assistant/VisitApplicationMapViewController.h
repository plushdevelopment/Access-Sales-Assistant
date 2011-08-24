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
#import "VisitApplicationTabBarController.h"

@class UICRouteOverlayMapView;

@interface VisitApplicationMapViewController : BaseDetailViewController <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, UICGDirectionsDelegate>




@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UITableView *producersTableView;
@property (strong, nonatomic) IBOutlet MKMapView *directionsMapView;
@property (strong, nonatomic) NSString *selectedDay;
@property (strong, nonatomic) NSArray *producers;

@property (strong, nonatomic) UICGDirections *directions;
@property (strong, nonatomic) NSString *startPoint;
@property (strong, nonatomic) NSString *endPoint;
@property (strong, nonatomic) NSArray *wayPoints;
@property (nonatomic) UICGTravelModes travelMode;
@property (nonatomic, strong) MKPolyline *polyline;
@property (nonatomic, strong) MKPolylineView *polylineView;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (strong, nonatomic) IBOutlet VisitApplicationTabBarController *tabBarController;
@property (strong, nonatomic) UINib *visitTableViewCellNib;

- (void)configureView;
- (void)update;
- (void)selectVisit:(id)sender;

@end
