//
//  EHEStdSettingDetailViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-22.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdSettingDetailCell.h"
@class EHEStdSettingPersonalInformation;
//最后两个协议是用来选择图片的
@interface EHEStdSettingDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSArray * sexArray;//性别的分组
@property(strong,nonatomic)NSString * type;//根据type值来判定显示给用户什么设置信息
@property(nonatomic)NSInteger currentIndexPath;//用于选择性别的当前选择cell
@property(strong,nonatomic)IBOutlet UIDatePicker * datePicker;//用于设置出生日期
//下面四个属性字段都是暂时数据，有了实时数据即可
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * telephoneNumber;
@property(strong,nonatomic)NSString * birthDate;
@property(strong,nonatomic)NSString * address;
//学生头像
@property(strong,nonatomic)UIImageView * studentImageView;
//图片选择器
@property(strong,nonatomic) UIImagePickerController * imagePickerController;
//日期选择器的值更改后所触发的事件
-(IBAction)dataPickerValueChanged:(id)sender;
@property(strong,nonatomic)EHEStdSettingPersonalInformation * personInfomation;
@property(strong,nonatomic)UIImage * image;
@end