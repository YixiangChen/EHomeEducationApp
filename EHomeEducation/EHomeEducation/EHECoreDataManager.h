//
//  EHECoreDataManager.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EHETeacher.h"
#import "EHEOrder.h"
#import "EHEAccount.h"

@interface EHECoreDataManager : NSObject
@property(strong, nonatomic) NSManagedObjectContext *context;

+ (EHECoreDataManager *) getInstance;

//存储教师基本信息
-(void) updateBasicInfosOfTeachers:(NSDictionary *) dict;

//通过教师ID存储教师具体信息
-(void)updateDetailInfos:(NSDictionary *) dict withTeacherId:(int) teacherId;

//从core data中获取教师基本信息
-(NSArray *) fetchBasicInfosOfTeachers;

//通过教师ID从Core Data中获取教师具体信息
-(EHETeacher *) fetchDetailInfosWithTeacherId:(int) teacherId;

//存储订单基本信息
-(void)saveOrderInfos:(NSArray *) arrayOrders;

//更新订单具体信息
-(void)upDateOrderDetail:(NSDictionary *)dict withOrderId:(int) orderId;

//通过用户ID获取订单基本信息
-(NSArray *) fetchOrderInfosWithCustomerID:(int)customerID andOrderStatus:(int)status;

//通过订单ID获取订单详细信息
-(EHEOrder *) fetchOrderDeatailWithOrderID:(int) orderId;

//删除core data所有教师对象
-(void) removeAllTeachersFromCoreData;

//删除core data所有订单对象
-(void) removeAllOrdersFromCoreData;

//保存个人信息
-(void) savePersonalData:(NSDictionary *) dictOtherInfo;

//通过customerid获取个人信息
-(EHEAccount *) fetchPersonalDataWithCustomerId:(int) customerId;

@end
