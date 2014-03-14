//
//  ViewController.m
//  GPService
//
//  Created by David Tseng on 2/19/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import "NearyByShopsViewController.h"
#import "PlaceMapViewController.h"
#import "PlaceDetailViewController.h"
#import "SVProgressHUD.h"
#import "DTParse.h"
#import "OData.h"

#define LAT_DEFAULT 25.0693449
#define LON_DEFAULT 121.5168249

@interface NearyByShopsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbView;


@end

@implementation NearyByShopsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    
    //如果沒有從外面設定Shops Data.
    if (self.nearbyShops==nil) {
        
        //Safty
        self.nearbyShops = [NSArray array];
        
        //經緯度沒給, 則取得現在位置.
        if (self.location.longitude == 0. || self.location.latitude == 0. ){
            NSLog(@"不指定位置. 依的現在位置找附近Shops.");
            self.location = [[OData sharedManager] myLocation];
        }else{
            NSLog(@"指定位置.");
        }
        
        //畫面讀取中
        [SVProgressHUD show];
        
        //Call Cloud API
        [DTParse shopByLocation:self.location  andRange:0.5 WithSuccess:^(NSArray *objectArray) {
            
            [self setNearbyShops:objectArray];
            [self.tbView reloadData];
            
            //畫面讀取中消失
            [SVProgressHUD dismiss];
            
        } withFailure:^(NSError *err) {
            
            //畫面讀取中消失
            [SVProgressHUD showErrorWithStatus:@"讀取失敗."];
        }];
        
    }else{
    
        //Data已經設定好,只是顯示.
        [self.tbView reloadData];
        [SVProgressHUD dismiss];
    }
    
    //建立右上角的Button
    [self rightButtonCreate];
}


-(void)rightButtonCreate{
    
    //建立右上角的Button, 按下去會call mapModeClicked.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"地圖模式"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(mapModeClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

- (void)mapModeClicked:(id)sender {

    PlaceMapViewController *vm = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceMapViewController"];
    [vm setNearbyShops:self.nearbyShops];
    [vm setTargetLocation:[[OData sharedManager] myLocation] ];
    [self.navigationController pushViewController:vm animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.nearbyShops.count>1) {
        return self.nearbyShops.count+1;
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if ([self.nearbyShops count] >= 1) {
    
        if (indexPath.row == [self.nearbyShops count]) {
    
            static NSString *MoreCellIdentifier = @"More";
            cell = [tableView dequeueReusableCellWithIdentifier:MoreCellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MoreCellIdentifier];
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }else{
            
            PFObject *place = [self.nearbyShops objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[place objectForKey:@"type"]];
            cell.detailTextLabel.text = place[@"name"];
            
        }
    }
    

    //設定Pin的圖案:
//    NSString* cateFileName = [self saftyFileName:venue.categories];
//    UIImage* lastTimeImage = [self loadImageWithName:cateFileName] ;
//    if (lastTimeImage == nil) {
//        NSURL * imageURL = [NSURL URLWithString:venue.categorieIconUrl];
//        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
//        UIImage * image = [UIImage imageWithData:imageData];
//        [cell.imageView setImage:image];
//        [self saveImage:image andName:cateFileName];
//    }else{
//        
//        [cell.imageView setImage:lastTimeImage];
//    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *place = [self.nearbyShops objectAtIndex:indexPath.row];
    PlaceDetailViewController *vv = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceDetailViewController"];
    [vv setCurrentPlace:place];
    [self.navigationController pushViewController:vv animated:YES];
    
}


@end
