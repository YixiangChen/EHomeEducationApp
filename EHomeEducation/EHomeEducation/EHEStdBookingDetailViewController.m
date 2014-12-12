//
//  EHEStdBookingDetailViewController.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-24.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdBookingDetailViewController.h"
#import "EHECoreDataManager.h"
#import "EHECommunicationManager.h"
@interface EHEStdBookingDetailViewController ()

@end

@implementation EHEStdBookingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=self.order.teachername;
    
    //传之后显示TextView的各种label控件 信息
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    _buttonSure=[UIButton buttonWithType:UIButtonTypeSystem];
    self.rankButton1=[UIButton buttonWithType:UIButtonTypeSystem];
    self.rankButton2=[UIButton buttonWithType:UIButtonTypeSystem];
    self.rankButton3=[UIButton buttonWithType:UIButtonTypeSystem];
    self.rankButton4=[UIButton buttonWithType:UIButtonTypeSystem];
    self.rankButton5=[UIButton buttonWithType:UIButtonTypeSystem];
    if(screenWidth==320&&screenHeight==480)
    {
        _teacherInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
         _orderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 250, 30)];
        _otherInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
         _beginAndEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 200, 30)];
        _objectLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 200, 30)];
        _descriptionInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 200, 30)];
        _descriptionTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 250, 300, 80)];
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, 150, 30)];
        
        _buttonSure.frame=CGRectMake(115, 390, 100, 37);
        self.rankButton1.frame=CGRectMake(10, 360, 20, 20);
        self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        _teacherInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
        _orderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 250, 30)];
        _otherInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
        _beginAndEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 200, 30)];
        _objectLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 200, 30)];
        _descriptionInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 200, 30)];
        _descriptionTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 250, 300, 80)];
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, 150, 30)];
        
        _buttonSure.frame=CGRectMake(115, 430, 100, 37);
        self.rankButton1.frame=CGRectMake(10, 360, 20, 20);
        self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        _teacherInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
        _orderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 250, 30)];
        _otherInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
        _beginAndEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 200, 30)];
        _objectLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 200, 30)];
        _descriptionInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 200, 30)];
        _descriptionTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 250, 355, 80)];
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, 150, 30)];
        
        _buttonSure.frame=CGRectMake(142, 530, 100, 37);
        self.rankButton1.frame=CGRectMake(10, 360, 20, 20);
        self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        _teacherInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
        _orderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 250, 30)];
        _otherInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
        _beginAndEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 200, 30)];
        _objectLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 200, 30)];
        _descriptionInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 200, 30)];
        _descriptionTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 250, 394, 80)];
        _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, 150, 30)];
        
        _buttonSure.frame=CGRectMake(152, 530, 100, 37);
        self.rankButton1.frame=CGRectMake(10, 360, 20, 20);
        self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }
    
    
    [self getLableAttribute:_teacherInfoLabel withText:self.order.teachername];
    _teacherInfoLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_teacherInfoLabel];
    
   
    NSString * orderDateString=[NSString stringWithFormat:@"预约时间：%@",self.order.orderdate];
    [self getLableAttribute:_orderLabel withText:orderDateString];
    _orderLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_orderLabel];
    
    
    [self getLableAttribute:_otherInfomationLabel withText:@"相关信息"];
    _otherInfomationLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_otherInfomationLabel];
    
   
    [self getLableAttribute:_beginAndEndLabel withText:[NSString stringWithFormat:@"授课起止时间：%@",self.order.timeperiod]];
    _beginAndEndLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_beginAndEndLabel];
    
    
    [self getLableAttribute:_objectLabel withText:[NSString stringWithFormat:@"所授科目：%@",self.order.subjectinfo]];
    _objectLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_objectLabel];
    
    
    [self getLableAttribute:_descriptionInfomationLabel withText:@"相关评价信息"];
    _descriptionInfomationLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_descriptionInfomationLabel];
    
    //初始化textView并且给TextView指定样式
    
    //让textView的光标在起始位置
    _descriptionTextView.selectedRange=NSMakeRange(0, 0);
    _descriptionTextView.delegate=self;//绑定textView的代理方法
    //textView的placeholder即默认值(因为textView没有TextField默认字的的属性)
    _descriptionTextView.text=@"请输入评论信息，不要超过100字......";
    _descriptionTextView.textColor=[UIColor grayColor];
    //给textView设定边框属性信息
    [_descriptionTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];//边框灰色
    [_descriptionTextView.layer setBorderWidth: 1.0];//宽度为1
    [_descriptionTextView.layer setCornerRadius:8.0f];//圆角
    [_descriptionTextView.layer setMasksToBounds:YES];
    [self.view addSubview:_descriptionTextView];
    
    _check=NO;//一开始加载页面的时候用户没有点击编辑textView故而check为NO
    
    
    
    [self getLableAttribute:_rankLabel withText:@"服务等级"];
    _rankLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_rankLabel];
    
    //初始化5颗星星
    
    [self.rankButton1 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton1 addTarget:self action:@selector(rankButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rankButton1];
    
    
    [self initButtonAttribute:self.rankButton2];
    [self.rankButton2 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton2 addTarget:self action:@selector(rankButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.rankButton2];
    
    
    [self initButtonAttribute:self.rankButton3];
    [self.rankButton3 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton3 addTarget:self action:@selector(rankButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.rankButton3];
    
    [self initButtonAttribute:self.rankButton4];
    [self.rankButton4 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton4 addTarget:self action:@selector(rankButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.rankButton4];
    
    [self initButtonAttribute:self.rankButton5];
    [self.rankButton5 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton5 addTarget:self action:@selector(rankButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.rankButton5];
    
    //初始化取消按钮
    
    
    [_buttonSure addTarget: self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"self.order.orderStatus=%d",self.order.orderstatus.intValue);
    
    if(self.order.orderstatus.intValue==0)
    {
    [_buttonSure setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约取消按钮2"] forState:UIControlStateNormal];
    }
    else if(self.order.orderstatus.intValue==2||self.order.orderstatus.intValue==3||self.order.orderstatus.intValue==6)
    {
        [self.buttonSure setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    else if(self.order.orderstatus.intValue==1||self.order.orderstatus.intValue==4||self.order.orderstatus.intValue==5)
    {
        [self.buttonSure setBackgroundImage:[UIImage imageNamed:@"提交按钮"] forState:UIControlStateNormal];
    }
    [self.view addSubview:_buttonSure];
}

//点击确定按钮所触发的事件
-(void)sureButtonClicked:(id)sender
{
    LXActionSheet * actionSheet=nil;
    if(self.order.orderstatus.intValue==0)
    {
     actionSheet= [[LXActionSheet alloc]initWithTitle:@"确定要取消订单吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"不要这单了" otherButtonTitles:nil];
    }
    else if(self.order.orderstatus.intValue==3)
    {
     actionSheet = [[LXActionSheet alloc]initWithTitle:@"确定要删除订单吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除订单" otherButtonTitles:nil];
    }
    [actionSheet showInView:self.view];
}
- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
{
    if((int)buttonIndex==0)
    {
        if(self.order.orderstatus.intValue==0)
        {
        UIAlertController * alertController=[UIAlertController alertControllerWithTitle:@"友情提示" message:@"您为什么要取消订单呢" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionCentain=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
            NSString * reasonString=[NSString stringWithFormat:@"取消订单原因是：%@",alertController.textFields.firstObject];
            [communicationManager cancelOrderWithOrderId:self.order.orderid.intValue withReason:reasonString];
            [_buttonSure setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约取消按钮"] forState:UIControlStateNormal];
            self.buttonSure.enabled=NO;
        }];
        UIAlertAction * actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:actionCancle];
        [alertController addAction:actionCentain];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = @"请输入原因.....";
        }];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if(self.order.orderstatus.intValue==3)
        {
            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"确定要删除吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
            [alertView show];
        }
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if(buttonIndex==0)
  {
      EHECommunicationManager * commucationManager=[EHECommunicationManager getInstance];
      [commucationManager removeOrderFromServerWithOrderId:self.order.orderid.intValue];
      self.buttonSure.enabled=NO;
  }
}

//点击第一颗星星的时候触发事件
-(void)rankButton1Clicked:(id)sender
{
    //在外层覆盖一个星星，让本星星和点击的星星边框重合
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(10, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(1, 350, 38, 38);
    
    //得到第一颗星星的frame属性
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        //让所覆盖的星星的宽高变大
        //让所点击的星星变大，并且切换图片吧
        self.rankButton1.frame=button1Rect;
        self.rankButton6.frame=button6Rect;
        //渐变消失
        self.rankButton6.alpha=0.0;
        
        //让其他的星星变小
        self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }];
    
    [self turnOnButton:self.rankButton1];
    [self turnOffButton:self.rankButton2];
    [self turnOffButton:self.rankButton3];
    [self turnOffButton:self.rankButton4];
    [self turnOffButton:self.rankButton5];
    //一下星星的点击方法类似于第一颗星星，都是动画渐变效果
}
-(void)rankButton2Clicked:(id)sender
{
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(80, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(71, 350, 38, 38);
    
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    
    CGRect button2Rect=self.rankButton2.frame;
    button2Rect=CGRectMake(79, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        self.rankButton1.frame=button1Rect;
        self.rankButton2.frame=button2Rect;
        self.rankButton6.frame=button6Rect;
        self.rankButton6.alpha=0.0;
        
        
        
        self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }];
    
    [self turnOnButton:self.rankButton1];
    [self turnOnButton:self.rankButton2];
    [self turnOffButton:self.rankButton3];
    [self turnOffButton:self.rankButton4];
    [self turnOffButton:self.rankButton5];
    
}
-(void)rankButton3Clicked:(id)sender
{
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(150, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(141, 350, 38, 38);
    
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    
    CGRect button2Rect=self.rankButton2.frame;
    button2Rect=CGRectMake(79, 358, 24, 24);
    
    CGRect button3Rect=self.rankButton3.frame;
    button3Rect=CGRectMake(149, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        self.rankButton1.frame=button1Rect;
        self.rankButton2.frame=button2Rect;
        self.rankButton3.frame=button3Rect;
        self.rankButton6.frame=button6Rect;
        self.rankButton6.alpha=0.0;
        
        self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }];
    
    [self turnOnButton:self.rankButton1];
    [self turnOnButton:self.rankButton2];
    [self turnOnButton:self.rankButton3];
    [self turnOffButton:self.rankButton4];
    [self turnOffButton:self.rankButton5];
}
-(void)rankButton4Clicked:(id)sender
{
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(220, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(211, 350, 38, 38);
    
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    
    CGRect button2Rect=self.rankButton2.frame;
    button2Rect=CGRectMake(79, 358, 24, 24);
    
    CGRect button3Rect=self.rankButton3.frame;
    button3Rect=CGRectMake(149, 358, 24, 24);
    
    CGRect button4Rect=self.rankButton4.frame;
    button4Rect=CGRectMake(219, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        self.rankButton1.frame=button1Rect;
        self.rankButton2.frame=button2Rect;
        self.rankButton3.frame=button3Rect;
        self.rankButton4.frame=button4Rect;
        self.rankButton6.frame=button6Rect;
        self.rankButton6.alpha=0.0;
        
        self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    }];
    
    [self turnOnButton:self.rankButton1];
    [self turnOnButton:self.rankButton2];
    [self turnOnButton:self.rankButton3];
    [self turnOnButton:self.rankButton4];
    [self turnOffButton:self.rankButton5];
}
-(void)rankButton5Clicked:(id)sender
{
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(290, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(281, 350, 38, 38);
    
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    
    CGRect button2Rect=self.rankButton2.frame;
    button2Rect=CGRectMake(79, 358, 24, 24);
    
    CGRect button3Rect=self.rankButton3.frame;
    button3Rect=CGRectMake(149, 358, 24, 24);
    
    CGRect button4Rect=self.rankButton4.frame;
    button4Rect=CGRectMake(219, 358, 24, 24);
    
    CGRect button5Rect=self.rankButton5.frame;
    button5Rect=CGRectMake(289, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        self.rankButton1.frame=button1Rect;
        self.rankButton2.frame=button2Rect;
        self.rankButton3.frame=button3Rect;
        self.rankButton4.frame=button4Rect;
        self.rankButton5.frame=button5Rect;
        self.rankButton6.frame=button6Rect;
        self.rankButton6.alpha=0.0;
    }];
    
    [self turnOnButton:self.rankButton1];
    [self turnOnButton:self.rankButton2];
    [self turnOnButton:self.rankButton3];
    [self turnOnButton:self.rankButton4];
    [self turnOnButton:self.rankButton5];
}
-(void)turnOnButton:(UIButton *)button
{
    //点击让所点击的星星变亮
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星"] forState:UIControlStateNormal];
}
-(void)turnOffButton:(UIButton *)button
{
    //点击让其他的星星变暗
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
}
//初始化button的属性
-(void)initButtonAttribute:(UIButton *)button
{
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
}
//点击TextView所触发的事件
-(IBAction)touchView:(id)sender
{
    if(_check==YES)
    {
        //先把所有的label下拉
        [self pushAllLabels];
        //再上提textView
        CGRect textFrame=_descriptionTextView.frame;
        textFrame.origin.y+=150;
        //并且让textView的height变回原始大小
        textFrame.size.height-=20;
        _descriptionTextView.frame=textFrame;
        [_descriptionTextView resignFirstResponder];//键盘放弃第一响应者身份
        _check=NO;
        if([_descriptionTextView.text isEqualToString:@""])//如果用户没有输入任何字符
        {
            _descriptionTextView.text=@"请输入评论信息，不要超过100字.........";//就变回默认值
            _descriptionTextView.textColor=[UIColor grayColor];
        }
    }
    [_descriptionTextView resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if((screenWidth==320&&screenHeight==480)||(screenWidth==320&&screenHeight==568))
    {
        //textView刚开始编辑的方法
        textView.text=@"";
        //如果check为NO
        if(_check==NO)
        {
            //光标在首
            textView.selectedRange=NSMakeRange(0, 0);
            //上提所有label控件
            [self pullAllLabels];
            CGRect textFrame=textView.frame;
            textFrame.origin.y-=150;
            //加大textView的height值
            textFrame.size.height+=20;
            textView.frame=textFrame;
            _check=YES;
        }
    }
}
//上啦所有label的方法
-(void)pullAllLabels
{
    [self pullAllComponents:self.teacherInfoLabel];
    [self pullAllComponents:self.orderLabel];
    [self pullAllComponents:self.otherInfomationLabel];
    [self pullAllComponents:self.beginAndEndLabel];
    [self pullAllComponents:self.objectLabel];
    [self pullAllComponents:self.descriptionInfomationLabel];
}
//下拉所有label的方法，使所有label的y坐标都还原
-(void)pushAllLabels
{
    [self pushAllComponents:self.teacherInfoLabel];
    [self pushAllComponents:self.orderLabel];
    [self pushAllComponents:self.otherInfomationLabel];
    [self pushAllComponents:self.beginAndEndLabel];
    [self pushAllComponents:self.objectLabel];
    [self pushAllComponents:self.descriptionInfomationLabel];
}
//上拉控件(label)
-(void)pullAllComponents:(UILabel *)label
{
    CGRect labelFrame = label.frame;
    labelFrame.origin.y-=150;
    label.frame=labelFrame;
}
//下拉控件(label)
-(void)pushAllComponents:(UILabel *)label
{
    CGRect labelFrame = label.frame;
    labelFrame.origin.y+=150;
    label.frame=labelFrame;
}

//添加这个方法，让弹出的键盘点击return的时候可以触发时间
-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        if(_check==YES)
        {
            [self pushAllLabels];
            CGRect textFrame=_descriptionTextView.frame;
            textFrame.origin.y+=150;
            textFrame.size.height-=20;
            _descriptionTextView.frame=textFrame;
            [_descriptionTextView resignFirstResponder];
            _check=NO;
            if([_descriptionTextView.text isEqualToString:@""])
            {
                _descriptionTextView.text=@"请输入评论信息，不要超过100字";
                _descriptionTextView.textColor=[UIColor grayColor];
            }
        }
    }
    return YES;
}
//取得所有label的属性
-(void)getLableAttribute:(UILabel *)label withText:(NSString *)textName
{
    label.text=textName;
    label.textColor=[UIColor blackColor];
    label.backgroundColor=[UIColor clearColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
