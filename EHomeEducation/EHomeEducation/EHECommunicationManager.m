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
    NSLog(@"now is loading .........");
    
    NSString * postData = [NSString stringWithFormat:@"{\"customerid\":\"%d\",\"latitude\":\"%f\",\"longitude\":\"%f\",\"distancefilter\":\"%f\",\"keyword\":\"%s\"}",0,39.0000000,119.0000000,1000.0,""];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/findteacherlist.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if(responseData != nil && error == nil){
        //使用系统自带JSON解析方法
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
        if([dict[@"code"] intValue] == 0){
            //注册成功，
            [[EHECoreDataManager getInstance] updateTeachersInfos:dict];
            NSLog(@"正在打印教师信息");
            NSLog(@"%@",dict);
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
    


}
@end
