//
//  detailViewController.h
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHAction.h"
#import <UIKit/UIKit.h>
<<<<<<< HEAD
#import "ASIHTTPRequest.h"
=======
#import "ASIHTTPRequestDelegate.h"
>>>>>>> 08fa1c0cd6851ec7bb11b8ba2949b2346b5dae73
@interface detailViewController : UIViewController <ASIHTTPRequestDelegate>
{
    IHAction *detailAction;
    
    UILabel *leaderUserName;
    UILabel *actionName;
    UILabel *actionTime;
    UILabel *actionType;
    UILabel *insertCount;
    
    UIImageView *acionImageView;
    UITextView *actionTip;
//    
//    UIPageControl *photoesPage;
//    UIPageControl *audioesPage;
//    UIPageControl *videosPage;
    
    NSMutableArray *photoArr;
    NSMutableArray *audioArr;
    NSMutableArray *videoArr;
    
    UIButton *addedBtn;
}

@property (nonatomic,strong) IHAction *detailAction;
@property (nonatomic,strong) IBOutlet UILabel *leaderUserName;
@property(nonatomic,strong)IBOutlet UILabel *actionName;
@property(nonatomic,strong)IBOutlet UILabel *actionTime;
@property (nonatomic,strong) IBOutlet UILabel *actionType;
@property(nonatomic,strong)IBOutlet UILabel *insertCount;

@property (nonatomic,strong) IBOutlet UIImageView *actionImageView;
@property (nonatomic,strong) IBOutlet UITextView *actionTip;

//@property (nonatomic,strong) IBOutlet UIPageControl *photoesPage;
//@property (nonatomic,strong) IBOutlet UIPageControl *audioesPage;
//@property (nonatomic,strong) IBOutlet UIPageControl *videosPage;

@property(nonatomic,strong)NSMutableArray *photoArr;
@property(nonatomic,strong)NSMutableArray *audioArr;
@property(nonatomic,strong)NSMutableArray *videoArr;

@property (nonatomic,strong) IBOutlet UIButton *addedBtn;

- (id)initWithAction:(IHAction *)aAction;

@end
