//
//  IHAction.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHUser.h"
#import "IHActionType.h"

@interface IHAction : NSObject

{
    IHActionType *type;
    IHUser *leaderUser;
    
    NSString *actionName;
    NSString *actionHeaderPhoto;
    NSString *actionTip;
    NSString *actionPosition;
    NSMutableDictionary *positionDic;
    
    NSMutableArray *photoes;
    NSMutableArray *audioes;
    NSMutableArray *vieos;
    
    NSInteger addedNum;
    NSInteger insterNum;
    
    NSDate *createTime;
    NSDate *startTime;
    NSDate *endTime;
}

@property (nonatomic,retain) IHActionType *type;
@property (nonatomic,retain) IHUser *leaderUser;

@property (nonatomic,retain) NSString *actionName;
@property (nonatomic,retain) NSString *actionHeaderPhoto;
@property (nonatomic,retain) NSString *actionTip;
@property (nonatomic,retain) NSString *actionPosition;
@property (nonatomic,retain) NSMutableDictionary *positionDic;

@property (nonatomic,retain) NSMutableArray *photoes;
@property (nonatomic,retain) NSMutableArray *audioes;
@property (nonatomic,retain) NSMutableArray *videos;

@property (nonatomic,assign) NSInteger addedNum;
@property (nonatomic,assign) NSInteger insterNum;

@property (nonatomic,retain) NSDate *createTime;
@property (nonatomic,retain) NSDate *startTime;
@property (nonatomic,retain) NSDate *endTime;
@end
