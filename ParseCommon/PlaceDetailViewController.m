//
//  VenueDetailViewController.m
//  FSQProject
//
//  Created by David Tseng on 2/11/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PlaceDetailViewController.h"
#import "SVProgressHUD.h"

@interface PlaceDetailViewController ()

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation PlaceDetailViewController

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

    self.navigationItem.title = self.currentPlace[@"type"];
    self.lbName.text = self.currentPlace[@"name"];
    [self.imgView setFrame:CGRectMake(0, 0, 320, 700)];
    [self mapSetting];
    [self buttonDisplay];
    
}



-(void)buttonDisplay{

    [self setButtonShadow:self.btnRoute];
}


-(void)setButtonShadow:(UIButton*)btn{
    
    btn.layer.cornerRadius = 8.0f;
    btn.layer.masksToBounds = NO;
    btn.layer.borderWidth = 0.0f;
    
    btn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    btn.layer.shadowOpacity = 0.8;
    btn.layer.shadowRadius = 8;
    btn.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);

}

-(void)mapSetting{
    
    [self.mpView setShowsUserLocation:YES];
    self.mpView.layer.cornerRadius = 10.0;
    
    MKCoordinateRegion newRegion;
    PFGeoPoint * gp = self.currentPlace[@"location"];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(gp.latitude, gp.longitude) ;
    newRegion.center = location;
    newRegion.span.latitudeDelta=0.01;
    newRegion.span.longitudeDelta=0.01;
    
    [self.mpView setRegion:newRegion animated:NO];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:location];
    [annotation setTitle: self.currentPlace[@"type"]];
    [self.mpView removeAnnotations:self.mpView.annotations];
    [self.mpView addAnnotation:annotation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRouteToPlace:(id)sender {
    
    PFGeoPoint * gp = self.currentPlace[@"location"];
    [self routeFrom:25.03224425354909 andLon:121.5583175891882 toLocation:gp.latitude andLon:gp.longitude];
    
}

-(void)routeFrom:(double)lat1 andLon:(double)lon1 toLocation:(double)lat2 andLon:(double)lon2{
    
    CLLocationCoordinate2D location1;
    location1.latitude = lat1;
    location1.longitude = lon1;
    
    CLLocationCoordinate2D location2;
    location2.latitude = lat2;
    location2.longitude = lon2;
    
    MKPlacemark *annotation1 = [[MKPlacemark alloc]initWithCoordinate:location1 addressDictionary:nil];
    MKMapItem *curItem = [[MKMapItem alloc]initWithPlacemark:annotation1];
    
    MKPlacemark *annotation2 = [[MKPlacemark alloc]initWithCoordinate:location2 addressDictionary:nil];
    MKMapItem *toItem = [[MKMapItem alloc]initWithPlacemark:annotation2];
    
    NSArray *array = [[NSArray alloc] initWithObjects:curItem,toItem,nil];
    NSDictionary *dicOption = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking,
                                MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES] };
    [MKMapItem openMapsWithItems:array launchOptions:dicOption];
}


@end
