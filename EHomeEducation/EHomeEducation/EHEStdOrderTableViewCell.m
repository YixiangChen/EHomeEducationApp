//
//  EHEStdOrderTableViewCell.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/24/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHEStdOrderTableViewCell.h"

@implementation EHEStdOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.mainPickerArraySchools = @[@"小学",@"初中",@"高中"];
    self.dictPicker = [NSDictionary dictionaryWithObjectsAndKeys:
                       @[@"一年级",@"二年级",@"三年级",@"四年级",@"五年级",@"六年级"], @"小学",
                       @[@"一年级",@"二年级",@"三年级"],@"初中",
                       @[@"一年级",@"二年级",@"三年级"],@"高中",
                       nil];
    self.subPickerArrayGrades = [self.dictPicker objectForKey:@"小学"];
    self.pickerView.frame = CGRectMake(0, 0, 320, 162);
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.selectedObject = @"小学一年级";
    self.selectedSchool = @"小学";

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [self.mainPickerArraySchools count];
    } else {
        return [self.subPickerArrayGrades count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return  [self.mainPickerArraySchools objectAtIndex:row];
    } else {
        return [self.subPickerArrayGrades objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        self.selectedSchool = nil;
        self.subPickerArrayGrades = [self.dictPicker objectForKey:[self.mainPickerArraySchools objectAtIndex:row]];
        self.selectedSchool = [self.mainPickerArraySchools objectAtIndex:row];
        self.selectedGrade = @"一年级";
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
    }else {
        self.selectedGrade = nil;
        self.selectedGrade = [self.subPickerArrayGrades objectAtIndex:row];
    }
    
    self.selectedObject = [NSString stringWithFormat:@"%@%@",self.selectedSchool,self.selectedGrade];

}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 100;
    }
    return 220;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 3;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont fontWithName:kYueYuanFont size:20]];
        [pickerLabel setTextColor:kGreenForTabbaritem];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
