//
//  EHEStdDatePickerTableViewCell.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/25/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdDatePickerTableViewCell.h"

@implementation EHEStdDatePickerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.datePicker.datePickerMode = UIDatePickerModeDate;
    // Configure the view for the selected state
}

@end
