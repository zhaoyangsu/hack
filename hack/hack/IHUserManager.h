//
//  IHUserManager.h
//  hack
//
//  Created by caoliang on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import <Foundation/Foundation.h>

@interface IHUserManager : NSObject<ASIHTTPRequestDelegate>
{
    NSString *userId;
    NSString *userName;
}
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *userName;

+ (id)shareUserManager;
- (void)archiveToUserDefault;
- (BOOL)isLogIn;
@end
