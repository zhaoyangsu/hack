//
//  FrontViewController.h
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontViewController :UITabBarController<UITableViewDataSource,UITableViewDelegate>
{
    UISegmentedControl *segement;
}
@end
