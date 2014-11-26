//
//  EHEStdSubjectTableTableViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/23/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHEStdOrderViewController.h"

@interface EHEStdSubjectTableTableViewController : UITableViewController
@property (strong, nonatomic) NSString *selectedSubjects;
@property (strong, nonatomic) EHEStdOrderViewController *orderTable;
-(NSString *)getSelectedSubjects;
@end
