//
//  EHEStdSettingPersonalInformation.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-27.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class EHEStdSettingDetailViewController;
@interface EHEStdSettingPersonalInformation : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * telephoneNumber;
@property(strong,nonatomic)NSString * gender;
@property(strong,nonatomic)NSString * brithday;
@property(strong,nonatomic)NSString * address;
@property(strong,nonatomic)UIImage * image;
@property(strong,nonatomic)NSData * imageData;
@property(nonatomic)BOOL check;
@end