//
//  IHActionTableViewCell.h
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IHActionTableViewCell : UITableViewCell
{
    UIView *bannerView;
    UILabel *titleLab;
    
    UIView *tipView;
    UIImageView *photoView;
    UILabel *timeLabel;
    UILabel *localLabel;
    UILabel *classLabel;
    
    UILabel *leaderLabel;
    UILabel *insteLabel;
    UILabel *addedLabel;
}

@property (nonatomic,retain) UILabel *titleLab;

@property (nonatomic,retain) UIImageView *photoView;
@property (nonatomic,retain) UILabel *timeLabel;
@property (nonatomic,retain) UILabel *localLabel;
@property (nonatomic,retain) UILabel *classLabel;

@property (nonatomic,retain) UILabel *leaderLabel;
@property (nonatomic,retain) UILabel *insteLabel;
@property (nonatomic,retain) UILabel *addedLabel;

@end
