//
//  actionTableViewController.m
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "actionTableViewController.h"
#import "IHActionTableViewCell.h"

@interface actionTableViewController ()

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
    UITableView *actionTable = [[UITableView alloc] initWithFrame:self.view.frame];
    actionTable.delegate = self;
    actionTable.dataSource = self;
    [self.view addSubview:actionTable];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    }
    return cell;
}

@end
