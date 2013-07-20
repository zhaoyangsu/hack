//
//  FrontViewController.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "FrontViewController.h"
#import "RevealViewController.h"
#import "NaviPopMenuView.h"
#import "actionCreateViewController.h"
#import "IHActionTableViewCell.h"
#import "locationViewController.h"
#import "actionTableViewController.h"

typedef enum
{
    EViewTypeMap,
    EViewTypeList
}
ViewType;

#define KTitleViewTag      10001

@interface FrontViewController ()
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) NaviPopMenuView *popMenuView;
@end

@implementation FrontViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}


- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.tabBar.hidden = YES;
   
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}


    segement = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"地图",@"列表", nil]];
    segement.selectedSegmentIndex = 0;
    [segement addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    segement.segmentedControlStyle = UISegmentedControlStyleBar;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:segement];
    self.navigationItem.rightBarButtonItem = item;
    
    self.titleBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.titleBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [self.titleBtn sizeToFit];
    self.titleBtn.tag = KTitleViewTag;
    [self.titleBtn addTarget:self action:@selector(showManuList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.titleBtn;


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    NSArray *gestureArr = [[NSMutableArray alloc]initWithArray: self.view.gestureRecognizers];
    for (UIGestureRecognizer *gesture in gestureArr)
    {
        [self.view removeGestureRecognizer:gesture];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    locationViewController *locatioVC = [[locationViewController alloc]init];
    [self addChildViewController:locatioVC];
    actionTableViewController *actionVC = [[actionTableViewController alloc]init];
    [self addChildViewController:actionVC];
    self.selectedIndex = 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [segement setSelectedSegmentIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)changeView:(UISegmentedControl *)sender
{

//    switch (sender.selectedSegmentIndex)
//    {
//        case EViewTypeMap:
//        {
//            [self setSelectedIndex:sender.selectedSegmentIndex];
//            break;
//        }
//        case EViewTypeList:
//        {
//            NSLog(@"Show List");
//            break;
//        }
//        default:
//            break;
//    }
    [self setSelectedIndex:sender.selectedSegmentIndex];
}


#pragma mark - custom methods
- (void)showManuList
{
    if (!_popMenuView)
    {
        NSMutableArray *items = [[NSMutableArray alloc]init];
        NaviPopMenuItem *item = [[NaviPopMenuItem alloc]initWithTitle:@"test1" block:^{
            NSLog(@"test1");
        }];
        [items addObject:item];
        NaviPopMenuItem *test2 = [[NaviPopMenuItem alloc]initWithTitle:@"test2" block:^{
            NSLog(@"test2");
        }];
        [items addObject:test2];
        _popMenuView = [[NaviPopMenuView alloc]initWithItems:items naviHeigth:self.navigationController.navigationBar.frame.size.height];
    }
    if (_popMenuView.superview)
    {
        [_popMenuView dismissView];
    }
    else
    {
        [_popMenuView showInView:self.navigationController.view];
    }
}

@end
