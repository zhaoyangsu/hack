//
//  detailViewController.m
//  hack
//
//  Created by caoliang on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//
#import "detailViewController.h"
#import "IHMovieImageBtn.h"
#import "ASINetworkQueue.h"
#import "JSONKit.h"

@interface detailViewController ()
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;

@end

@implementation detailViewController
@synthesize detailAction;

@synthesize leaderUserName;
@synthesize actionName = _actionName;
@synthesize actionTime;
@synthesize actionType;
@synthesize insertCount = _insertCount;
@synthesize actionImageView;
@synthesize actionTip;

//@synthesize photoesPage;
//@synthesize audioesPage;
//@synthesize videosPage;
//
//@synthesize photoArr = _photoArr;
//@synthesize audioArr = _audioArr;
//@synthesize videoArr = _videoArr;
@synthesize scrollView = _scrollView;

@synthesize addedBtn;
 
#pragma mark - life circle
- (id)initWithAction:(IHAction *)aAction
{
    self = [super initWithNibName:@"detailViewController" bundle:nil];
    if (self) {
        self.detailAction = aAction;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat : @"yyyy年M月d日 H点m分"];
        
        _actionName.text = aAction.actionTip;
        NSString *startTime = [formatter stringFromDate:aAction.startTime];
        NSString *endTime = [formatter stringFromDate:aAction.endTime];
        actionTime.text = [[NSString alloc] initWithFormat:@"%@ -- %@",startTime,endTime];
        actionType.text = aAction.type.typeName;
        _insertCount = [NSString stringWithFormat:@"%d",aAction.insterNum ];
        
        actionImageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@",aAction.actionHeaderPhoto]];
        actionTip.text = aAction.actionTip;
        
//        [videosPage setNumberOfPages:2];
//        [videosPage setCurrentPage:0];
//        [videosPage addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        
        _photoArr = aAction.photoes;
        _audioArr = aAction.audioes;
        _videoArr = aAction.videos;
        [addedBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
       // Custom initialization
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 600)];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)layoutViews
{
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addAction
{
    ASINetworkQueue *queue = [[ASINetworkQueue alloc] init];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://actionshare.duapp.com/actionshare/action_join/add.php"]];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
    [queue addOperation:request];
}

#pragma mark -
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request.responseString);
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    NSArray *responseArray = [[response dataUsingEncoding:NSUTF8StringEncoding] objectFromJSONData];
}


@end
