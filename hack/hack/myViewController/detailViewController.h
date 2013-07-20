//
//  detailViewController.h
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHAction.h"
#import <UIKit/UIKit.h>

@interface detailViewController : UIViewController
{
    IHAction *detailAction;
    
    UILabel *actionName;
    UILabel *startTime;
    UILabel *endTime;
    UILabel *insertCount;
    
    UIPageControl *photoesPage;
    UIPageControl *audioesPage;
    UIPageControl *videosPage;
    
    NSMutableArray *photoArr;
    NSMutableArray *audioArr;
    NSMutableArray *videoArr;
}

@property (nonatomic,strong) IHAction *detailAction;
@property(nonatomic,strong)IBOutlet UILabel *actionName;
@property(nonatomic,strong)IBOutlet UILabel *startTime;
@property(nonatomic,strong)IBOutlet UILabel *endTime;
@property(nonatomic,strong)IBOutlet UILabel *insertCount;

@property (nonatomic,strong) IBOutlet UIPageControl *photoesPage;
@property (nonatomic,strong) IBOutlet UIPageControl *audioesPage;
@property (nonatomic,strong) IBOutlet UIPageControl *videosPage;

@property(nonatomic,strong)NSMutableArray *photoArr;
@property(nonatomic,strong)NSMutableArray *audioArr;
@property(nonatomic,strong)NSMutableArray *videoArr;

- (id)initWithAction:(IHAction *)aAction;

@end
