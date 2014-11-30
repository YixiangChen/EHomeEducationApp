//
//  EHEStdFilterByDistanceViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/28/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface EHEStdFilterByDistanceViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *txtDistance;
@property (strong, nonatomic) IBOutlet UILabel *lblText;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) FPPopoverController *popController;

@end
