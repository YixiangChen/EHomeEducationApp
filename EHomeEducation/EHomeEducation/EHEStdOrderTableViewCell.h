//
//  EHEStdOrderTableViewCell.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/24/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdOrderTableViewCell : UITableViewCell<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSArray *mainPickerArraySchools;
@property (strong, nonatomic) NSArray *subPickerArrayGrades;
@property (strong, nonatomic) NSDictionary *dictPicker;
@property (strong, nonatomic) NSString *selectedGrade;
@property (strong, nonatomic) NSString *selectedSchool;
@property (strong, nonatomic) NSString *selectedObject;
@property (strong, nonatomic) NSMutableDictionary *dictOrder;
@end
