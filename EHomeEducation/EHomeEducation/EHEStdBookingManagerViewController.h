//
//  EHEStdBookingManagerViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-18.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdBookingTableViewCell.h"
#import "EHESegmentedControlManager.h"
@interface EHEStdBookingManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)EHESegmentedControlManager * segmentedControl;//自定义的一个segmentedControl
@property(strong,nonatomic)UITableView * homeTeacherTableView;
@property(strong,nonatomic)EHEStdBookingTableViewCell * bookingTableViewCell;
@property(strong,nonatomic)NSMutableArray * arrayTeacherInfo;//暂时性的数据源，不可这样写，请求到真实数据应立刻删掉
@property(strong,nonatomic)NSMutableArray * arrayDate;
@property(strong,nonatomic)NSMutableArray * arrayOrderID;
@property(strong,nonatomic)NSMutableArray * teacherArray;
@property(strong,nonatomic)NSArray * allOrdersArray;
@property(strong,nonatomic)NSMutableArray * realOrdersArray;
@property(strong,nonatomic)NSMutableDictionary * orderDictionary;
@property(strong,nonatomic)NSMutableArray * sendOrders;
@property(strong,nonatomic)NSMutableArray * centainOrders;
@property(strong,nonatomic)NSMutableArray * cancledOrders;
@property(strong,nonatomic)NSMutableArray * unfinishedOrders;
@property(strong,nonatomic)NSMutableArray * finishedOrders;
@end
