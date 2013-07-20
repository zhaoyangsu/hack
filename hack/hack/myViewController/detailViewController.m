//
//  detailViewController.m
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//
#import "IHAction.h"
#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController
@synthesize actionName = _actionName;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize insertCount = _insertCount;
@synthesize photoArr = _photoArr;
@synthesize audioArr = _audioArr;
@synthesize videoArr = _videoArr;
- (id)initWithAction:(IHAction *)aAction
{
    self = [super initWithNibName:@"detailViewController" bundle:nil];
    if (self) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat : @"yyyy年M月d日 H点m分"];
        
        _actionName.text = aAction.actionTip;
//        _startTime.text = [formatter stringFromDate:dateNow];
//        _endTime.text = [formatter stringFromDate:dateNow];
        _insertCount = [NSString stringWithFormat:@"%d",aAction.insterNum ]; 
   // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
