//
//  IHActionTableViewCell.m
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHActionTableViewCell.h"

@implementation IHActionTableViewCell
@synthesize titleLab,photoView,timeLabel,localLabel,classLabel,leaderLabel,insteLabel,addedLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bannerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.contentView.frame.size.width, 30)];
        [bannerView setBackgroundColor:[UIColor clearColor]];
        titleLab = [[UILabel alloc] initWithFrame:bannerView.frame];
        titleLab.text = @"百度开放云编程马拉松";
        titleLab.font = [UIFont systemFontOfSize:12];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [bannerView addSubview:titleLab];
        [self.contentView addSubview:bannerView];
        
        tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.contentView.frame.size.width, 90)];
        photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
        photoView.image = [UIImage imageNamed:@"20115201212718777801.jpg"];
        [tipView addSubview:photoView];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, tipView.frame.size.width - 90, 20)];
        timeLabel.text = @"时间：10-12 90:10 -- 10-14 10:11";
        timeLabel.font = [UIFont systemFontOfSize:12];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:timeLabel];
        
        localLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, tipView.frame.size.width - 90, 20)];
        localLabel.text = @"地址：北京 东城区 东区 保利剧院";
        localLabel.font = [UIFont systemFontOfSize:12];
        [localLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:localLabel];
        
        classLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, tipView.frame.size.width - 90, 20)];
        classLabel.text = @"类别：开发";
        classLabel.font = [UIFont systemFontOfSize:12];
        [classLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:classLabel];
        
        leaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 70, 90, 20)];
        leaderLabel.text = @"joe 创建";
        leaderLabel.font = [UIFont systemFontOfSize:12];
        [leaderLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:leaderLabel];
        
        insteLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 70, 90, 20)];
        insteLabel.text = @"3000 感兴趣";
        insteLabel.font = [UIFont systemFontOfSize:12];
        [insteLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:insteLabel];
        
        addedLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 70, 90, 20)];
        addedLabel.text = @"900 参加";
        addedLabel.font = [UIFont systemFontOfSize:12];
        [addedLabel setBackgroundColor:[UIColor clearColor]];
        [tipView addSubview:addedLabel];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0 green:220 blue:0 alpha:0]];
        [tipView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:tipView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
