//
//  EHEStdBookingDetailViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-24.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEOrder.h"
#import "LXActionSheet.h"
@interface EHEStdBookingDetailViewController : UIViewController<UITextViewDelegate,LXActionSheetDelegate,UIAlertViewDelegate>
//教师名字
@property(strong,nonatomic)NSString * teacherName;
//预约时间
@property(strong,nonatomic)NSString * orderDate;
@property(strong,nonatomic)EHEOrder * order;//一个teacher对象用于传值
//教师信息label
@property(strong,nonatomic)UILabel * teacherInfoLabel;
@property(strong,nonatomic)UILabel * orderLabel;
//其他信息
@property(strong,nonatomic)UILabel * otherInfomationLabel;
//教课起始时间
@property(strong,nonatomic)UILabel * beginAndEndLabel;
//授课对象
@property(strong,nonatomic)UILabel * objectLabel;
//评价信息
@property(strong,nonatomic)UILabel * descriptionInfomationLabel;
//评价等级
@property(strong,nonatomic)UILabel * rankLabel;
//家长或者学生进行评价的textView
@property(strong,nonatomic)UITextView * descriptionTextView;
//评价的5颗星星，每颗星星都是一个按钮
@property(strong,nonatomic)UIButton * rankButton1;
@property(strong,nonatomic)UIButton * rankButton2;
@property(strong,nonatomic)UIButton * rankButton3;
@property(strong,nonatomic)UIButton * rankButton4;
@property(strong,nonatomic)UIButton * rankButton5;
//用于施加动画效果的星星
@property(strong,nonatomic)UIButton * rankButton6;
//确定按钮
@property(strong,nonatomic)UIButton * buttonSure;
//继续预约按钮
@property(strong,nonatomic)UIButton * bookingButton;
@property(nonatomic)BOOL check;//判断现在是不是在进行textView的编辑
-(IBAction)touchView:(id)sender;//点击背景View的时候所触发的事件
@end
