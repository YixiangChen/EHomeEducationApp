//
//  EHEStdFilterByGenderViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/28/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHEStdFilterByGenderViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *maleBtn;
@property (strong, nonatomic) IBOutlet UIButton *femaleBtn;
@property (strong, nonatomic) IBOutlet UIButton *allManBtn;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) FPPopoverController * popController;
@property bool isMaleBtnSelected;
@property bool isFemaleBtnSelected;
@property bool isAllManBtnSelected;

@end
