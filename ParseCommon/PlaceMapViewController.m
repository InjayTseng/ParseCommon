//
//  PlaceMapTwoViewController.m
//  GPService
//
//  Created by David Tseng on 2/19/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PlaceMapViewController.h"
#import "OData.h"
#define DEFAULT_LAT 25.032609
#define DEFAULT_LON 121.558727
#define TAG_LBTEXT 111

@interface PlaceMapViewController ()

@end

@implementation PlaceMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //沒給TargetLocation就預設目前位子
    if (self.targetLocation.latitude == 0 || self.targetLocation.longitude == 0) {
        self.targetLocation = [[OData sharedManager] myLocation];
    }
    
    MKCoordinateRegion region;
    region.center = self.targetLocation;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    
//    MKPointAnnotation *target = [[MKPointAnnotation alloc] init];
//    CLLocationCoordinate2D loc = self.targetLocation;
//    target.coordinate = loc;
//    target.title = @"我的位置";
//    [self.mapView addAnnotation:target];

    [self addPlaceAnnotations];
    
    self.mapView.delegate = self;
    [self.mapView setRegion:region animated:YES];
    [self.mapView setShowsUserLocation:YES];
    
}

-(void)addPlaceAnnotations{
    
    
    
    for (PFObject* place in self.nearbyShops){
        
        PFGeoPoint* gp = [place objectForKey:@"location"];
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(gp.latitude, gp.longitude);
        point.coordinate = loc;
        point.title = place[@"type"];;
        point.subtitle = place[@"name"];
        [self.mapView addAnnotation:point];
    }
    
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

    if (annotation == mapView.userLocation) {
        return nil;
    }
    
    static NSString *viewId = @"MKPinAnnotationView";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
    UILabel * lbNumber;
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc]
                          initWithAnnotation:annotation reuseIdentifier:viewId];
        lbNumber = [[UILabel alloc]initWithFrame:CGRectMake(-30,-40, 100, 30)];
        [lbNumber setAlpha:0.9];
        //[lbNumber setTextColor:[UIColor colorWithRed:79./255. green:154./255. blue:234./255. alpha:1.]];
        [lbNumber setTextColor:[UIColor darkGrayColor]];
        [lbNumber setBackgroundColor:[UIColor whiteColor]];
        [lbNumber setFont:[UIFont boldSystemFontOfSize:14]];
        [lbNumber setTag:TAG_LBTEXT];
        lbNumber.shadowColor = [UIColor whiteColor];
        lbNumber.shadowOffset = CGSizeMake(-1.0, -3.0);
        lbNumber.layer.cornerRadius = 5.0f;
        lbNumber.layer.masksToBounds = NO;
        lbNumber.layer.borderWidth = 0.0f;
        [lbNumber setTextAlignment:NSTextAlignmentCenter];
        [annotationView addSubview:lbNumber];
    }
    
    lbNumber = (UILabel*)[annotationView viewWithTag:TAG_LBTEXT];
    NSString* show  = [annotation subtitle];
    PFObject* place = [self getPlaceByName:show];
    [lbNumber setText:place[@"type"]];
    
    UIButton*myButton =[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    myButton.frame =CGRectMake(0,0,40,40);
    [myButton addTarget:self action:@selector(annotaionViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myButton setRestorationIdentifier:[annotation title]];
    annotationView.rightCalloutAccessoryView = myButton;
    annotationView.canShowCallout = YES;
    
    return annotationView;
    
}

-(void)annotaionViewClicked:(id)sender{
    
//    UIButton *btn = sender;
//    //    NSLog(@"sender %@",btn.restorationIdentifier);
//    //Site *site = [[DataManager shareInstance] searchSiteByTitle:btn.restorationIdentifier];
//    //[self navigatesToDetailbySite:site];
//    GPlace *place = [self getPlaceByname:btn.restorationIdentifier];
//    NSLog(@"Go to %@",place.name);
//    
//    
//    //[self dismissViewControllerAnimated:YES completion:^{
//    //   self.selectBlock(site);
//    //}];
//    UIStoryboard * mainStroyboard = [UIStoryboard storyboardWithName:@"GPMain" bundle:nil];
//    PlaceDetailViewController *dv = [mainStroyboard instantiateViewControllerWithIdentifier:@"PlaceDetailViewController"];
//    
//    [dv setCurrentPlace:place];
//    [self.navigationController pushViewController:dv animated:YES];
    
}

//-(GPlace*)getPlaceByname:(NSString*)name{
//    
//    for (GPlace *place in [[GPData sharedInstance] nearbyPlaces]){
//        
//        if ([place.name isEqualToString:name]) {
//            
//            return place;
//        }
//    }
//    return nil;
//}


-(PFObject*)getPlaceByName:(NSString*)name{

    for (PFObject* obj in self.nearbyShops){
        if ([name isEqualToString:obj[@"name"]]) {
            return obj;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
