//
//  IHAdapter.m
//  hack
//
//  Created by 靳晓童 on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHAdapter.h"

@implementation IHAdapter
@synthesize adapters;

+(id)sharedAdapter
{
    static id sharedAdapter = nil;
    
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedAdapter = [[self alloc] init];
    });
    
    return sharedAdapter;
}

@end
