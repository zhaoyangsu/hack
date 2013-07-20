//
//  IHAction.m
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHAction.h"

@implementation IHAction
//@synthesize type,leaderUser;
//@synthesize actionName,actionHeaderPhoto,actionTip,actionPosition,positionDic;
//@synthesize photoes,audioes,videos;
//@synthesize addedNum,insterNum;
//@synthesize createTime,startTime,endTime;


- (BOOL)isMine
{
    if ([SystemManager sharedInstance].user.userId == self.leaderUser.userId)
    {
        return YES;
    }
    return NO;
}

- (id)copyWithZone:(NSZone *)zone
{
    IHAction *action = [[self class]allocWithZone:zone];
    action.type = self.type;
    action.leaderUser = self.leaderUser;
    action.itemId = self.itemId;
    action.actionName = self.actionName;
    action.actionHeaderPhoto = self.actionHeaderPhoto;
    action.actionTip = self.actionTip;
    action.actionPosition = self.actionPosition;
    action.positionDic = self.positionDic;
    action.photoes = self.photoes;
    action.audioes = self.audioes;
    action.videos = self.videos;
    action.addedNum = self.addedNum;
    action.insterNum = self.insterNum;
    action.createTime = self.createTime;
    action.endTime = self.endTime;
    return action;
}

@end
