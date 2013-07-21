//
//  actionTableViewController.m
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "actionTableViewController.h"
#import "IHActionTableViewCell.h"
#import "detailViewController.h"
#import "IHAction.h"
#import "actionCreateViewController.h"
#import "FrontViewController.h"

@interface actionTableViewController ()
@property (nonatomic, strong) NSMutableArray *dateSeouce;
@end

@implementation actionTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dateSeouce = [[NSMutableArray alloc]initWithCapacity:8];
    for (NSInteger i = 0; i < 8; i++)
    {
        IHAction *action = [[IHAction alloc]init];
        IHUser *user = [[IHUser alloc]init];
        user.userId = i;
        user.userPhoto = @"20115201212718777801.jpg";
        action.leaderUser = user;
        [self.dateSeouce addObject:action];
    }
    NSLog(@"%@",self.view);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseableId = @"tableViewCell";
    IHActionTableViewCell *cell = (IHActionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseableId];
    if (cell == nil)
    {
        cell = [[IHActionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableId];
        cell.clipsToBounds = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IHAction *action = self.dateSeouce[indexPath.row];
    detailViewController *actionVC = [[detailViewController alloc]initWithAction:action];
    [self.frontVC.navigationController pushViewController:actionVC animated:YES];
}

@end
