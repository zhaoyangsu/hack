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
#import "JSONKit.h"
#import "IHAdapter.h"

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
@property (nonatomic, assign) NSInteger selected;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@end

@implementation FrontViewController



- (id)init
{
    if (self = [super init])
    {
        items = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
   
//    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
//	{
		UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
		[self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
		
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"三", @"三") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
	}
    
    
//	}


    segement = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"列表",@"地图", nil]];
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

-(void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    for (UIViewController *viewController in self.viewControllers)
    {
        [viewController removeFromParentViewController];
    }
    [self.viewControllers removeAllObjects];
    NSArray *gestureArr = [[NSMutableArray alloc]initWithArray: self.view.gestureRecognizers];
    for (UIGestureRecognizer *gesture in gestureArr)
    {
        [self.view removeGestureRecognizer:gesture];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    if (!self.viewControllers) {
        self.viewControllers = [[NSMutableArray alloc]initWithCapacity:2];
        locationViewController *locatioVC = [[locationViewController alloc]init];
        //    [self addChildViewController:locatioVC];
        actionTableViewController *actionVC = [[actionTableViewController alloc]init];
        actionVC.frontVC = self;
        [actionVC.view setFrame:self.view.bounds];
        [self.viewControllers addObject:actionVC];
        [self.viewControllers addObject:locatioVC];
        locatioVC.frontVC = self;
        //    [self addChildViewController:actionVC];
        [locatioVC.view setFrame:self.view.bounds];
        [self.view addSubview:actionVC.view];

    }
    //    NSInteger index = segement.selectedSegmentIndex;
        self.selected = segement.selectedSegmentIndex;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setSelected:(NSInteger)selectedIndex
{
    if (_selected != selectedIndex)
    {
        UIViewController *oldController = self.viewControllers[_selected];
        switch (_selected)
        {
            case EViewTypeMap:
            {
                _selected = selectedIndex;
                
                break;
            }
            case EViewTypeList:
            {
                _selected = selectedIndex;
                break;
            }
            
            default:
                return;
                break;
        }
        UIViewController *newController = self.viewControllers[selectedIndex];
        newController.view.alpha = 0.0;
        [self.view addSubview:newController.view];
        if ([newController isKindOfClass:[locationViewController class]])
        {
            locationViewController *temp = (locationViewController *)newController;
            [temp.mapView viewWillAppear];
            [temp.mapView addAnnotations:temp.dataSource];
//            [temp viewWillAppear:YES];
        }
        else
        {
            locationViewController *temp = (locationViewController *)oldController;
            [temp.mapView viewWillDisappear];
//            [temp viewWillAppear:YES];
        }
        [UIView animateWithDuration:0.3 animations:^{
            newController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [oldController.view removeFromSuperview];
        }];
    }
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
    [self setSelected:sender.selectedSegmentIndex];
}

#pragma mark - request
-(void)requestForGetType
{
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://actionshare.duapp.com/actionshare/action_type/all.php"]];
    [request setDelegate:self];
    queue = [[ASINetworkQueue alloc] init];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
    [queue addOperation:request];
}

-(void)requestFailed:(ASIHTTPRequest *)aRequest
{
    NSLog(@"%@",aRequest.responseString);
}

-(void)requestFinished:(ASIHTTPRequest *)aRquest
{
    NSString *response = [aRquest responseString];
    NSArray *responseArray = [[response dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
    items = [[NSMutableArray alloc] initWithArray:responseArray];
    [[IHAdapter sharedAdapter] setAdapters:items];
}

#pragma mark - custom methods
- (void)showManuList
{
    if (!_popMenuView)
    {
        NSMutableArray *titleItems = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in items)
        {
            NaviPopMenuItem *item = [[NaviPopMenuItem alloc]initWithTitle:[dic objectForKey:@"name"] block:^{
                for (id<actionReloadDelegate> tempDele in delegates)
                {
                    [tempDele reloadActionsWithAdapter:item.title];
                }
                
            }];
            [titleItems addObject:item];
        }
        
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
