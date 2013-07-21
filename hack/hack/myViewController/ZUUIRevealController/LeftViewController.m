//
//  LeftViewController.m
//  hack
//
//  Created by ZhaoyangSu on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//
#import "IHUserManager.h"
#import "LeftViewController.h"
#import "ASIFormDataRequest.h"
#import "locationViewController.h"

#define LABELTITLETAG 200

@interface LeftViewController ()
@property(nonatomic,strong)UIView *logInView;
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *secretTextField;
@end

@implementation LeftViewController
@synthesize logInView = _logInView;
@synthesize nameTextField = _nameTextField;
@synthesize secretTextField = _secretTextField;

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
    
    IHUserManager *userManager = [IHUserManager shareUserManager];
    if (YES == [userManager isLogIn]) {
        
    }else{
        _logInView = [[UIView alloc]initWithFrame:self.view.bounds];
        _logInView.backgroundColor = [UIColor grayColor];
        
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 80, 150, 30)];
        [_nameTextField setBackgroundColor:[UIColor whiteColor]];
        _nameTextField.placeholder = @"用户名";
        [_logInView addSubview:_nameTextField];
        
        _secretTextField = [[UITextField alloc]initWithFrame:CGRectMake(80, 140, 150, 30)];
        [_secretTextField setBackgroundColor:[UIColor whiteColor]];
         _secretTextField.placeholder = @"密码";
        [_logInView addSubview:_secretTextField];
        
        UIButton *logInbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logInbtn setFrame:CGRectMake(80, 200, 50, 30)];
        [logInbtn setTitle:@"登陆" forState:UIControlStateNormal];
        [logInbtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        [_logInView addSubview:logInbtn];
        
        UIButton *registerbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [registerbtn setFrame:CGRectMake(150, 200, 50, 30)];
        [registerbtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerbtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        [_logInView addSubview:registerbtn];
        [self.view addSubview:_logInView];
    
    }
    
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
#pragma mark --
- (void)logIn
{
    if (nil == _nameTextField.text || nil == _secretTextField.text) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"用户名或密码不能为空" message:@"请检查填写" delegate: nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
 
    
    NSURL *url = [NSURL URLWithString:@"http://actionshare.duapp.com/actionshare/user/login.php"];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    [request setPostValue:_nameTextField.text forKey:@"name"];
     [request setPostValue:_secretTextField.text forKey:@"password"];
    request.delegate = self;
    [request startAsynchronous];
    
}
#pragma mark - request Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
   NSData *tResponseString = [request responseData];
    NSString *str = [[NSString alloc]initWithData:tResponseString encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"false"]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"请检查用户名密码" delegate: nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    NSLog(@"%@",str);
    NSDictionary* json =[NSJSONSerialization
                         JSONObjectWithData:request.responseData options:kNilOptions error:nil];
    NSLog(@"%@",[json objectForKey:@"id"]);
    IHUserManager *manager = [IHUserManager shareUserManager];
    NSString *id =[json objectForKey:@"id"];
    [_logInView removeFromSuperview];
    [manager setUserId:id];
    [manager setUserName:[json objectForKey:@"id"]];
    [manager archiveToUserDefault];

}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"请检查网络连接" delegate: nil  cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
@end
