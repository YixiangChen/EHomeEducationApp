//
//  EHECoreDataManager.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHECoreDataManager.h"
#import "AppDelegate.h"

@implementation EHECoreDataManager

+ (EHECoreDataManager *) getInstance
{
    static EHECoreDataManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[EHECoreDataManager alloc] init];
        }
        
        return sharedSingleton;
    }
}

-(id)init
{
    if(self = [super init]){
        id delegate = [UIApplication sharedApplication].delegate;
        self->_context = [delegate valueForKey:@"managedObjectContext"];
    }
    return self;
}


-(BOOL)saveTeacherInfo:(NSDictionary *) dict withTeacherId:(int) teacherId {
    
    EHETeacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"EHETeacher" inManagedObjectContext:self.context];
    teacher.teacherId = dict[@"teacherid"];
    teacher.teacherIcon = [[NSData alloc] initWithBase64EncodedString:dict[@"teachericon"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
    teacher.subjectInfo = dict[@"subjectinfo"];
    teacher.rank = dict[@"rank"];
    teacher.name = dict[@"name"];
    teacher.majorAdress = dict[@"majorAdress"];
    teacher.longitude = dict[@"longitude"];
    teacher.latitude = dict[@"latitude"];
    teacher.teacherId = [NSNumber numberWithInt:teacherId];
    teacher.birthday = dict[@"birthday"];
    teacher.degree = dict[@"degree"];
    teacher.gender = dict[@"gender"];
    teacher.identity = dict[@"identity"];
    teacher.memo = dict[@"memo"];
    teacher.objectInfo = dict[@"objectinfo"];
    teacher.qq = dict[@"qq"];
    teacher.sinaweibo = dict[@"sinaweibo"];
    teacher.telephone = dict[@"telephone"];
    teacher.timePeriod = dict[@"timeperiod"];
    NSError *error = nil;
    [self.context save:nil];
    if (error == nil) {
        NSLog(@"将一个Teacher对象写入CoreData %@",teacher);
        return YES;
    }else {
        return NO;
    }
    
}

-(void)saveOrderInfos:(NSArray *)arrayOrders {
    
    for (NSDictionary *dict in arrayOrders) {
        EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
        order.customername = [NSString stringWithFormat:@"%@",[dict objectForKey:@"customername"]];
        order.finishDate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"finishDate"]];
        order.orderid = [dict objectForKey:@"orderid"];
        order.latitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"latitude"]];
        order.longitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"longitude"]];
        order.orderstatus = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderstatus"]];
        order.serviceaddress = [dict objectForKey:@"serviceaddress"];
        order.orderdate = [dict objectForKey:@"orderdate"];
        order.teachername = [dict objectForKey:@"teachername"];
        [self.context save:nil];
    }
    
}

-(void)upDateOrderDetail:(NSDictionary *)dict withOrderId:(int)orderId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderid = %d", orderId];
    fetchRequest.predicate = predicate;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:nil];
    
    if(orders.count > 0) {
        EHEOrder *order = [orders objectAtIndex:0];
        order.customername = [dict objectForKey:@"customername"];
        order.memo = [dict objectForKey:@"memo"];
        order.objectinfo = [dict objectForKey:@"objectinfo"];
        order.orderdate = [dict objectForKey:@"orderdate"];
        order.subjectinfo = [dict objectForKey:@"subjectinfo"];
        order.teacherid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"teacherid"]];
        order.timeperiod = [dict objectForKey:@"timeperiod"];
        [self.context save:nil];
    } else {
        NSLog(@"core data中没有找到 ID 为 %d 的订单对象",orderId);
    }
    
}



-(NSArray *)fetchBasicInfosOfTeachers {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHETeacher"];
    NSPredicate * predicate = nil;
    fetchRequest.predicate = predicate;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *teachers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (teachers.count > 0)
    {
        return teachers;
    }
    return nil;
}

-(EHETeacher *)fetchDetailInfosWithTeacherId:(int)teacherId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHETeacher"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacherId = %d", teacherId];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *teachers = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (teachers.count > 0)
    {
        NSLog(@"拿到老师具体信息成功 %@",teachers[0]);
        return teachers[0];
    }
    return nil;
}

-(NSArray *)fetchOrderInfosWithCustomerID:(int)customerID andOrderStatus:(int)status {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate * predicate = nil;
    fetchRequest.predicate = predicate;
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"orderstatus" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (orders.count > 0)
    {
        return orders;
    }
    return nil;
}

-(EHEOrder *)fetchOrderDeatailWithOrderID:(int)orderId {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderid = %d", orderId];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"orderid" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        return nil;
    }
    else if (orders.count > 0)
    {
        return orders[0];
    }
    return nil;
}
-(void)removeAllTeachersFromCoreData
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EHETeacher" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [self.context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [self.context deleteObject:obj];
        }
        if (![self.context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}

-(void)removeAllOrdersFromCoreData {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EHEOrder" inManagedObjectContext:self.context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [self.context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [self.context deleteObject:obj];
        }
        if (![self.context save:&error])
        {
            NSLog(@"error:%@",error);
        }
    }
}



-(BOOL)removeTeacherWithTeacherId:(int)teacherId {
    EHETeacher *teacher = [self fetchDetailInfosWithTeacherId:teacherId];
    if (teacher != nil) {
        [self.context deleteObject:teacher];
        NSError * error;
        [self.context save:&error];
        if (error == nil) {
            NSLog(@"成功删除ID为%d的教师",teacherId);
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

@end
