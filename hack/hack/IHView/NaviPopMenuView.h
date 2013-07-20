//
//  NaviPopMenuView.h
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)();

#define KNotificationPopMenuDismiss    @"PopMenuDismiss"

@interface NaviPopMenuItem : NSObject
@property (nonatomic, copy) selectBlock block;
@property (nonatomic, strong) NSString *title;
- (id)initWithTitle:(NSString *)title block:(selectBlock)block;
@end

@interface NaviPopMenuView : UIView
@property (nonatomic, strong) NSMutableArray *items;

- (id)initWithItems:(NSArray *)items naviHeigth:(CGFloat)heght;
- (void)showInView:(UIView *)view;
- (void)dismissView;
@end
