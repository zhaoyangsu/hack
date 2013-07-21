//
//  actionTableViewController.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FrontViewController;
@interface actionTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *actionsArray;
}

@property (nonatomic, assign) FrontViewController *frontVC;

@end
