//
//  EHEStdSettingDetailViewController.h
//  EHomeEducation
//
//  Created by ibokan on 14/11/19.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdSettingDetailViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *birthdayDatePicker;
@property (strong, nonatomic) IBOutlet UITextField *ageTextField;
@property(strong,nonatomic)NSArray * sexArray;
-(IBAction)clickBackground:(id)sender;
@end
