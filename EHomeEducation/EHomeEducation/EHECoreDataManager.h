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
-(void)saveOrderInfos:(NSDictionary *) dictOrder;
-(NSArray *) fetchBasicInfosOfTeachers;
-(EHETeacher *) fetchDetailInfosWithTeacherId:(int) teacherId;
-(NSArray *) fetchAllOrders;
-(void) deleteData;

@end
