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
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation locationViewController
@synthesize mapView = _mapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self .view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
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
