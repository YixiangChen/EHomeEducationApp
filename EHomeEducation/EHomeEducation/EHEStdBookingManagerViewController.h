//
//  EHEStdBookingManagerViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-18.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdBookingTableViewCell.h"

@interface EHEStdBookingManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>
@property(strong,nonatomic)UITableView * homeTeacherTableView;
@property(strong,nonatomic)EHEStdBookingTableViewCell * bookingTableViewCell;
@property(strong,nonatomic)NSMutableArray * arrayTeacherInfo;//暂时性的数据源，不可这样写，请求到真实数据应立刻删掉
//所有的订单数组
@property(strong,nonatomic)NSArray * allOrdersArray;
//把订单数组分组的字典
@property(strong,nonatomic)NSMutableDictionary * orderDictionary;
//刚发送的订单
@property(strong,nonatomic)NSMutableArray * sendOrders;
//教师确定的订单
@property(strong,nonatomic)NSMutableArray * centainOrders;
//教师或者学生取消的订单
@property(strong,nonatomic)NSMutableArray * cancledOrders;
//未完成的订单(教师或者家长一方没有确认)
@property(strong,nonatomic)NSMutableArray * unfinishedOrders;
//已经完成的订单
@property(strong,nonatomic)NSMutableArray * finishedOrders;
@property(strong,nonatomic)NSMutableData * orderDatas;
@end
