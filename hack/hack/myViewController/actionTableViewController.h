//
//  actionTableViewController.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface actionTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *actionsArray;
}

@end
