//
//  LeftViewController.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "LeftViewController.h"
#import "locationViewController.h"

#define LABELTITLETAG 200

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userPhotoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 90, 90)];
    userPhotoView.image = [UIImage imageNamed:@"00151816.jpg"];
    [self.view addSubview:userPhotoView];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:@"个人信息", @"我的朋友",@"我的活动",@"设置", nil];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2)];
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view setBackgroundColor:[UIColor grayColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableView methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 47;
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseableId = @"tableViewCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseableId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseableId];
        UILabel *textLab = [[UILabel alloc] initWithFrame:cell.contentView.frame];
        textLab.font = [UIFont systemFontOfSize:16];
        [textLab setTextColor:[UIColor lightGrayColor]];
        textLab.tag = LABELTITLETAG;
        [cell.contentView addSubview:textLab];
    }
    UILabel *textLab = (UILabel *)[cell.contentView viewWithTag:LABELTITLETAG];
    textLab.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

@end
