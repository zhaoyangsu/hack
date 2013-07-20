//
//  detailViewController.h
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
{
    UILabel *actionName;
    UILabel *startTime;
    UILabel *endTime;
    UILabel *insertCount;
     
    
    NSMutableArray *photoArr;
    NSMutableArray *audioArr;
    NSMutableArray *videoArr;
}

@property(nonatomic,strong)IBOutlet UILabel *actionName;
@property(nonatomic,strong)IBOutlet UILabel *startTime;
@property(nonatomic,strong)IBOutlet UILabel *endTime;
@property(nonatomic,strong)IBOutlet UILabel *insertCount;

@property(nonatomic,strong)NSMutableArray *photoArr;
@property(nonatomic,strong)NSMutableArray *audioArr;
@property(nonatomic,strong)NSMutableArray *videoArr;
@end
