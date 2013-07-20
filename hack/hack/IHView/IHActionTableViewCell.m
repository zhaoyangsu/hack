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
        bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 30)];
        [bannerView setBackgroundColor:[UIColor clearColor]];
        titleLab = [[UILabel alloc] initWithFrame:bannerView.frame];
        titleLab.text = @"百度开放云编程马拉松";
        [bannerView addSubview:titleLab];
        [self.contentView addSubview:bannerView];
        
        tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.contentView.frame.size.width, self.contentView.frame.size.height - 30 - 10)];
        [tipView setBackgroundColor:[UIColor whiteColor]];
        photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        photoView.image = [UIImage imageNamed:@""];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
