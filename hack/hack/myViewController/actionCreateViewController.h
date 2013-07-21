//
//  actionCreateViewController.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Reachability.h"
#import "ASINetworkQueue.h"

@class IHAction;

typedef void(^reslutBlock)(BOOL isDelete,IHAction *action);


@interface actionCreateViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    NSMutableArray *actionTypeArray;
    ASINetworkQueue *queue;
}
@property (nonatomic, retain) UIButton *imageBtn;
@property (nonatomic, retain) UIPickerView *startTimePicker;
@property (nonatomic, retain) UIPickerView *endTimePicker;
@property (nonatomic, retain) UIPickerView *actionTypePicker;
@property (nonatomic, copy) reslutBlock block;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) Reachability *reachability;
- (void)setBlock:(reslutBlock)block;
- (id)initWithAction:(IHAction *)action;
@end
