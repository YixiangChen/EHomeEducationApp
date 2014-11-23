//
//  EHEOrder.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/23/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHEOrder : NSManagedObject

@property (nonatomic, retain) NSString * customerid;
@property (nonatomic, retain) NSString * objectinfo;
@property (nonatomic, retain) NSString * timeperiod;
@property (nonatomic, retain) NSString * orderdate;
@property (nonatomic, retain) NSString * teacherid;
@property (nonatomic, retain) NSString * serviceaddress;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * subjectinfo;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * orderstatus;

@end
