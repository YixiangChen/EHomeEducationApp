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

-(void)updateBasicInfosOfTeachers:(NSDictionary *) dict{
    
    NSArray *dictsForTeacherInfo = dict[@"teachersinfo"];
    
    for (NSDictionary *dictionary in dictsForTeacherInfo) {
        EHETeacher * teacher = [NSEntityDescription insertNewObjectForEntityForName:@"EHETeacher" inManagedObjectContext:self.context];
        teacher.teacherId = dictionary[@"teacherid"];
        teacher.teacherIcon = [[NSData alloc] initWithBase64EncodedString:dictionary[@"teachericon"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        teacher.subjectInfo = dictionary[@"subjectinfo"];
        teacher.rank = dictionary[@"rank"];
        teacher.name = dictionary[@"name"];
        teacher.majorAdress = dictionary[@"majorAdress"];
        teacher.longitude = dictionary[@"longitude"];
        teacher.latitude = dictionary[@"latitude"];
        [self.context save:nil];
        
    }
}

-(void)updateDetailInfos:(NSDictionary *) dict withTeacherId:(int) teacherId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHETeacher"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teacherId = %d", teacherId];
    fetchRequest.predicate = predicate;
    NSArray *teachers = [self.context executeFetchRequest:fetchRequest error:nil];
    
    if (teachers.count > 0) {
        EHETeacher *teacher = [teachers objectAtIndex:0];
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
        [self.context save:nil];
        NSLog(@"将一个Teacher对象写入CoreData %@",teacher);
    } else {
        NSLog(@"core data中没有找到 ID 为 %d 的教师对象",teacherId);
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
-(void)savePersonalData:(NSDictionary *)dictOtherInfo {
    EHEAccount *account = [NSEntityDescription insertNewObjectForEntityForName:@"EHEAccount" inManagedObjectContext:self.context];
    
    account.customerid = [dictOtherInfo objectForKey:@"customerid"];
    account.name = [dictOtherInfo objectForKey:@"name"];
    account.gender = [dictOtherInfo objectForKey:@"gender"];
    account.telephone = [dictOtherInfo objectForKey:@"telephone"];
    account.latitude = [dictOtherInfo objectForKey:@"latitude"];
    account.longitude = [dictOtherInfo objectForKey:@"longitude"];
    account.majoraddress = [dictOtherInfo objectForKey:@"majoraddress"];
    account.memo = [dictOtherInfo objectForKey:@"memo"];
    
    [self.context save:nil];
}

-(EHEAccount *)fetchPersonalDataWithCustomerId:(int)customerId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEAccount"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"customerid = %d", customerId];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"customerid" ascending:NO];
    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"从CoreData获取EHEAccount出错");
        return nil;
    }
    else if (users.count > 0)
    {
        return users[0];
    }
    NSLog(@"CoreData中找不到CustomerID为 %d 的用户",customerId);
    return nil;
    
}

@end
