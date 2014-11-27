//
//  EHEAccount.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-27.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EHEAccount : NSManagedObject

@property (nonatomic, retain) NSNumber * customerid;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * majoraddress;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * telephone;

@end
