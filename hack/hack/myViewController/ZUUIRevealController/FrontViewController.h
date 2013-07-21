//
//  FrontViewController.h
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@interface FrontViewController :UIViewController<ASIHTTPRequestDelegate>
{
    UISegmentedControl *segement;
    ASIHTTPRequest *request;
    ASINetworkQueue *queue;
    NSMutableArray *items;
    NSMutableArray *delegates;
}
@end

@protocol actionReloadDelegate <NSObject>

-(void)reloadActionsWithAdapter:(NSString *)aAdapter;

@end
