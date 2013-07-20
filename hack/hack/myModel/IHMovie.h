//
//  IHMovie.h
//  hack
//
//  Created by 靳晓童 on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHAction.h"

@interface IHMovie : NSObject
{
    IHAction *action;
    IHUser *user;
    NSInteger size;
    NSDate *time;
    NSString *fileUrl;
}
@property (nonatomic,retain) IHAction *action;
@property (nonatomic,retain) IHUser *user;
@property (nonatomic,assign) NSInteger size;
@property (nonatomic,retain) NSDate *time;
@property (nonatomic,retain) NSString *fileUrl;

@end
