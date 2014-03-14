//
//  OData.h
//  ParseCommon
//
//  Created by David Tseng on 2014/3/14.
//  Copyright (c) 2014年 David Tseng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OData : NSObject

@property (nonatomic,strong) CLLocationManager *locationManager;

+ (instancetype)sharedManager;
- (CLLocationCoordinate2D)myLocation;

@end
