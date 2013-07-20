//
//  IHAction.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHActionType.h"
#import "IHUser.h"

@interface IHAction : NSObject
{
    IHActionType *type;    //活动类型
    NSString *actionId;    //活动id
    NSString *actionTitle; //活动名称
    NSString *actionTips;  //活动简介
    IHUser *addedUser;     //活动发起人
    NSInteger instertNum;  //感兴趣人数
    NSInteger addedNum;    //参加人数
    NSString *actionPos;   //活动地点
    NSMutableDictionary *positionDic; //活动地点信息
    NSMutableArray *photoes;  //活动图片资料
    NSMutableArray *audioes;  //活动声音资料
    NSMutableArray *videos;   //活动视频资料
    NSTimer *addTime;    //活动添加时间
    NSTimer *startTime;  //活动开始时间
    NSTimer *endTime;    //活动结束时间
    NSString *actionPhotoPath; //活动头像
}
@property (nonatomic,retain) IHActionType *type;
@property (nonatomic,retain) NSString *actionId;
@property (nonatomic,retain) NSString *actionTitle;
@property (nonatomic,retain) NSString *actionTips;
@property (nonatomic,retain) IHUser *addedUser;
@property (nonatomic,assign) NSInteger instertNum;
@property (nonatomic,assign) NSInteger addedNum;
@property (nonatomic,retain) NSString *actionPos;
@property (nonatomic,retain) NSMutableDictionary *positionDic;
@property (nonatomic,retain) NSMutableArray *photoes;
@property (nonatomic,retain) NSMutableArray *audioes;
@property (nonatomic,retain) NSMutableArray *videos;
@property (nonatomic,retain) NSTimer *addTime;
@property (nonatomic,retain) NSTimer *startTime;
@property (nonatomic,retain) NSTimer *endTime;
@property (nonatomic,retain) NSString *actionPhotoPath;

@end
