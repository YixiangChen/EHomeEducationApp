//
//  EHEOrder.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-27.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHEOrder : NSManagedObject

@property (nonatomic, retain) NSString * customerid;
@property (nonatomic, retain) NSString * customername;
@property (nonatomic, retain) NSString * finishDate;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * objectinfo;
@property (nonatomic, retain) NSString * orderdate;
@property (nonatomic, retain) NSNumber * orderid;
@property (nonatomic, retain) NSString * orderstatus;
@property (nonatomic, retain) NSString * serviceaddress;
@property (nonatomic, retain) NSString * subjectinfo;
@property (nonatomic, retain) NSString * teacherid;
@property (nonatomic, retain) NSString * teachername;
@property (nonatomic, retain) NSString * timeperiod;

@end
