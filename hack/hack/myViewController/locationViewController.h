//
//  locationViewController.h
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface locationViewController : UIViewController<BMKMapViewDelegate>
{
    BMKMapView *mapView;
}
@property(nonatomic,strong)BMKMapView *mapView;
@end
