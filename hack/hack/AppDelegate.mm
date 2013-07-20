//
//  AppDelegate.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "RevealViewController.h"
#import "LeftViewController.h"
#import "FrontViewController.h"

@implementation AppDelegate
BMKMapManager* _mapManager;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    LeftViewController *left = [[LeftViewController alloc]init];
    FrontViewController *front = [[FrontViewController alloc]init];
    RevealViewController *reveal =  [[RevealViewController alloc]initWithFrontViewController:[[UINavigationController alloc]initWithRootViewController: front] rearViewController:[[UINavigationController alloc]initWithRootViewController:left]];
    self.viewController = reveal;
    self.window.rootViewController = reveal;
    [self.window makeKeyAndVisible];
    
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"78D85C187657D438E35980DDAB52A0EFF061AB65" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
