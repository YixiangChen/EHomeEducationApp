//
//  EHEStdRegisterViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdRegisterViewController.h"
#import "MF_Base64Additions.h"
#import "Defines.h"

@interface EHEStdRegisterViewController ()

@end

@implementation EHEStdRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.registerButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    if(screenWidth==320&&screenHeight==480)
    {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
        self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
        self.userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
        self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 220, 230, 40)];
        self.passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 225, 30, 30)];
        self.passwordConfirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 270, 230, 40)];
        self.passwordAccessoryImage2=[[UIImageView alloc]initWithFrame:CGRectMake(25, 275, 30, 30)];
        self.spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 268, 2)];
        self.spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 260, 268, 2)];
        self.spliteLine3=[[UIImageView alloc]initWithFrame:CGRectMake(22, 310, 268, 2)];
        self.registerButton.frame=CGRectMake(22, 330, 268, 40);
        self.cancleButton.frame=CGRectMake(22, 380, 268, 40);
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
        self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
        self.userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
        self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 230, 230, 40)];
        self.passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 235, 30, 30)];
        self.passwordConfirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 290, 230, 40)];
        self.passwordAccessoryImage2=[[UIImageView alloc]initWithFrame:CGRectMake(25, 295, 30, 30)];
        self.spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 268, 2)];
        self.spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 270, 268, 2)];
        self.spliteLine3=[[UIImageView alloc]initWithFrame:CGRectMake(22, 330, 268, 2)];
        self.registerButton.frame=CGRectMake(22, 360, 268, 40);
        self.cancleButton.frame=CGRectMake(22, 430, 268, 40);
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 150)];
        self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
        self.userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
        self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 230, 230, 40)];
        self.passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 235, 30, 30)];
        self.passwordConfirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 290, 230, 40)];
        self.passwordAccessoryImage2=[[UIImageView alloc]initWithFrame:CGRectMake(25, 295, 30, 30)];
        self.spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 331, 2)];
        self.spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 270, 331, 2)];
        self.spliteLine3=[[UIImageView alloc]initWithFrame:CGRectMake(22, 330, 331, 2)];
        self.registerButton.frame=CGRectMake(22, 380, 331, 40);
        self.cancleButton.frame=CGRectMake(22, 460, 331, 40);
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 150)];
        self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
        self.userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
        self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 230, 230, 40)];
        self.passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 235, 30, 30)];
        self.passwordConfirmTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 290, 230, 40)];
        self.passwordAccessoryImage2=[[UIImageView alloc]initWithFrame:CGRectMake(25, 295, 30, 30)];
        self.spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 370, 2)];
        self.spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 270, 370, 2)];
        self.spliteLine3=[[UIImageView alloc]initWithFrame:CGRectMake(22, 330, 370, 2)];
        self.registerButton.frame=CGRectMake(22, 410, 370, 40);
        self.cancleButton.frame=CGRectMake(22, 490, 370, 40);
    }
    
    
    self.headImageView.image=[UIImage imageNamed:@"loginHeader"];
    [self.view addSubview:self.headImageView];
    
    
    self.userNameTextField.borderStyle=UITextBorderStyleNone;
    self.userNameTextField.placeholder=@"请输入用户名.....";
    [self.view addSubview:self.userNameTextField];
    
    
    self.userNameAccessoryImage.image=[UIImage imageNamed:@"loginIcon"];
    [self.view addSubview:self.userNameAccessoryImage];
    
    
    self.passwordTextField.borderStyle=UITextBorderStyleNone;
    self.passwordTextField.placeholder=@"请输入密码......";
    [self.view addSubview:self.passwordTextField];
    
    
    self.passwordAccessoryImage.image=[UIImage imageNamed:@"code"];
    [self.view addSubview:self.passwordAccessoryImage];
    
    
    self.passwordConfirmTextField.borderStyle=UITextBorderStyleNone;
    self.passwordConfirmTextField.placeholder=@"请重复输入密码......";
    [self.view addSubview:self.passwordConfirmTextField];
    
    
    self.passwordAccessoryImage2.image=[UIImage imageNamed:@"code"];
    [self.view addSubview:self.passwordAccessoryImage2];
    
    
    self.spliteLine1.image=[UIImage imageNamed:@"loginSpliteLine"];
    self.spliteLine1.alpha=0.8f;
    [self.view addSubview:self.spliteLine1];
    
    
    self.spliteLine2.image=[UIImage imageNamed:@"loginSpliteLine"];
    self.spliteLine2.alpha=0.8f;
    [self.view addSubview:self.spliteLine2];
    
    
    self.spliteLine3.image=[UIImage imageNamed:@"loginSpliteLine"];
    self.spliteLine3.alpha=0.8f;
    [self.view addSubview:self.spliteLine3];
    
    
    
    self.registerButton.backgroundColor=[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    
    [self.registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton.layer setMasksToBounds:YES];
    [self.registerButton.layer setCornerRadius:10];
    [self.registerButton.layer setBorderWidth:0.5];
    [self.registerButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.view addSubview:self.registerButton];
    
    
    
    self.cancleButton.backgroundColor=[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f];
    [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancleButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    
    [self.cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleButton.layer setMasksToBounds:YES];
    [self.cancleButton.layer setCornerRadius:10];
    [self.cancleButton.layer setBorderWidth:0.5];
    [self.cancleButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.view addSubview:self.cancleButton];
    
    self.userNameTextField.delegate=self;
    self.passwordTextField.delegate=self;
    self.passwordConfirmTextField.delegate=self;
    self.passwordTextField.secureTextEntry=YES;
    self.passwordConfirmTextField.secureTextEntry=YES;
    self.check=YES;
}
-(void)registerButtonClicked:(id)sender
{
    
    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.userNameTextField.text,[self.self.passwordTextField.text base64String]];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userregister.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(responseData != nil){
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if([dict[@"code"] intValue] == 0){
            //注册成功，
            int uid = [dict[@"id"] intValue]; //得到服务器端生成的用户编号。
            NSLog(@"%@,id:%d",dict[@"message"],uid);
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSLog(@"%@",dict[@"message"]);
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名重复，请更换用户名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];

        }
}
//    NSString * userName=self.userNameTextField.text;
//    NSString * password=self.passwordTextField.text;
//    NSString * passwordConfirm=self.passwordConfirmTextField.text;
//    if(userName==nil||password==nil||passwordConfirm==nil)
//    {
//        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名，密码，确认密码均不为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//    }
//    else
//    {
//        if(![password isEqualToString:passwordConfirm])
//        {
//            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }
//        else
//        {
//            EHETchCommunicationManager * communicationManager=[EHETchCommunicationManager getInstance];
//            BOOL ifRegister=[communicationManager registerWithName:userName andPassword:password];
//            if(ifRegister)
//            {
//                NSLog(@"注册成功！");
//                [self.navigationController popViewControllerAnimated:YES];
//            }
//            else
//            {
//                UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名重复，请更换用户名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//            }
//        }
//    }
}
-(void)cancleButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backgroundClicked:(id)sender
{
    
}
-(void)pushComponents
{
    CGRect headImageFrame=self.headImageView.frame;
    CGRect uesrNameFrame=self.userNameTextField.frame;
    CGRect passwordFrame=self.passwordTextField.frame;
    CGRect usernameAccessoryFrame=self.userNameAccessoryImage.frame;
    CGRect passwordAccessoryFrame=self.passwordAccessoryImage.frame;
    CGRect spliteLine1Frame=self.spliteLine1.frame;
    CGRect spliteLine2Frame=self.spliteLine2.frame;
    headImageFrame.origin.y-=35;
    uesrNameFrame.origin.y-=35;
    passwordFrame.origin.y-=35;
    usernameAccessoryFrame.origin.y-=35;
    passwordAccessoryFrame.origin.y-=35;
    spliteLine1Frame.origin.y-=35;
    spliteLine2Frame.origin.y-=35;
    self.headImageView.frame=headImageFrame;
    self.userNameTextField.frame=uesrNameFrame;
    self.passwordTextField.frame=passwordFrame;
    self.userNameAccessoryImage.frame=usernameAccessoryFrame;
    self.passwordAccessoryImage.frame=passwordAccessoryFrame;
    self.spliteLine1.frame=spliteLine1Frame;
    self.spliteLine2.frame=spliteLine2Frame;
}
-(void)pullComponents
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordConfirmTextField resignFirstResponder];
    
    self.headImageView.frame=CGRectMake(0, 0, 320, 150);
    
    self.userNameTextField.frame=CGRectMake(60, 170, 230, 40);
    
    self.userNameAccessoryImage.frame=CGRectMake(25, 175, 30, 30);
    
    self.passwordTextField.frame=CGRectMake(60, 220, 230, 40);
    
    self.passwordAccessoryImage.frame=CGRectMake(25, 225, 30, 30);
    
    self.passwordConfirmTextField.frame=CGRectMake(60, 270, 230, 40);
    
    self.passwordAccessoryImage2.frame=CGRectMake(25, 275, 30, 30);
    
    self.spliteLine1.frame=CGRectMake(22, 210, 268, 2);
    
    self.spliteLine2.frame=CGRectMake(22, 260, 268, 2);
    
    self.spliteLine3.frame=CGRectMake(22, 310, 268, 2);
}

#pragma mark -TextField Delegate Method
#pragma mark -TextField Delegate Method
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if(screenWidth==320&&screenHeight==480)
    {
        
        if(self.check==YES)
        {
            CGRect headImageFrame=self.headImageView.frame;
            CGRect uesrNameFrame=self.userNameTextField.frame;
            CGRect passwordFrame=self.passwordTextField.frame;
            CGRect usernameAccessoryFrame=self.userNameAccessoryImage.frame;
            CGRect passwordAccessoryFrame=self.passwordAccessoryImage.frame;
            CGRect spliteLine1Frame=self.spliteLine1.frame;
            CGRect spliteLine2Frame=self.spliteLine2.frame;
            CGRect passwordConfirmFrame=self.passwordConfirmTextField.frame;
            CGRect passwordAccessoryImage2Frame=self.passwordAccessoryImage2.frame;
            CGRect spliteLine3Frame=self.spliteLine3.frame;
            if(textField==self.passwordTextField)
            {
                
                [self pushComponents];
                
            }
            else if(textField==self.passwordConfirmTextField)
            {
                headImageFrame.origin.y-=90;
                uesrNameFrame.origin.y-=90;
                passwordFrame.origin.y-=90;
                usernameAccessoryFrame.origin.y-=90;
                passwordAccessoryFrame.origin.y-=90;
                spliteLine1Frame.origin.y-=90;
                spliteLine2Frame.origin.y-=90;
                passwordConfirmFrame.origin.y-=90;
                passwordAccessoryImage2Frame.origin.y-=90;
                spliteLine3Frame.origin.y-=90;
                self.headImageView.frame=headImageFrame;
                self.userNameTextField.frame=uesrNameFrame;
                self.passwordTextField.frame=passwordFrame;
                self.userNameAccessoryImage.frame=usernameAccessoryFrame;
                self.passwordAccessoryImage.frame=passwordAccessoryFrame;
                self.spliteLine1.frame=spliteLine1Frame;
                self.spliteLine2.frame=spliteLine2Frame;
                self.passwordAccessoryImage2.frame=passwordAccessoryImage2Frame;
                self.passwordConfirmTextField.frame=passwordConfirmFrame;
                self.spliteLine3.frame=spliteLine3Frame;
                self.check=NO;
            }
            else if(textField==self.userNameTextField)
            {
                self.check=NO;
            }
        }
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if(screenWidth==320&&screenHeight==480)
    {
        self.headImageView.frame=CGRectMake(0, 0, 320, 150);
        
        self.userNameTextField.frame=CGRectMake(60, 170, 230, 40);
        
        self.userNameAccessoryImage.frame=CGRectMake(25, 175, 30, 30);
        
        self.passwordTextField.frame=CGRectMake(60, 220, 230, 40);
        
        self.passwordAccessoryImage.frame=CGRectMake(25, 225, 30, 30);
        
        self.passwordConfirmTextField.frame=CGRectMake(60, 270, 230, 40);
        
        self.passwordAccessoryImage2.frame=CGRectMake(25, 275, 30, 30);
        
        self.spliteLine1.frame=CGRectMake(22, 210, 268, 2);
        
        self.spliteLine2.frame=CGRectMake(22, 260, 268, 2);
        
        self.spliteLine3.frame=CGRectMake(22, 310, 268, 2);
        
        self.check=YES;
    }
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.passwordConfirmTextField resignFirstResponder];
    return YES;
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.txtRegisterName.delegate = self;
//    self.txtRegisterPassword.delegate = self;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//
//- (IBAction)registerButtonPressed:(id)sender {
//        NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.txtRegisterName.text,[self.self.txtRegisterPassword.text base64String]];
//        
//        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userregister.action"]];
//        NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//        if(responseData != nil){
//            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
//            if([dict[@"code"] intValue] == 0){
//                //注册成功，
//                int uid = [dict[@"id"] intValue]; //得到服务器端生成的用户编号。
//                NSLog(@"%@,id:%d",dict[@"message"],uid);
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }else{
//                NSLog(@"%@",dict[@"message"]);
//            }
//        }
//
//    }
//
//- (IBAction)cancelButtonPressed:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
@end
