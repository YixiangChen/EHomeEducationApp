//
//  EHEStdOrderViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHETeacher.h"
#import "EHEStdOrderTableViewCell.h"
#import "EHEStdDatePickerTableViewCell.h"
#import "EHEStdTimePickerTableViewCell.h"


@interface EHEStdOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EHETeacher *teacher;
@property (strong, nonatomic) EHEStdOrderTableViewCell *cellForObject;
@property (strong, nonatomic) EHEStdDatePickerTableViewCell *cellForDatePicker;
@property (strong, nonatomic) EHEStdTimePickerTableViewCell *cellForStartTimePicker;
@property (strong, nonatomic) EHEStdTimePickerTableViewCell *cellForEndTimePicker;
@property (strong, nonatomic) NSString *selectedObject;
@property (strong, nonatomic) NSString *selectedSubjects;
@property (strong, nonatomic) NSString *selectedLocation;
@property (strong, nonatomic) NSString *selectedMemo;
@property (strong, nonatomic) NSString *selectedDate;
@property (strong, nonatomic) NSString *selectedStartTime;
@property (strong, nonatomic) NSString *selectedEndTime;


@end
