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
    NSMutableArray *addedActions;
    NSMutableArray *insterActions;
    NSString *photoPath;
    NSMutableArray *friendsArray;
}
@property (nonatomic,retain) NSString *userId;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSMutableArray *addedActions;
@property (nonatomic,retain) NSMutableArray *insterActions;
@property (nonatomic,retain) NSString *photoPath;
@property (nonatomic,retain) NSMutableArray *friendsArray;

@end
