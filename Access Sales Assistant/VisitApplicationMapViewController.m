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
#import "ProducerAnnotationView.h"
#import "Producer.h"
#import "AddressListItem.h"
#import "VisitApplicationViewController.h"
#import "ProducerDetailViewController.h"
#import "HTTPOperationController.h"
#import "VisitTableViewCell.h"
#import "UITableView+PRPSubviewAdditions.h"

@implementation VisitApplicationMapViewController
@synthesize toolBar = _toolBar;
@synthesize producersTableView=_producersTableView;
@synthesize directionsMapView = _directionsMapView;
@synthesize selectedDay=_selectedDay;
@synthesize producers=_producers;

@synthesize directions=_directions;
@synthesize startPoint=_startPoint;
@synthesize endPoint=_endPoint;
@synthesize wayPoints=_wayPoints;
@synthesize travelMode=_travelMode;
@synthesize polyline=_polyline;
@synthesize polylineView=_polylineView;
@synthesize popoverController=popoverController;
@synthesize tabBarController = _tabBarController;
@synthesize visitTableViewCellNib=_visitTableViewCellNib;

- (void)producersSuccessful
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nextScheduledVisitDate matches %@", _selectedDay];
	self.producers = [Producer findAllSortedBy:@"nextScheduledVisit" ascending:YES withPredicate:predicate];
	[self configureView];
}

- (UINib *)visitTableViewCellNib
{
	if (_visitTableViewCellNib == nil) {
		self.visitTableViewCellNib = [VisitTableViewCell nib];
	}
	return _visitTableViewCellNib;
}

- (void)setSelectedDay:(NSString *)selectedDay
{
	if (_selectedDay != selectedDay) {
        _selectedDay = selectedDay;
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nextScheduledVisitDate matches %@", _selectedDay];
		self.producers = [Producer findAllSortedBy:@"nextScheduledVisit" ascending:YES withPredicate:predicate];
	}
	[self configureView];
}

- (void)configureView
{
	[self.directionsMapView removeOverlays:self.directionsMapView.overlays];
	[self.directionsMapView removeAnnotations:self.directionsMapView.annotations];
	if (self.producers.count > 0) {
		self.startPoint = [(Producer *)[self.producers objectAtIndex:0] address];
		self.endPoint = [(Producer *)[self.producers lastObject] address];
		NSMutableArray *wayPoints = [NSMutableArray array];
		for (Producer *producer in self.producers) {
			[[HTTPOperationController sharedHTTPOperationController] getImagesForProducer:producer.uid];
			if (([self.producers indexOfObject:producer] > 0) && ([self.producers indexOfObject:producer] < self.producers.count - 2)) {
				[wayPoints addObject:producer.address];
			}
		}
		self.wayPoints = wayPoints;
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
		NSLog(@"%@",routePoints);
		[_directions loadFromWaypoints:routePoints options:options];
	} else {
		[_directions loadWithStartPoint:_startPoint endPoint:_endPoint options:options];
	}
}

- (void)moveToCurrentLocation:(id)sender {
	[_directionsMapView setCenterCoordinate:[_directionsMapView.userLocation coordinate] animated:YES];
}

- (void)selectVisit:(id)sender
{
	NSIndexPath *indexPath = [self.producersTableView prp_indexPathForRowContainingView:sender];
	Producer *producer = [self.producers objectAtIndex:indexPath.row];
	for (id <MKAnnotation> annotation in self.directionsMapView.annotations) {
		if ([annotation isKindOfClass:[UICRouteAnnotation class]] && [annotation.title isEqualToString:producer.producerCode]) {
			[self.directionsMapView selectAnnotation:annotation animated:YES];
		}
	}
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
	
	_directions = [UICGDirections sharedDirections];
	_directions.delegate = self;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(producersSuccessful) name:@"Producers Successful" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self configureView];
}

- (void)viewDidUnload
{
    [self setProducersTableView:nil];
	[self setDirectionsMapView:nil];
	[self setToolBar:nil];
    [self setTabBarController:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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
    VisitTableViewCell *customCell = [VisitTableViewCell cellForTableView:tableView fromNib:self.visitTableViewCellNib];
	Producer *producer = [self.producers objectAtIndex:indexPath.row];
	customCell.producerNameLabel.text = producer.name;
	customCell.timeLabel.text = producer.nextScheduledVisitTime;
	customCell.visitNumberLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row + 1)];
	if (producer.submittedValue) {
		customCell.iconImageView.image = [UIImage imageNamed:@"grey_square_pin.png"];
	} else {
		customCell.iconImageView.image = [UIImage imageNamed:@"red_square_pin.png"];
	}
	[customCell.iconButton addTarget:self action:@selector(selectVisit:) forControlEvents:UIControlEventTouchUpInside];
    return customCell;
}

#pragma mark - 
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Producer *producer = [self.producers objectAtIndex:indexPath.row];
	/*
	VisitApplicationViewController *viewController = [[VisitApplicationViewController alloc] initWithNibName:@"VisitApplicationViewController" bundle:nil];
	[viewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[viewController setModalPresentationStyle:UIModalPresentationCurrentContext];
	[self presentModalViewController:viewController animated:YES];
	[viewController setDetailItem:producer];
	*/
	[self.tabBarController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
	[self.tabBarController setModalPresentationStyle:UIModalPresentationPageSheet];
	//[self.splitviewcontroller presentModalViewController:self.tabBarController animated:YES];
    [self presentModalViewController:self.tabBarController animated:YES];
	[self.tabBarController setDetailItem:producer];
}

#pragma mark -
#pragma mark MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	MKAnnotationView *aV; 
	for (aV in views) {
		CGRect endFrame = aV.frame;
		
		aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 230.0, aV.frame.size.width, aV.frame.size.height);
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.45];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[aV setFrame:endFrame];
		[UIView commitAnimations];
	}
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
	ProducerDetailViewController *viewController = [[ProducerDetailViewController alloc] initWithNibName:@"ProducerDetailViewController" bundle:nil];
	Producer *producer = [Producer findFirstByAttribute:@"producerCode" withValue:view.annotation.title];
	[viewController setContentSizeForViewInPopover:CGSizeMake(300.0, 262.0)];
	self.popoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
	[self.popoverController presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[viewController setProducer:producer];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
	
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	static NSString *identifier = @"RoutePinAnnotation";
	
	if ([annotation isKindOfClass:[UICRouteAnnotation class]]) {
		ProducerAnnotationView *pinAnnotation = (ProducerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		if(!pinAnnotation) {
			pinAnnotation = [[ProducerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		}
		Producer *producer = [Producer findFirstByAttribute:@"producerCode" withValue:annotation.title];
		if (producer.submittedValue) {
			pinAnnotation.image = [UIImage imageNamed:@"grey_square_pin.png"];
		} else {
			pinAnnotation.image = [UIImage imageNamed:@"red_square_pin.png"];
		}
		[pinAnnotation setNumber:[(UICRouteAnnotation *)annotation number]];
		pinAnnotation.enabled = YES;
		pinAnnotation.canShowCallout = NO;
		return pinAnnotation;
	} else {
		return [_directionsMapView viewForAnnotation:_directionsMapView.userLocation];
	}
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay
{
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.polyline)
	{
		//if we have not yet created an overlay view for this overlay, create it now.
		if(nil == self.polylineView)
		{
			self.polylineView = [[MKPolylineView alloc] initWithPolyline:self.polyline];
			self.polylineView.fillColor = [UIColor blueColor];
			self.polylineView.strokeColor = [UIColor blueColor];
			self.polylineView.lineWidth = 3;
		}
		
		overlayView = self.polylineView;
		
	}
	
	return overlayView;
	
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
	
	// create a c array of points.
	CLLocationCoordinate2D *pointArr = calloc(routePoints.count, sizeof(CLLocationCoordinate2D));
	
	CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
	
	for (int i = 0; i < routePoints.count; i++) {
		CLLocation *currentLocation = [routePoints objectAtIndex:i];
		if(currentLocation.coordinate.latitude > maxLat) {
			maxLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.latitude < minLat) {
			minLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.longitude > maxLon) {
			maxLon = currentLocation.coordinate.longitude;
		}
		if(currentLocation.coordinate.longitude < minLon) {
			minLon = currentLocation.coordinate.longitude;
		}
	}
	
	for (int idx = 0; idx < routePoints.count; idx++) {
		pointArr[idx] = [(CLLocation *)[routePoints objectAtIndex:idx] coordinate];
	}
	
	self.polyline = [MKPolyline polylineWithCoordinates:pointArr count:routePoints.count];
	[self.directionsMapView addOverlay:self.polyline];
	free(pointArr);
	
	CLLocationCoordinate2D southWestCoord = CLLocationCoordinate2DMake(maxLat, minLon);
	MKMapPoint southWestPoint = MKMapPointForCoordinate(southWestCoord);
	CLLocationCoordinate2D northEastCoord = CLLocationCoordinate2DMake(minLat, maxLon);
	MKMapPoint northEastPoint = MKMapPointForCoordinate(northEastCoord);
	
	MKMapRect rect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
	
	[self.directionsMapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
	
	// Add annotations
	/*
	UICRouteAnnotation *startAnnotation = [[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints objectAtIndex:0] coordinate]
																				   title:[[self.producers objectAtIndex:0] producerCode]
																		   annotationType:UICRouteAnnotationTypeStart number:1];
	UICRouteAnnotation *endAnnotation = [[UICRouteAnnotation alloc] initWithCoordinate:[[routePoints lastObject] coordinate]
																				  title:[[self.producers lastObject] producerCode]
																		 annotationType:UICRouteAnnotationTypeEnd number:([self.producers count])];
	
	if ([_wayPoints count] > 0) {
		NSInteger numberOfRoutes = [directions numberOfRoutes];
		for (NSInteger index = 0; index < numberOfRoutes; index++) {
			UICGRoute *route = [directions routeAtIndex:index];
			CLLocation *location = [route endLocation];
			UICRouteAnnotation *annotation = [[UICRouteAnnotation alloc] initWithCoordinate:[location coordinate]
																					   title:[[self.producers objectAtIndex:(index +1)] producerCode]
																			  annotationType:UICRouteAnnotationTypeEnd number:(index + 2)];
			NSLog(@"%@", [[self.producers objectAtIndex:index] producerCode]);
			[_directionsMapView addAnnotation:annotation];
		}
	}
	*/
	
	if ([_wayPoints count] > 0) {
		NSInteger numberOfRoutes = [directions numberOfRoutes];
		for (Producer *producer in self.producers) {
			@autoreleasepool {
			CLLocation *location = [[CLLocation alloc] initWithLatitude:producer.latitudeValue longitude:producer.longitudeValue];
			UICRouteAnnotation *annotation = [[UICRouteAnnotation alloc] initWithCoordinate:[location coordinate]
																					  title:[producer producerCode]
																			 annotationType:UICRouteAnnotationTypeEnd number:([self.producers indexOfObject:producer] + 1)];
			[_directionsMapView addAnnotation:annotation];
			}
		}
	}
	
	//[_directionsMapView addAnnotations:[NSArray arrayWithObjects:startAnnotation, endAnnotation, nil]];
}

- (void)directions:(UICGDirections *)directions didFailWithMessage:(NSString *)message {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Map Directions" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
	[alertView show];
}

@end
