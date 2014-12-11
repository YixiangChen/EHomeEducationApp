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

@interface EHECoreDataManager : NSObject
@property(strong, nonatomic) NSManagedObjectContext *context;

+ (EHECoreDataManager *) getInstance;


//通过教师ID存储教师具体信息
-(BOOL)saveTeacherInfo:(NSDictionary *) dict;

//从core data中获取教师基本信息
-(NSArray *) fetchBasicInfosOfTeachers;

//通过教师ID从Core Data中获取教师具体信息
-(EHETeacher *) fetchDetailInfosWithTeacherId:(int) teacherId;

//通过教师ID移除教师对象
-(BOOL) removeTeacherWithTeacherId:(int) teacherId;

//删除core data所有教师对象
-(void) removeAllTeachersFromCoreData;


//存储订单基本信息
-(BOOL)saveOrderInfo:(NSDictionary *) dictOrder;

//通过状态获取订单
-(NSArray *) fetchOrderInfosWithStatus:(int)status;

//通过订单ID获取订单详细信息
-(EHEOrder *) fetchOrderDeatailWithOrderID:(int) orderId;


//删除core data所有订单对象
-(void) removeAllOrdersFromCoreData;

@end
