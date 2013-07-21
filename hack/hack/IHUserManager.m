//
//  IHUserManager.m
//  hack
//
//  Created by caoliang on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHUserManager.h"

static IHUserManager *shareUserManager = nil;
@implementation IHUserManager
@synthesize userId,userName;

+ (id)shareUserManager
{
    if (nil == shareUserManager) {
        shareUserManager = [[IHUserManager alloc]init];
    }
    return shareUserManager;
}
- (void)archiveToUserDefault
{
   NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
   NSMutableDictionary *userInfoArr = [[NSMutableDictionary alloc]initWithCapacity:0];
   [userInfoArr setObject:userId forKey:@"userID"];
   [userInfoArr setObject:userName forKey:@"userName"];
    
   [accountDefaults setObject:userInfoArr forKey:@"userInfo"];
  [accountDefaults synchronize];
}

- (BOOL)isLogIn
{
   NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    if (nil == [accountDefaults objectForKey:@"userInfo"]) {
        return NO;
    }
    return YES;
}

@end
