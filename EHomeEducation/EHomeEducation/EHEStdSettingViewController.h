//
//  EHEStdSettingViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView * tableView;
@property(strong,nonatomic)NSArray * array1;
@property(strong,nonatomic)NSArray * array2;
@property(strong,nonatomic)NSArray * array3;
@end
