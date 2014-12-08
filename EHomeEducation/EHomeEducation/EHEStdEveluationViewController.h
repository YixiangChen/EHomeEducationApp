//
//  EHEStdEveluationViewController.h
//  EHomeEducation
//
//  Created by MacBook Pro on 14-12-2.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdEveluationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView * commonTableView;
@property(strong,nonatomic)NSMutableArray * commonArray;
@property(strong,nonatomic)NSMutableArray * teacherName;
@property(strong,nonatomic)NSMutableArray * commonDate;
@property(strong,nonatomic)NSMutableDictionary * commonDictionary;
@property(strong,nonatomic)NSMutableArray * commonInfomation;
@property(strong,nonatomic)NSArray * allCommentsArray;
@property(strong,nonatomic)NSMutableSet * sets;
@property(strong,nonatomic)NSDictionary * teacherDic;

@end
