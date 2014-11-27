//
//  EHECommunicationManager.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EHECommunicationManager : NSObject

+ (EHECommunicationManager *) getInstance;

//获取教师初步信息
-(void)loadTeachersInfo;

//通过教师ID获取指定教师的具体信息
-(void)loadDataWithTeacherID:(int) teacherId;

//发送订单，订单中包含所有所需信息
-(void)sendOrder:(NSDictionary *) dictOrder;

//获取订单初步信息
-(void)loadOrderInfosWithCustomerID:(int) customerID andOrderStatus:(int)status ;

//通过订单ID获取订单详细信息
-(void)loadOrderDetailWithOrderID:(int)orderID;

//发送用户其他信息
-(void) sendOtherInfo:(NSDictionary *) dictOtherInfo;

//取消订单 订单状态改为3
-(void) cancelOrderWithOrderId:(int) orderId withReason:(NSString *) memo;

//家长确认订单 订单状态改为4
-(void) confirmOrderWithOrderId:(int) orderId;

//用户上传个人头像
-(void)uploadUserIconWithCustomerId:(int) customerId;

//用户评价老师
-(void)commentTeacherWithTeacherId:(int)teacherId fromCustomerWithCustomerId:(int) customerId withRank:(int)rank andContent:(NSString *)content;

//通过教师ID获取教师评价
-(void)loadRankWithTeacherId:(int) teacherId;

@end
