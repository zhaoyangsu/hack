//
//  IHUser.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHUser : NSObject
{
    NSString *userId;
    NSString *userName;
    NSString *userPhoto;
    
    NSMutableArray *friends;
    NSMutableArray *addedActions;
    NSMutableArray *insterActions;
    NSMutableArray *createActions;
}

@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *userPhoto;
@property (nonatomic,retain) NSMutableArray *friends;
@property (nonatomic,retain) NSMutableArray *addedActions;
@property (nonatomic,retain) NSMutableArray *insterActions;
@property (nonatomic,retain) NSMutableArray *createActions;

@end
