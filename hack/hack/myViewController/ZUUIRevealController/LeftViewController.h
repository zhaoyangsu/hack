//
//  LeftViewController.h
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHUser.h"
#import "ASIHTTPRequest.h"
@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UIImageView *userPhotoView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
