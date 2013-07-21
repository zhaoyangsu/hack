//
//  locationViewController.m
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "locationViewController.h"
#import "IHAction.h"
#import "detailViewController.h"
#import "actionCreateViewController.h"
#import "SystemManager.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
	int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}
//
@end


@interface locationViewController ()
@property (nonatomic, assign) BOOL clickAnnotation;
@property (nonatomic, strong) UIView *toolBarView;

@end

@implementation locationViewController
@synthesize mapView = _mapView;
//@synthesize userLocation = _userLocation;
@synthesize toolBarView = _toolBarView;
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
    self.dataSource = [[NSMutableArray alloc]init];
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self .view addSubview:_mapView];
    _mapView.showsUserLocation = YES;

    // Do any additional setup after loading the view from its nib.
    _mapView.delegate = self;
//    _search = [[BMKSearch alloc]init];
//    _search.delegate = self;
    
    _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 50)];
    [_toolBarView setBackgroundColor:[UIColor whiteColor]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(10, 10, 50, 30)];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:btn];
    
    UIButton *toDesbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [toDesbtn setFrame:CGRectMake(self.view.bounds.size.width - 70, 10, 60, 30)];
    [toDesbtn setTitle:@"到这儿去" forState:UIControlStateNormal];
    [toDesbtn addTarget:self action:@selector(toDestication) forControlEvents:UIControlEventTouchUpInside];
    [_toolBarView addSubview:toDesbtn];
    
//    localLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, self.view.bounds.size.width - 80, 30)];
//    [localLab setBackgroundColor:[UIColor clearColor]];
//    [_toolBarView addSubview:localLab];
    
    _toolBarView.alpha = 0.7;
    [self.view addSubview:_toolBarView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
//    [_mapView viewWillDisappear];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    for (IHAction *action in self.dataSource)
//    {


    [self displayToolBar];

}
#pragma mark -
- (void)toCurrentLocation
{
    [_mapView setCenterCoordinate:_userLocation.location.coordinate animated:YES ] ;
 //   [self  goToDetail:nil];
    
}
- (void)toDestication
{
    [self goToDetail:nil];
}
- (void)displayToolBar
{
    [UIView animateWithDuration:0.4 animations:^{
        [_toolBarView setFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    }];

}
#pragma mark - 
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)aUserLocation
{
    _userLocation = aUserLocation;
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
    if ([annotation isKindOfClass:[IHAction class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = NO;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    endPoint = view.annotation.coordinate;
     [_mapView setCenterCoordinate:endPoint animated:YES ] ;
    [self performSelector:@selector(displayToolBar) withObject:nil afterDelay:0];
//   [self displayToolBar];
    self.clickAnnotation = YES;
}



- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate
{
    if (!self.clickAnnotation)
    {
        IHAction *action = [[IHAction alloc]init];
        action.coordinate = coordinate;
        action.actionTip = @"";
        action.leaderUser = [SystemManager sharedInstance].user;
        [self.dataSource addObject:action];
        
        
//        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
//        annotation.coordinate = coordinate;
//        annotation.title = @"";
        [_mapView addAnnotation:action];
    }
    else
    {
        self.clickAnnotation = NO;
    }
}
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[IHAction class]])
    {
        actionCreateViewController *actionVC = [[actionCreateViewController alloc]initWithAction:(IHAction *)view.annotation];
        [actionVC setBlock:^(BOOL isDelete, IHAction *action) {
            if (isDelete)
            {
                [mapView removeAnnotation:view.annotation];
            }
            else
            {
                ((IHAction *)view.annotation).actionTip = action.actionTip;
                ((IHAction *)view.annotation).leaderUser.userPhoto = action.leaderUser.userPhoto;
//                [self.dataSource removeObject:view.annotation];
//                [self.dataSource addObject:action];
            }
        }];
        
        [self.frontVC.navigationController pushViewController:actionVC animated:YES];
//        detailViewController *detail = [[detailViewController alloc]initWithNibName:@"detailViewController" bundle:nil];
//        [self presentModalViewController:detail animated:YES];

    }
    
//    detailViewController *detail = [[detailViewController alloc]initWithNibName:@"detailViewController" bundle:nil];
//    [self.navigationController pushViewController:detail animated:YES];
}
- (void)goToDetail:(IHAction *)action
{
    CLLocationCoordinate2D startPt = (CLLocationCoordinate2D){_userLocation.location.coordinate.latitude, _userLocation.location.coordinate.longitude};
	CLLocationCoordinate2D endPt = (CLLocationCoordinate2D){endPoint.latitude, endPoint.longitude};
	
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = startPt;
	
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.pt = endPt;
	BOOL flag = [_search walkingSearch:nil startNode:start endCity:nil endNode:end];
	if (flag) {
		NSLog(@"search success.");
	}
    else{
        NSLog(@"search failed!");
    }

}
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
//		item.title = @"起点";
		item.type = 0;
//		[_mapView addAnnotation:item];
		
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
//				[_mapView addAnnotation:item];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
//		item.title = @"终点";
//		[_mapView addAnnotation:item];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
        
        [_mapView setCenterCoordinate:result.startNode.pt animated:YES];
	}
}
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"] ;
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
            view.image = nil;
			view.annotation = routeAnnotation;
//
		}
			break;
        case 5:
        {
//            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"waypoint_node"];
//			if (view == nil) {
//				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"waypoint_node"] ;
//				view.canShowCallout = TRUE;
//			} else {
//				[view setNeedsDisplay];
//			}
//			
//			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_waypoint.png"]];
//			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
//			view.annotation = routeAnnotation;
        }
            break;
		default:
			break;
	}
	
	return view;
}


- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

@end
