//
//  OpenVoiceDataViewController.m
//  ParseCommon
//
//  Created by David Tseng on 2014/3/13.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import "OpenVoiceDataViewController.h"
#import "NearyByShopsViewController.h"
#import "DTParse.h"

@interface OpenVoiceDataViewController ()
- (IBAction)btnGetShopClicked:(id)sender;

@end

@implementation OpenVoiceDataViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGetShopClicked:(id)sender {
    
    
    [DTParse shopByLocation:CLLocationCoordinate2DMake(25.0693449,  121.5168249) andRange:0.5 WithSuccess:^(NSArray *objectArray) {
        
        NearyByShopsViewController* nv = [self.storyboard instantiateViewControllerWithIdentifier:@"NearyByShopsViewController"];
        [nv setNearbyShops:objectArray];
        [self.navigationController pushViewController:nv animated:YES];
        
    } withFailure:^(NSError *err) {
        
    }];
    
}
@end
