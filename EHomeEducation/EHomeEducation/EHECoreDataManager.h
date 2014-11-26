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
//@property(strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(strong, nonatomic) NSManagedObjectContext *context;
+ (EHECoreDataManager *) getInstance;
-(void) updateBasicInfosOfTeachers:(NSDictionary *) dict;
-(void)updateDetailInfos:(NSDictionary *) dict withTeacherId:(int) teacherId;
-(void)saveOrderInfos:(NSArray *) arrayOrders;
-(void)upDateOrderDetail:(NSDictionary *)dict withOrderId:(int) orderId;
-(NSArray *) fetchBasicInfosOfTeachers;
-(EHETeacher *) fetchDetailInfosWithTeacherId:(int) teacherId;
-(NSArray *) fetchOrderInfosWithCustomerID:(int)customerID andOrderStatus:(int)status;
-(EHEOrder *) fetchOrderDeatailWithOrderID:(int) orderId;
-(void) deleteData;

@end
