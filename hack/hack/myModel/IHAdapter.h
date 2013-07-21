//
//  IHAdapter.h
//  hack
//
//  Created by 靳晓童 on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHAdapter : NSObject
{
    NSMutableArray *adapters;
}

@property (nonatomic,retain) NSMutableArray *adapters;

+(id)sharedAdapter;

@end
