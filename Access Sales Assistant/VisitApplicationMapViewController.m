//
//  VisitApplicationMapViewController.m
//  Access Sales Assistant
//
//  Created by Ross Chapman on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitApplicationMapViewController.h"
#import "UICRouteOverlayMapView.h"
#import "UICRouteAnnotation.h"
#import "Producer.h"
#import "AddressListItem.h"
#import "VisitApplicationViewController.h"

@implementation VisitApplicationMapViewController
@synthesize toolBar = _toolBar;
@synthesize producersTableView=_producersTableView;
@synthesize directionsMapView = _directionsMapView;
@synthesize selectedDay=_selectedDay;
@synthesize producers=_producers;

@synthesize routeOverlayView=_routeOverlayView;
@synthesize directions=_directions;
@synthesize startPoint=_startPoint;
@synthesize endPoint=_endPoint;
@synthesize wayPoints=_wayPoints;
@synthesize travelMode=_travelMode;

- (void)setSelectedDay:(NSString *)selectedDay
{
	if (_selectedDay != selectedDay) {
        _selectedDay = selectedDay;
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nextScheduledVisitDate matches %@", _selectedDay];
		self.producers = [Producer findAllWithPredicate:predicate];
	}
	[self configureView];
}

- (void)configureView
{
	if (self.producers.count > 0) {
		self.startPoint = [(Producer *)[self.producers objectAtIndex:0] address];
		self.endPoint = [(Producer *)[self.producers lastObject] address];
		NSMutableArray *wayPoints = [NSMutableArray array];
		for (Producer *producer in self.producers) {
			if (([self.producers indexOfObject:producer] > 0) && ([self.producers indexOfObject:producer] < self.producers.count - 1)) {
				[wayPoints addObject:producer.address];
			}
		}
		self.wayPoints = wayPoints;
		NSLog(@"%@", [self.wayPoints debugDescription]);
		self.travelMode = UICGTravelModeDriving;
	}
	[self.producersTableView reloadData];
	if (_directions.isInitialized) {
		[self update];
	}
}

- (void)update
{
	UICGDirectionsOptions *options = [[UICGDirectionsOptions alloc] init];
	options.travelMode = _travelMode;
	if ([_wayPoints count] > 0) {
		NSArray *routePoints = [NSArray arrayWithObject:_startPoint];
		routePoints = [routePoints arrayByAddingObjectsFromArray:_wayPoints];
		routePoints = [routePoints arrayByAddingObject:_endPoint];
		[_directions loadFromWaypoints:routePoints options:options];
	} else {
		[_directions loadWithStartPoint:_startPoint endPoint:_endPoint options:options];
	}
}

- (void)moveToCurrentLocation:(id)sender {
	[_directionsMapView setCenterCoordinate:[_directionsMapView.userLocation coordinate] animated:YES];
}

- (void)addPinAnnotation:(id)sender {
	UICRouteAnnotation *pinAnnotation = [[UICRouteAnnotation alloc] initWithCoordinate:[_directionsMapView centerCoordinate]
																				  title:nil
																		 annotationType:UICRouteAnnotationTypeWayPoint];
	[_directionsMapView addAnnotation:pinAnnotation];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.baseToolbar = _toolBar;
	
	_routeOverlayView = [[UICRouteOverlayMapView alloc] initWithMapView:self.directionsMapView];
	
	_directions = [UICGDirections sharedDirections];
	_directions.delegate = self;
}

- (void)viewDidUnload
{
    [self setProducersTableView:nil];
	[self setDirectionsMapView:nil];
	[self setToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - 
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.producers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	Producer *producer = [self.producers objectAtIndex:indexPath.row];
	cell.textLabel.text = producer.name;
	cell.detailTextLabel.text = producer.nextScheduledVisitTime;
    
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Producer *producer = [self.producers objectAtIndex:indexPath.row];
	VisitApplicationViewController *viewController = [[VisitApplicationViewController alloc] initWithNibName:@"VisitApplicationViewController" bundle:nil];
	[viewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[viewController setModalPresentationStyle:UIModalPresentationCurrentContext];
	[self presentModalViewController:viewController animated:YES];
	[viewController setDetailItem:producer];
}

#pragma mark -
#pragma mark MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	
}

- (void)mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
	
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
	
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
	
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
	_routeOverlayView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	_routeOverlayView.hidden = NO;
	[_routeOverlayView setNeedsDisplay];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	static NSString *identifier = @"RoutePinAnnotation";
	
	if ([annotation isKindOfClass:[UICRouteAnnotation class]]) {
		MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		if(!pinAnnotation) {
			pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		}
		
		if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeStart) {
			pinAnnotation.pinColor = MKPinAnnotationColorGreen;
		} else if ([(UICRouteAnnotation *)annotation annotationType] == UICRouteAnnotationTypeEnd) {
			pinAnnotation.pinColor = MKPinAnnotationColorRed;
		} else {
			pinAnnotation.pinColor = MKPinAnnotationColorPurple;
		}
		
		pinAnnotation.animatesDrop = YES;
		pinAnnotation.enabled = YES;
		pinAnnotation.canShowCallout = YES;
		return pinAnnotation;
	} else {
		return [_directionsMapView viewForAnnotation:_directionsMapView.userLocation];
	}
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
	
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
	
}

- (void)directionsDidFinishInitialize:(UICGDirections *)directions {
	[self update];
}

- (void)directions:(UICGDirections *)directions didFailInitializeWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
}

- (void)directionsDidUpdateDirections:(UICGDirections *)directions {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	// Overlay polylines
	UICGPolyline *polyline = [directions polyline];
	NSArray *routePoints = [polyline routePoints];
	[_routeOverlayView setRoutes:routePoints];
	
	// Add annotations
	UICRouteAnnotation *startAnnotation = [[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints objectAtIndex:0] coordinate]
																					title:_startPoint
																		   annotationType:UICRouteAnnotationTypeStart];
	UICRouteAnnotation *endAnnotation = [[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
																				  title:_endPoint
																		 annotationType:UICRouteAnnotationTypeEnd];
	
	if ([_wayPoints count] > 0) {
		NSInteger numberOfRoutes = [directions numberOfRoutes];
		for (NSInteger index = 0; index < numberOfRoutes; index++) {
			UICGRoute *route = [directions routeAtIndex:index];
			CLLocation *location = [route endLocation];
			UICRouteAnnotation *annotation = [[UICRouteAnnotation alloc] initWithCoordinate:[location coordinate]
																					   title:[[route endGeocode] objectForKey:@"address"]
																			  annotationType:UICRouteAnnotationTypeEnd];
			[_directionsMapView addAnnotation:annotation];
		}
	}
	
	[_directionsMapView addAnnotations:[NSArray arrayWithObjects:startAnnotation, endAnnotation, nil]];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
}

@end
