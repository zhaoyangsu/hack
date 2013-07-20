//
//  locationViewController.m
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "locationViewController.h"
#import "IHAction.h"

@interface locationViewController ()
@property (nonatomic, assign) BOOL clickAnnotation;

@end

@implementation locationViewController
@synthesize mapView = _mapView;
@synthesize userLocation = _userLocation;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self .view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 50, 50)];
    [btn addTarget:self action:@selector(toCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view from its nib.
    _mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    
}
#pragma mark -
- (void)toCurrentLocation
{
    [UIView animateWithDuration:1.0 animations:^{
    [_mapView setCenterCoordinate:_userLocation.location.coordinate animated:YES ] ;

    }];
   
}
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    _userLocation = userLocation;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _mapView.delegate = nil;
}

#pragma mark -
#pragma mark mapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    self.clickAnnotation = YES;
}


- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    if (!self.clickAnnotation)
    {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = coordinate;
        annotation.title = @"";
        [_mapView addAnnotation:annotation];
    }
    else
    {
        self.clickAnnotation = NO;
    }
}

- (void)goToDetail:(IHAction *)action
{
    
}

@end
