//
//  EHEStdFilterBySubjectsViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/29/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHEStdFilterBySubjectsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *swChinese;
@property (strong, nonatomic) IBOutlet UISwitch *swMath;
@property (strong, nonatomic) IBOutlet UISwitch *swEnglish;
@property (strong, nonatomic) IBOutlet UISwitch *swPhysic;
@property (strong, nonatomic) IBOutlet UISwitch *swChem;
@property (strong, nonatomic) IBOutlet UISwitch *swOthers;
@property (strong, nonatomic) IBOutlet UISwitch *swBio;
@property (strong, nonatomic) IBOutlet UISwitch *swPolitic;
@property (strong, nonatomic) IBOutlet UISwitch *swHistory;
@property (strong, nonatomic) IBOutlet UISwitch *swGeo;
@property (strong, nonatomic) IBOutlet UISwitch *swArt;

@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) FPPopoverController *popController;
@end
