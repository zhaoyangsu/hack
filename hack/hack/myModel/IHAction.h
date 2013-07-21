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
#import "BMKAnnotation.h"

@interface IHAction : NSObject<NSCopying,BMKAnnotation>
{
//    IHActionType *type;
//    IHUser *leaderUser;
//    
//    NSString *actionName;
//    NSString *actionHeaderPhoto;
//    NSString *actionTip;
//    NSString *actionPosition;
//    NSMutableDictionary *positionDic;
//    
//    NSMutableArray *photoes;
//    NSMutableArray *audioes;
//    NSMutableArray *vieos;
//    
//    NSInteger addedNum;
//    NSInteger insterNum;
//    
//    NSDate *createTime;
//    NSDate *startTime;
//    NSDate *endTime;
}

@property (nonatomic, strong) IHActionType *type;
@property (nonatomic, strong) IHUser *leaderUser;
@property (nonatomic, assign) int64_t itemId;

@property (nonatomic, strong) NSString *actionName;
@property (nonatomic, strong) NSString *actionHeaderPhoto;
@property (nonatomic, strong) NSString *actionTip;
@property (nonatomic, strong) NSString *actionPosition;
//@property (nonatomic,retain) NSMutableDictionary *positionDic;

@property (nonatomic, strong) NSMutableArray *photoes;
@property (nonatomic, strong) NSMutableArray *audioes;
@property (nonatomic, strong) NSMutableArray *videos;

@property (nonatomic, assign) NSInteger addedNum;
@property (nonatomic, assign) NSInteger insterNum;

@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;

- (BOOL)isMine;
@end
