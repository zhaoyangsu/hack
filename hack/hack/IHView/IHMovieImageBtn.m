//
//  IHMovieImageBtn.m
//  hack
//
//  Created by 靳晓童 on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "IHMovieImageBtn.h"

@implementation IHMovieImageBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithMovie:(IHMovie *)aMovie
{
    if (self)
    {
        self = [super init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setImageWithSnapOfMovie
{
    NSURL *url = [[NSURL alloc] initWithString:movie.fileUrl];
    MPMoviePlayerController *mvPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [mvPlayer thumbnailImageAtTime:10 timeOption:MPMovieTimeOptionExact];
}

@end
