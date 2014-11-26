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
    
}

-(void)saveOrderInfos:(NSArray *)arrayOrders {
    
    for (NSDictionary *dict in arrayOrders) {
        EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
        order.customername = [NSString stringWithFormat:@"%@",[dict objectForKey:@"customername"]];
        order.finishDate = [NSString stringWithFormat:@"%@",[dict objectForKey:@"finishDate"]];
        order.orderid = [dict objectForKey:@"orderid"];
        order.latitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"latitude"]];
        order.longitude = [NSString stringWithFormat:@"%@",[dict objectForKey:@"longitude"]];
        order.orderstatus = [dict objectForKey:@"oderstatus"];
        order.serviceaddress = [dict objectForKey:@"serviceaddress"];
        order.orderdate = [dict objectForKey:@"orderdate"];
        order.teachername = [dict objectForKey:@"teachername"];
        [self.context save:nil];
    }
    
    for (NSDictionary *dict in arrayOrders) {
        NSLog(@" i have an order with id %@",[dict objectForKey:@"orderid"]);
    }
    
}

-(void)upDateOrderDetail:(NSDictionary *)dict withOrderId:(int)orderId {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"orderid = %d", orderId];
    fetchRequest.predicate = predicate;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:nil];
    for (EHEOrder * order in orders) {
        NSLog(@"I am getting an order with id %@",order);
    }
    EHEOrder *order = [orders objectAtIndex:0];
    

    order.customername = [dict objectForKey:@"customername"];
    order.memo = [dict objectForKey:@"memo"];
    order.objectinfo = [dict objectForKey:@"objectinfo"];
    order.orderdate = [dict objectForKey:@"orderdate"];
    order.subjectinfo = [dict objectForKey:@"subjectinfo"];
    order.teacherid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"teacherid"]];
    order.timeperiod = [dict objectForKey:@"timeperiod"];
    [self.context save:nil];
    
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
    
    for (EHEOrder *order in orders) {
        NSLog(@"the order saved is %@ ",order);
    }
    
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
    
    for (EHEOrder * order in orders) {
        NSLog(@"Now I am fetching an order %@",order);
    }
    
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
-(void)deleteData
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

@end
