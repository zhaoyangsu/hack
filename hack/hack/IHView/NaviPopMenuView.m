//
//  NaviPopMenuView.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "NaviPopMenuView.h"
#define KPopMenuTableCellHeight   30
#define KPopMenuTableWidth          200

@implementation NaviPopMenuItem
- (id)initWithTitle:(NSString *)title block:(selectBlock)block
{
    if (self = [super init])
    {
        self.title = title;
        self.block = block;
    }
    return self;
}
@end

@interface NaviPopMenuView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat naviHeight;
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation NaviPopMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}


- (id)initWithItems:(NSArray *)items naviHeigth:(CGFloat)height
{
    if (self == [super init])
    {
        self.items = [[NSMutableArray alloc]initWithArray:items];
        self.naviHeight = height;
    }
    return self;
}


- (void)showInView:(UIView *)view
{
    self.frame = view.bounds;
    CGFloat height = self.items.count * KPopMenuTableCellHeight;
    if (height >  self.frame.size.height - KPopMenuTableCellHeight * 2)
    {
        height = self.frame.size.height - KPopMenuTableCellHeight * 2;
    }
    if (!self.backgroundView)
    {
        self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0.4;
        [self addSubview:self.backgroundView];
    }
    
    if (!self.tableView)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake((self.frame.size.width - KPopMenuTableWidth) / 2, -height + self.naviHeight, KPopMenuTableWidth, height)];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self addSubview:self.tableView];
    }
    if (height < self.items.count * KPopMenuTableCellHeight)
    {
        self.tableView.scrollEnabled = YES;
    }
    else
    {
        self.tableView.scrollEnabled = NO;
    }
   
    
    for (UIView *subView in view.subviews)
    {
        if ([subView isKindOfClass:[UINavigationBar class]])
        {
            [view insertSubview:self belowSubview:subView];
            break;
        }
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake((self.frame.size.width - KPopMenuTableWidth) / 2 , self.naviHeight, self.tableView.frame.size.width, height);
    } completion:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point =  [touch locationInView:self];
    UIView *view = [self hitTest:point withEvent:event];
    if (view  == self.backgroundView)
    {
        [self dismissView];
    }
}

- (void)dismissView
{
    [[NSNotificationCenter defaultCenter]postNotificationName:KNotificationPopMenuDismiss object:nil];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake((self.frame.size.width - KPopMenuTableWidth) / 2, -self.tableView.frame.size.height + self.naviHeight, self.tableView.frame.size.width, self.tableView.frame.size.height);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KPopMenuTableCellHeight;
}


#pragma mark -
#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PopMenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UIView *selectView = [[UIView alloc]initWithFrame:CGRectZero];
        selectView.backgroundColor = [UIColor grayColor];
        cell.selectedBackgroundView = selectView;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    }
    NaviPopMenuItem *item = self.items[indexPath.row];
    cell.textLabel.text = item.title;
    cell.clipsToBounds = YES;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NaviPopMenuItem *item = self.items[indexPath.row];
    if (item.block)
    {
        item.block();
        [self dismissView];
    }
}
@end
