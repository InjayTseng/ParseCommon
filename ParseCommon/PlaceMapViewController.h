//
//  PlaceMapTwoViewController.h
//  GPService
//
//  Created by David Tseng on 2/19/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PlaceMapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (readwrite, nonatomic) CLLocationCoordinate2D targetLocation;
@property (strong, nonatomic) NSArray* nearbyShops;

@end
