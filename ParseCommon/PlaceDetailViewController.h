//
//  VenueDetailViewController.h
//  FSQProject
//
//  Created by David Tseng on 2/11/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>


@interface PlaceDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mpView;
@property PFObject *currentPlace;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UIButton *btnRoute;
- (IBAction)btnRouteToPlace:(id)sender;

@end
