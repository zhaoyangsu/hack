//
//  IHMovieImageBtn.h
//  hack
//
//  Created by 靳晓童 on 13-7-21.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IHMovie.h"

@interface IHMovieImageBtn : UIButton
{
    IHMovie *movie;
}

-(id)initWithMovie:(IHMovie *)aMovie;

@end
