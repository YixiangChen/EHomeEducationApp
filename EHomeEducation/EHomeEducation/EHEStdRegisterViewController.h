//
//  EHEStdRegisterViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHEStdRegisterViewController : UIViewController<UITextFieldDelegate>

@property(strong,nonatomic)UIImageView * headImageView;
@property(strong,nonatomic)UITextField * userNameTextField;
@property(strong,nonatomic)UITextField * passwordTextField;
@property(strong,nonatomic)UITextField * passwordConfirmTextField;
@property(strong,nonatomic)UIButton * registerButton;
@property(strong,nonatomic)UIButton * cancleButton;
@property(strong,nonatomic)UIImageView * userNameAccessoryImage;
@property(strong,nonatomic)UIImageView * passwordAccessoryImage;
@property(strong,nonatomic)UIImageView * passwordAccessoryImage2;
@property(strong,nonatomic)UIImageView * spliteLine1;
@property(strong,nonatomic)UIImageView * spliteLine2;
@property(strong,nonatomic)UIImageView * spliteLine3;
@property(nonatomic)BOOL check;
-(IBAction)backgroundClicked:(id)sender;

@end
