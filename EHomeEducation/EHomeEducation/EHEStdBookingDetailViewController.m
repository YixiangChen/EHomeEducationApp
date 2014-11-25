//
//  EHEStdBookingDetailViewController.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-24.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdBookingDetailViewController.h"
@interface EHEStdBookingDetailViewController ()

@end

@implementation EHEStdBookingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.teacherName;
    
    _teacherInfoLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
    [self getLableAttribute:_teacherInfoLabel withText:self.teacherName];
    _teacherInfoLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_teacherInfoLabel];
    
    _orderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 250, 30)];
    NSString * orderDateString=[NSString stringWithFormat:@"预约时间：%@",self.orderDate];
    [self getLableAttribute:_orderLabel withText:orderDateString];
    _orderLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_orderLabel];
    
    _otherInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
    [self getLableAttribute:_otherInfomationLabel withText:@"相关信息"];
    _otherInfomationLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_otherInfomationLabel];
     
    _beginAndEndLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 200, 30)];
    [self getLableAttribute:_beginAndEndLabel withText:[NSString stringWithFormat:@"授课起止时间：%@",self.teacher.timePeriod]];
    _beginAndEndLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_beginAndEndLabel];
    
    _objectLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 200, 30)];
    [self getLableAttribute:_objectLabel withText:[NSString stringWithFormat:@"所授科目：%@",self.teacher.subjectInfo]];
    _objectLabel.font=[UIFont systemFontOfSize:15.0f];
    [self.view addSubview:_objectLabel];
    
    _descriptionInfomationLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, 200, 30)];
    [self getLableAttribute:_descriptionInfomationLabel withText:@"相关评价信息"];
    _descriptionInfomationLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_descriptionInfomationLabel];
    
    _descriptonTextField=[[UITextView alloc]initWithFrame:CGRectMake(10, 250, 300, 80)];
    _descriptonTextField.selectedRange=NSMakeRange(0, 0);
    _descriptonTextField.delegate=self;
    _descriptonTextField.text=@"请输入评论信息，不要超过100字......";
    _descriptonTextField.textColor=[UIColor grayColor];
    [_descriptonTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [_descriptonTextField.layer setBorderWidth: 1.0];
    [_descriptonTextField.layer setCornerRadius:8.0f];
    [_descriptonTextField.layer setMasksToBounds:YES];
    [self.view addSubview:_descriptonTextField];
    
    _check=NO;
    
    _rankLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 330, 150, 30)];
    [self getLableAttribute:_rankLabel withText:@"服务等级"];
    _rankLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
    [self.view addSubview:_rankLabel];
    
    self.rankButton1=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton1 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton1.frame=CGRectMake(10, 360, 20, 20);
    [self.rankButton1 addTarget:self action:@selector(rankButton1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rankButton1];
    
    self.rankButton2=[UIButton buttonWithType:UIButtonTypeSystem];
    [self initButtonAttribute:self.rankButton2];
    [self.rankButton2 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton2 addTarget:self action:@selector(rankButton2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rankButton2.frame=CGRectMake(80, 360, 20, 20);
    [self.view addSubview:self.rankButton2];
    
    self.rankButton3=[UIButton buttonWithType:UIButtonTypeSystem];
    [self initButtonAttribute:self.rankButton3];
    [self.rankButton3 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton3 addTarget:self action:@selector(rankButton3Clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rankButton3.frame=CGRectMake(150, 360, 20, 20);
    [self.view addSubview:self.rankButton3];
    
    self.rankButton4=[UIButton buttonWithType:UIButtonTypeSystem];
    [self initButtonAttribute:self.rankButton4];
    [self.rankButton4 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton4 addTarget:self action:@selector(rankButton4Clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rankButton4.frame=CGRectMake(220, 360, 20, 20);
    [self.view addSubview:self.rankButton4];
    
    self.rankButton5=[UIButton buttonWithType:UIButtonTypeSystem];
    [self initButtonAttribute:self.rankButton5];
    [self.rankButton5 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    [self.rankButton5 addTarget:self action:@selector(rankButton5Clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rankButton5.frame=CGRectMake(290, 360, 20, 20);
    [self.view addSubview:self.rankButton5];
    
    _buttonSure=[UIButton buttonWithType:UIButtonTypeSystem];
    _buttonSure.frame=CGRectMake(20, 390, 100, 37);
    [_buttonSure addTarget: self action:@selector(sureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonSure setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约取消按钮2"] forState:UIControlStateNormal];
    [self.view addSubview:_buttonSure];
    
    _bookingButton=[UIButton buttonWithType:UIButtonTypeSystem];
    _bookingButton.frame=CGRectMake(190, 390, 100, 37);
    [_bookingButton addTarget:self action:@selector(bookingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bookingButton setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约预约按钮2"] forState:UIControlStateNormal];
    [self.view addSubview:_bookingButton];
    
}
-(void)sureButtonClicked:(id)sender
{
    [_buttonSure setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约取消按钮"] forState:UIControlStateNormal];
}
-(void)bookingButtonClicked:(id)sender
{
    [_bookingButton setBackgroundImage:[UIImage imageNamed:@"订单-已完成 - 继续预约预约按钮"] forState:UIControlStateNormal];
}
-(void)rankButton1Clicked:(id)sender
{
    self.rankButton6=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.rankButton6 setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
    self.rankButton6.frame=CGRectMake(10, 360, 20, 20);
    [self.view addSubview:self.rankButton6];
    
    CGRect button6Rect=self.rankButton6.frame;
    button6Rect=CGRectMake(1, 350, 38, 38);
    
    CGRect button1Rect=self.rankButton1.frame;
    button1Rect=CGRectMake(9, 358, 24, 24);
    [UIView animateWithDuration:1.0 animations:^{
        self.rankButton1.frame=button1Rect;
        self.rankButton6.frame=button6Rect;
        self.rankButton6.alpha=0.0;
        
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
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星"] forState:UIControlStateNormal];
}
-(void)turnOffButton:(UIButton *)button
{
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
}
-(void)initButtonAttribute:(UIButton *)button
{
    button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:@"订单-历史评论星星2"] forState:UIControlStateNormal];
}
-(IBAction)touchView:(id)sender
{
    if(_check==YES)
    {
    [self pushAllLabels];
    CGRect textFrame=_descriptonTextField.frame;
    textFrame.origin.y+=150;
    textFrame.size.height-=20;
    _descriptonTextField.frame=textFrame;
    [_descriptonTextField resignFirstResponder];
        _check=NO;
        if([_descriptonTextField.text isEqualToString:@""])
        {
            _descriptonTextField.text=@"请输入评论信息，不要超过100字.........";
            _descriptonTextField.textColor=[UIColor grayColor];
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text=@"";
    if(_check==NO)
    {
    textView.selectedRange=NSMakeRange(0, 0);
    [self pullAllLabels];
    CGRect textFrame=textView.frame;
    textFrame.origin.y-=150;
    textFrame.size.height+=20;
    textView.frame=textFrame;
    _check=YES;
    }
}

-(void)pullAllLabels
{
    [self pullAllComponents:self.teacherInfoLabel];
    [self pullAllComponents:self.orderLabel];
    [self pullAllComponents:self.otherInfomationLabel];
    [self pullAllComponents:self.beginAndEndLabel];
    [self pullAllComponents:self.objectLabel];
    [self pullAllComponents:self.descriptionInfomationLabel];
}
-(void)pushAllLabels
{
    [self pushAllComponents:self.teacherInfoLabel];
    [self pushAllComponents:self.orderLabel];
    [self pushAllComponents:self.otherInfomationLabel];
    [self pushAllComponents:self.beginAndEndLabel];
    [self pushAllComponents:self.objectLabel];
    [self pushAllComponents:self.descriptionInfomationLabel];
}
-(void)pullAllComponents:(UILabel *)label
{
    CGRect labelFrame = label.frame;
    labelFrame.origin.y-=150;
    label.frame=labelFrame;
}
-(void)pushAllComponents:(UILabel *)label
{
    CGRect labelFrame = label.frame;
    labelFrame.origin.y+=150;
    label.frame=labelFrame;
}
-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        if(_check==YES)
        {
            [self pushAllLabels];
            CGRect textFrame=_descriptonTextField.frame;
            textFrame.origin.y+=150;
            textFrame.size.height-=20;
            _descriptonTextField.frame=textFrame;
            [_descriptonTextField resignFirstResponder];
            _check=NO;
            if([_descriptonTextField.text isEqualToString:@""])
            {
                _descriptonTextField.text=@"请输入评论信息，不要超过100字";
                _descriptonTextField.textColor=[UIColor grayColor];
            }
        }
    }
    return YES;
}
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
