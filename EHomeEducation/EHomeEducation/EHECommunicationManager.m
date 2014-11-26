//
//  EHECommunicationManager.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/18/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHECommunicationManager.h"
#import "EHECoreDataManager.h"

@implementation EHECommunicationManager

+ (EHECommunicationManager *) getInstance
{
    static EHECommunicationManager *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[EHECommunicationManager alloc] init];
        }
        
        return sharedSingleton;
    }
}

-(void)loadTeachersInfo {
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"distancefilter\":\"%f\",\"keyword\":\"%s\"}",0,39.0000000,119.0000000,1000.0,""];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findteacherlist.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if([dict[@"code"] intValue] == 0){
            [[EHECoreDataManager getInstance] updateBasicInfosOfTeachers:dict];
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }

}

-(void)loadDataWithTeacherID:(int) teacherId {
    
    NSString * postData = [NSString stringWithFormat:@"{\"teacherid\":\"%d\"}",teacherId];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findteacherdetail.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *dictTeacherInfo = dict[@"teacherinfo"];
        if([dict[@"code"] intValue] == 0){
            [[EHECoreDataManager getInstance] updateDetailInfos:dictTeacherInfo withTeacherId:teacherId];
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
    
}

-(void)loadOrderInfosWithCustomerID:(int)customerID andOrderStatus:(int)status {
    
    //-1: 所有状态订单
    //0：客户发出订单
    //1：教师确认订单
    //2：教师拒绝订单
    //3：客户取消订单
    //4：客户确认完成
    //5：教师确认完成
    //6：双方确认完成

    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\",\"orderstatus\":\"%d\",\"page\":\"1\",\"count\":\"10\"}",customerID,status];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findorderlist.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSArray *arrayOrders = dict[@"ordersinfo"];
        if([dict[@"code"] intValue] == 0){

            [[EHECoreDataManager getInstance] saveOrderInfos:arrayOrders];
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
}

-(void)loadOrderDetailWithOrderID:(int)orderID {
    NSString * postData = [NSString stringWithFormat:@"{\"orderid\":\"%d\"}",orderID];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findorderdetail.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
        NSDictionary *dictOrderInfo = dict[@"orderinfo"];
        if([dict[@"code"] intValue] == 0){
            NSLog(@"This is an order with detail %@",dictOrderInfo);
            [[EHECoreDataManager getInstance] upDateOrderDetail:dictOrderInfo withOrderId:orderID];
            
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
}



-(void)sendOrder:(NSDictionary *)dictOrder {
    
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%@\",\"latitude\":\"%@\",\"longitude\":\"%@\",\"serviceaddress\":\"%@\",\"teacherid\":\"%@\",\"orderdate\":\"%@\",\"timeperiod\":\"%@\",\"objectinfo\":\"%@\",\"subjectinfo\":\"%@\",\"memo\":\"%@\",\"orderstatus\":\"%@\"}",[dictOrder objectForKey:@"customerid"],[dictOrder objectForKey:@"latitude"],[dictOrder objectForKey:@"longitude"],[dictOrder objectForKey:@"serviceaddress"],[dictOrder objectForKey:@"teacherid"],[dictOrder objectForKey:@"orderdate"],[dictOrder objectForKey:@"timeperiod"],[dictOrder objectForKey:@"objectinfo"],[dictOrder objectForKey:@"subjectinfo"],[dictOrder objectForKey:@"memo"], [dictOrder objectForKey:@"orderstatus"]];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/reserveteacher.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(responseData != nil && error == nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if([dict[@"code"] intValue] == 0){
            NSLog(@"Sending is done successfully!");
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
}
@end
