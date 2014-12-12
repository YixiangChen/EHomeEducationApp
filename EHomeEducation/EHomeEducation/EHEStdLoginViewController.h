//
//  EHEStdLoginViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdLoginViewController : UIViewController<UITextFieldDelegate>
@property(strong,nonatomic)UILabel * userNameLabel;
@property(strong,nonatomic)UILabel * passwordLabel;
@property(strong,nonatomic)UITextField * userNameTextField;
@property(strong,nonatomic)UITextField * passwordTextField;
@property(strong,nonatomic)UIButton * loginButton;
@property(strong,nonatomic)UIButton * registerButton;
@property(strong,nonatomic)UIButton * forgetPasswordButton;
-(IBAction)backgrounCliked:(id) sender;

@end
