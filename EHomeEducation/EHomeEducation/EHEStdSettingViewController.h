//
//  EHEStdSettingViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdSettingTableViewCell.h"
#import "EHEStdSettingDetailViewController.h"
#import "LXActionSheet.h"
@interface EHEStdSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,LXActionSheetDelegate>
@property(strong,nonatomic)UITableView * tableViewSetting;
@property(strong,nonatomic)NSArray * personalInfomationArray;
@property(strong,nonatomic)NSArray * systemSettingArray;
@property(strong,nonatomic)NSArray * connectAndShareArray;
@property(strong,nonatomic)NSString * detailType;
@property(strong,nonatomic)UIImage * userImage;
@property(nonatomic)BOOL check;
@property(strong,nonatomic)NSArray * testArray;
@property(strong,nonatomic)NSString * userNames;
@property(strong,nonatomic)NSMutableData * imageData;
@property(strong,nonatomic)NSString * userIconString;
@end
