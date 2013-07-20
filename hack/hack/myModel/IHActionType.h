//
//  IHActionType.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IHActionType : NSObject
{
    NSString *typeName;
    NSString *typeId;
}

@property (nonatomic,retain) NSString *typeName;
@property (nonatomic,retain) NSString *typeId;

@end
