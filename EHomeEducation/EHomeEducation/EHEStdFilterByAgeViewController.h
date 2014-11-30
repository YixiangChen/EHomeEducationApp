//
//  EHEStdFilterByAgeViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/28/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHEStdFilterByAgeViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblAge;
@property (strong, nonatomic) IBOutlet UITextField *txtMinAge;
@property (strong, nonatomic) IBOutlet UITextField *textMaxAge;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;

@property (strong, nonatomic) FPPopoverController *popController;
@end
