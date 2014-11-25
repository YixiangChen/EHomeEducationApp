//
//  EHEStdBookingDetailViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-24.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"
@interface EHEStdBookingDetailViewController : UIViewController<UITextViewDelegate>
@property(strong,nonatomic)NSString * teacherName;
@property(strong,nonatomic)NSString * orderDate;
@property(strong,nonatomic)EHETeacher * teacher;
@property(strong,nonatomic)UITextView * descriptonTextField;
@property(strong,nonatomic)IBOutlet UIScrollView * scrollView;
@property(strong,nonatomic)UILabel * teacherInfoLabel;
@property(strong,nonatomic)UILabel * orderLabel;
@property(strong,nonatomic)UILabel * otherInfomationLabel;
@property(strong,nonatomic)UILabel * beginAndEndLabel;
@property(strong,nonatomic)UILabel * objectLabel;
@property(strong,nonatomic)UILabel * descriptionInfomationLabel;
@property(strong,nonatomic)UILabel * rankLabel;
@property(strong,nonatomic)UIButton * rankButton1;
@property(strong,nonatomic)UIButton * rankButton2;
@property(strong,nonatomic)UIButton * rankButton3;
@property(strong,nonatomic)UIButton * rankButton4;
@property(strong,nonatomic)UIButton * rankButton5;
@property(strong,nonatomic)UIButton * rankButton6;
@property(strong,nonatomic)UIButton * buttonSure;
@property(strong,nonatomic)UIButton * bookingButton;
@property(nonatomic)BOOL check;
-(IBAction)touchView:(id)sender;
@end
