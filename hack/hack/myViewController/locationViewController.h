//
//  locationViewController.h
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "FrontViewController.h"

@interface locationViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate,actionReloadDelegate>
{
    BMKMapView *mapView;
    BMKUserLocation *userLocation;
    CLLocationCoordinate2D endPoint;
    BMKSearch* _search;
    UILabel *localLab;
    BMKUserLocation *targetPoint;
}
@property(nonatomic,strong)BMKMapView *mapView;
@property(nonatomic,strong)BMKUserLocation *userLocation;
@property (nonatomic, assign) UIViewController *frontVC;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
