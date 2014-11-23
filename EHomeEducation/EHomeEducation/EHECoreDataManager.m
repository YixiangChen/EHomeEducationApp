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

-(void)saveOrderInfos:(NSDictionary *)dictOrder {
    EHEOrder *order = [NSEntityDescription insertNewObjectForEntityForName:@"EHEOrder" inManagedObjectContext:self.context];
    NSLog(@"I am savin data yeah");
    order.customerid = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"customerid"]];
    NSLog(@"i am saving customerid");
    order.latitude = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"latitude"]];
    order.longitude = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"longitude"]];
    order.serviceaddress = [dictOrder objectForKey:@"serviceaddress"];
    order.teacherid = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"teacherid"]];
    order.orderdate = [dictOrder objectForKey:@"orderdate"];
    order.timeperiod = [dictOrder objectForKey:@"timeperiod"];
    order.objectinfo = [dictOrder objectForKey:@"objectinfo"];
    order.subjectinfo = [dictOrder objectForKey:@"subjectinfo"];
    order.memo =[dictOrder objectForKey:@"memo"];
    order.orderstatus = [NSString stringWithFormat:@"%@",[dictOrder objectForKey:@"orderstatus"]];
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

-(NSArray *)fetchAllOrders {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"EHEOrder"];
//    NSPredicate * predicate = nil;
//    fetchRequest.predicate = predicate;
//    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"customerid" ascending:NO];
//    NSArray *sorts = [[NSArray alloc] initWithObjects:sortByName, nil];
//    fetchRequest.sortDescriptors = sorts;
    
    NSError *error;
    NSArray *orders = [self.context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"%d++++++++++++", orders.count);
    NSLog(@"%@++++++++++++",orders[0]);
    
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
