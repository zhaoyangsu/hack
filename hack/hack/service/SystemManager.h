//
//  SystemManager.h
//  hack
//
//  Created by ZhaoyangSu on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IHUser.h"

@interface SystemManager : NSObject
@property (nonatomic, strong) IHUser *user;

+ (SystemManager*) sharedInstance;

@end
