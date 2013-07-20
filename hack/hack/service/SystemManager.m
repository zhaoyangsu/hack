//
//  SystemManager.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "SystemManager.h"

@implementation SystemManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SystemManager)

- (IHUser *)user
{
    if (!_user)
    {
        _user = [[IHUser alloc]init];
        _user.userId = 1;
        _user.userName = @"宿召阳";
    }
    return _user;
}
@end

