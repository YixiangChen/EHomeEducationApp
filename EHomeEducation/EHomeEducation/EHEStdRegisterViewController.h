//
//  EHEStdRegisterViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdRegisterViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtRegisterName;
@property (strong, nonatomic) IBOutlet UITextField *txtRegisterPassword;

- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
