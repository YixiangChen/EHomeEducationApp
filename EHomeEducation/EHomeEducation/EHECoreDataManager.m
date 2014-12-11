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


-(BOOL)saveTeacherInfo:(NSDictionary *) dict {
    
    EHETeacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"EHETeacher" inManagedObjectContext:self.context];
    teacher.teacherId = dict[@"teacherid"];
    teacher.teacherIcon = dict[@"teachericon"];
    teacher.subjectInfo = dict[@"subjectinfo"];
    teacher.rank = dict[@"rank"];
    teacher.name = dict[@"name"];
    teacher.majorAdress = dict[@"majorAdress"];
    teacher.longitude = dict[@"longitude"];
    teacher.latitude = dict[@"latitude"];
    teacher.teacherId = [NSNumber numberWithInt:[[dict objectForKey:@"teacherid"] intValue]];
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
    [self.context save:&error];
    if (error == nil) {
        NSLog(@"将一个Teacher对象写入CoreData %@",teacher);
        return YES;
    }else {
        return NO;
    }
    
}

-(BOOL)saveOrderInfo:(NSDictionary *) dictOrder {
    
    EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
    order.customername = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"customername"]];
    order.finishDate = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"finishDate"]];
    order.orderid = [dictOrder objectForKey:@"orderid"];
    order.latitude = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"latitude"]];
    order.longitude = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"longitude"]];
    order.orderstatus = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"orderstatus"]];
    order.serviceaddress = [dictOrder objectForKey:@"serviceaddress"];
    order.orderdate = [dictOrder objectForKey:@"orderdate"];
    order.teachername = [dictOrder objectForKey:@"teachername"];
    
    order.customername = [dictOrder objectForKey:@"customername"];
    order.memo = [dictOrder objectForKey:@"memo"];
    order.objectinfo = [dictOrder objectForKey:@"objectinfo"];
    order.orderdate = [dictOrder objectForKey:@"orderdate"];
    order.subjectinfo = [dictOrder objectForKey:@"subjectinfo"];
    order.teacherid = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"teacherid"]];
    order.timeperiod = [dictOrder objectForKey:@"timeperiod"];
    
    
    NSError *error = nil;
    [self.context save:&error];
    if (error == nil) {
        NSLog(@"将一个order对象写入CoreData %@",order);
        return YES;
    }else {
        return NO;
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

-(NSArray *)fetchOrderInfosWithStatus:(int)status {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"orderstatus = %d", status];
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
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

@end
