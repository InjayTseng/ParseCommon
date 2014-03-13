//
//  ViewController.m
//  GPService
//
//  Created by David Tseng on 2/19/14.
//  Copyright (c) 2014 David Tseng. All rights reserved.
//

#import "NearyByShopsViewController.h"
#import "PlaceMapTwoViewController.h"

@interface NearyByShopsViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbView;


@end

@implementation NearyByShopsViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self rightButtonCreate];
//    [SVProgressHUD showWithStatus: @"讀取中"];
//    [SVProgressHUD showWithStatus:@"讀取中..." maskType:SVProgressHUDMaskTypeClear];
//    
//    [SVProgressHUD showSuccessWithStatus:@"搜尋結果完畢"];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)rightButtonCreate{
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"地圖模式"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(mapModeClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

- (void)mapModeClicked:(id)sender {
    

    PlaceMapTwoViewController *vm = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceMapTwoViewController"];
    [vm setNearbyShops:self.nearbyShops];
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
//        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
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
    
    
    //    cell.textLabel.text = [self.nearbyVenues[indexPath.row] name];
//    FSVenue *venue = self.nearbyVenues[indexPath.row];
//    if (venue.location.address) {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m, %@",
//                                     venue.location.distance,
//                                     venue.location.address];
//    } else {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@m",
//                                     venue.location.distance];
//    }
//    
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
    
//    GPlace *place = self.nearbyVenues[indexPath.row];
//    UIStoryboard * mainStroyboard = [UIStoryboard storyboardWithName:@"GPMain" bundle:nil];
//    PlaceDetailViewController *vv = [mainStroyboard instantiateViewControllerWithIdentifier:@"PlaceDetailViewController"];
//    [vv setCurrentPlace:place];
//    [self.navigationController pushViewController:vv animated:YES];
    
}


@end
