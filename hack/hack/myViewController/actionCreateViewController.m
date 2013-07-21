//
//  actionCreateViewController.m
//  hack
//
//  Created by 靳晓童 on 13-7-20.
//  Copyright (c) 2013年 ZhaoyangSu. All rights reserved.
//

#import "actionCreateViewController.h"
#import "IHAction.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"

typedef enum
{
    EEditSectionAdd = 0,
    EEditSectionImage,
    EEditSectionTip,
    EEditSectionType,
    EEditSectionStartTime,
    EEditSectionEndTime,
    EEditSectionDelete,
    EEditSectionCount,
}
EditSection;


#define KImageViewWidth     140
#define KBtnViewTag       10001
#define KTextFieldTag     10002

@interface actionCreateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isFullScreen;

}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) IHAction *oldAction;
@property (nonatomic, strong) IHAction *commitAction;
@property (nonatomic, strong) UIImage *tempImage;
@property (nonatomic, strong) UIResponder *currentResponder;
@property (nonatomic, assign)  CGFloat  keyboardHeight;
@property (nonatomic, assign) BOOL needAdjust;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation actionCreateViewController
@synthesize imageBtn;
@synthesize startTimePicker,endTimePicker,actionTypePicker;


- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (id)initWithAction:(IHAction *)action
{
    if (self = [super init])
    {
        self.oldAction = action;
        self.commitAction = [action copy];
    }
    return self;
}

- (BOOL)isCareate
{
    if (self.oldAction.itemId == 0)
    {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imageBtn addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = item;
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://actionshare.duapp.com/actionshare/action_type/all.php"]];
    [self.request setDelegate:self];
    [self.request setRequestMethod:@"POST"];
    [self.request startAsynchronous];
    [queue addOperation:self.request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    self.commitAction.leaderUser.userPhoto = fullPath;
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:EEditSectionImage inSection:0]];
    self.tempImage = savedImage;
    if (cell)
    {
        UIButton *btn = (UIButton *)[cell viewWithTag:KBtnViewTag];
        [btn setImage:image forState:UIControlStateNormal];
    }
    
//    [self.imageBtn setImage:savedImage forState:UIControlStateNormal];
//    
//    self.imageBtn.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    isFullScreen = !isFullScreen;
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.view];
    
    CGPoint imagePoint = self.imageBtn.frame.origin;
    //touchPoint.x ，touchPoint.y 就是触点的坐标
    
    // 触点在imageView内，点击imageView时 放大,再次点击时缩小
    if(imagePoint.x <= touchPoint.x && imagePoint.x +self.imageBtn.frame.size.width >=touchPoint.x && imagePoint.y <=  touchPoint.y && imagePoint.y+self.imageBtn.frame.size.height >= touchPoint.y)
    {
        // 设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        // 动画时间
        [UIView setAnimationDuration:1];
        
        if (isFullScreen) {
            // 放大尺寸
            
            self.imageBtn.frame = CGRectMake(0, 0, 320, 480);
        }
        else {
            // 缩小尺寸
            self.imageBtn.frame = CGRectMake(50, 65, 90, 115);
        }
        
        // commit动画
        [UIView commitAnimations];
        
    }
    
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}
- (IBAction)chooseImage:(id)sender {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
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
    actionTypeArray = [[NSMutableArray alloc] initWithArray:responseArray];
    [self.tableView reloadData];
}


#pragma mark -
#pragma mark tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return EEditSectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case EEditSectionAdd:
        {
            static NSString *identifier = @"AddCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, 44)];
                [addBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
                [addBtn setTitle:@"删除" forState:UIControlStateNormal];
                addBtn.backgroundColor = [UIColor greenColor];
                addBtn.layer.cornerRadius = 20;
                [cell.contentView addSubview:addBtn];
                cell.clipsToBounds = YES;
            }
            return cell;
            break;
        }
        case EEditSectionImage:
        {
            static NSString *identifier = @"ImageCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.imageView.backgroundColor = [UIColor blackColor];
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectZero];
                btn.tag = KBtnViewTag;
                if ([self.commitAction isMine])
                {
                    [btn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [cell.contentView addSubview:btn];
                cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            }
            UIImage *tempImage ;
            if (!self.tempImage)
            {
                tempImage = [UIImage imageNamed: self.commitAction.leaderUser.userPhoto];
            }
            if (!tempImage)
            {
                tempImage = [UIImage imageNamed:@"20115201212718777801.jpg"];
            }
            UIButton  *btn = (UIButton *)[cell viewWithTag:KBtnViewTag];
            [btn setImage:tempImage forState:UIControlStateNormal];
            btn.frame = CGRectMake((tableView.frame.size.width - KImageViewWidth) / 2 , 10, KImageViewWidth, KImageViewWidth);
            return cell;
            break;
        }
        case EEditSectionTip:
        {
            static NSString *identifier = @"tipCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 2 * 10, 44)];
                textField.font = [UIFont systemFontOfSize:16.0];
                textField.delegate = self;
                textField.tag = KTextFieldTag;
                [textField addTarget:self action:@selector(tipChanged:) forControlEvents:UIControlEventEditingChanged];
                textField.borderStyle = UITextBorderStyleRoundedRect;
                if (!self.commitAction.isMine)
                {
                    textField.enabled = NO;
                }
                [cell.contentView addSubview:textField];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            UITextField *textField = (UITextField *)[cell viewWithTag:KTextFieldTag];
            textField.text = self.commitAction.actionTip;
            return cell;
            break;
        }
        case EEditSectionDelete:
        {
            static NSString *identifier = @"deleteCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width - 20, 44)];
                [deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
                [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
                deleteBtn.backgroundColor = [UIColor orangeColor];
                deleteBtn.layer.cornerRadius = 20;
                [cell.contentView addSubview:deleteBtn];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            return cell;
        }
        case EEditSectionType:
        {
            static NSString *identifier = @"deleteCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
                [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = EEditSectionType;
            cell.detailTextLabel.text = @"类别";
            
            return cell;
        }
        case EEditSectionStartTime:
        {
            static NSString *identifier = @"deleteCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
                [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = EEditSectionStartTime;
            cell.detailTextLabel.text = @"开始时间";
            
            return cell;
        }
        case EEditSectionEndTime:
        {
            static NSString *identifier = @"deleteCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
                [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.tag = EEditSectionEndTime;
            cell.detailTextLabel.text = @"结束时间";
            
            return cell;
        }
        default:
            break;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self isCareate] && indexPath.row == EEditSectionAdd)
    {
        return 44.0;
    }
    else if([self isCareate] && indexPath.row == EEditSectionAdd)
    {
        return 0.0;
    }
    else if(EEditSectionImage == indexPath.row)
    {
        return KImageViewWidth + 2 * 10;
    }
    return 64.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark -

- (void)changeImage:(UIButton *)sender
{
    UIImagePickerController *controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    [self presentModalViewController:controller animated:YES];
}

- (void)tipChanged:(UITextField *)sender
{
    self.commitAction.actionTip = [sender.text copy];
}

- (void)deleteAction:(UIButton *)seder
{
    if (self.block)
    {
        self.block(YES,nil);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)done:(UIButton *)sender
{
    if (self.block)
    {
        self.block(NO,self.commitAction);
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat keyHeight =[[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if (keyHeight > 0)
    {
        _keyboardHeight = keyHeight;
    }
    if (self.currentResponder)
    {
        UITextField *textField = (UITextField *)self.currentResponder;
        [self adjustTableToFitKeyBoard:textField];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsZero;
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
}

- (void)adjustTableToFitKeyBoard:(UITextField *)textField
{
    if(_keyboardHeight == 0 )
    {
        return;
    }

    CGFloat y = [[textField superview] convertPoint:textField.frame.origin toView:self.view].y;
    CGFloat subHeight = y + textField.frame.size.height - (self.view.frame.size.height - _keyboardHeight);
    
    if (subHeight > 0)
    {
        UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, _keyboardHeight, 0);
        self.tableView.contentInset = inset;
        self.tableView.scrollIndicatorInsets = inset;
        
        CGFloat offsetY = self.tableView.contentOffset.y;
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.contentOffset = CGPointMake(0, offsetY + subHeight + 4 * 10);
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentResponder = textField;

    [self adjustTableToFitKeyBoard:textField];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentResponder = nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.isDragging)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:EEditSectionTip inSection:0]];
        if (cell)
        {
            UITextField *textView = (UITextField *)[cell viewWithTag:KTextFieldTag];
            [textView resignFirstResponder];
        }
    }
}

- (void)onTapDataPickerBtn:(NSIndexPath *)indexPath
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n"
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    self.actionSheet = actionSheet;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelDataPicker:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(10, 8, 60, 30);
    [actionSheet addSubview:button];
    
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectZero];
    [button1 setTitle:@"确定" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(selectDataPicker:) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 8, 60, 30);
    [actionSheet addSubview:button1];
    
    UIPickerView *dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
//    dataPicker.tag = EDataPickerTag;
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    dataPicker.showsSelectionIndicator = YES;
//    if (self.selectIndex < 0)
//    {
//        [dataPicker selectRow:0 inComponent:0 animated:YES];
//    }
//    else
//    {
//        [dataPicker selectRow:self.selectIndex inComponent:0 animated:YES];
//    }
//    self.title.frame = CGRectMake(button.frame.origin.x + button.frame.size.width + KGap/2, button.top, button1.left - button.right - KGap, button.height);
//    [actionSheet addSubview:self.title];
    [actionSheet addSubview:dataPicker];
    [actionSheet showInView:self];
}


- (void)cancelDataPicker:(UIButton*)button
{
    UIActionSheet *actionSheet = self.actionSheet;
    [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
}

- (void)selectDataPicker:(UIButton*)button
{
    UIActionSheet *actionSheet = self.actionSheet;
    UIPickerView *picker = (UIPickerView *)[actionSheet viewWithTag:EDataPickerTag];
//    self.selectIndex = [picker selectedRowInComponent:0];
    [actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
    
    [self.target performSelector:@selector(dataPicked:) withObject:self.indexPath];
    
    [self setNeedsDisplay];
}

- (void)dataPicked:(NSIndexPath *)indexPath
{
    DataPickerCell *cell = (DataPickerCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    self.selectedCountryIndex = cell.selectIndex;
    [self selectCountryByIndex:cell.selectIndex];
}


@end
