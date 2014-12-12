//
//  EHEStdLoginViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdLoginViewController.h"
#import "MF_Base64Additions.h"
#import "EHEStdRegisterViewController.h"
#import "Defines.h"

@interface EHEStdLoginViewController ()

@end

@implementation EHEStdLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    headImageView.image=[UIImage imageNamed:@"loginHeader"];
    [self.view addSubview:headImageView];
    
    self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 170, 230, 40)];
    self.userNameTextField.borderStyle=UITextBorderStyleNone;
    self.userNameTextField.placeholder=@"请输入用户名.....";
    [self.view addSubview:self.userNameTextField];
    
    UIImageView * userNameAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 175, 30, 30)];
    userNameAccessoryImage.image=[UIImage imageNamed:@"loginIcon"];
    [self.view addSubview:userNameAccessoryImage];
    
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(60, 220, 230, 40)];
    self.passwordTextField.borderStyle=UITextBorderStyleNone;
    self.passwordTextField.placeholder=@"请输入密码......";
    [self.view addSubview:self.passwordTextField];
    
    UIImageView * passwordAccessoryImage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 225, 30, 30)];
    passwordAccessoryImage.image=[UIImage imageNamed:@"code"];
    [self.view addSubview:passwordAccessoryImage];
    
    UIImageView * spliteLine1=[[UIImageView alloc]initWithFrame:CGRectMake(22, 210, 268, 2)];
    spliteLine1.image=[UIImage imageNamed:@"loginSpliteLine"];
    spliteLine1.alpha=0.8f;
    [self.view addSubview:spliteLine1];
    
    UIImageView * spliteLine2=[[UIImageView alloc]initWithFrame:CGRectMake(22, 260, 268, 2)];
    spliteLine2.image=[UIImage imageNamed:@"loginSpliteLine"];
    spliteLine2.alpha=0.8f;
    [self.view addSubview:spliteLine2];
    
    self.userNameTextField.delegate=self;
    self.passwordTextField.delegate=self;
    self.passwordTextField.secureTextEntry=YES;
    
    self.loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginButton.frame=CGRectMake(22, 290, 268, 40);
    self.loginButton.backgroundColor=[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f];
    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    
    [self.loginButton addTarget:self action:@selector(loignButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton.layer setMasksToBounds:YES];
    [self.loginButton.layer setCornerRadius:10];
    [self.loginButton.layer setBorderWidth:0.5];
    [self.loginButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.view addSubview:self.loginButton];
    
    self.forgetPasswordButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.forgetPasswordButton.frame=CGRectMake(30, 370, 100, 30);
    [self.forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPasswordButton setTitleColor:[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f] forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    [self.view addSubview:self.forgetPasswordButton];
    
    self.registerButton=[UIButton buttonWithType:UIButtonTypeSystem];
    self.registerButton.frame=CGRectMake(190, 370, 100, 30);
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:1.0f] forState:UIControlStateNormal];
    self.registerButton.titleLabel.font=[UIFont fontWithName:kYueYuanFont size:16.0f];
    [self.registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loignButtonClicked:(id)sender
{
    if(self.userNameTextField.text==nil||self.passwordTextField.text==nil)
    {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名或密码不得为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.userNameTextField.text,[self.passwordTextField.text base64String]];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userlogin.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
    if(responseData != nil){
        //使用系统自带JSON解析方法
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        if([dict[@"code"] intValue] == 0){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.userNameTextField.text forKey:@"userName"];
            [defaults setObject:self.passwordTextField.text forKey:@"passWord"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"usericon"] forKey:@"userIcons"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"customerid"] forKey:@"myCustomerid"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"name"] forKey:@"name"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"telephone"] forKey:@"telephone"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"gender"] forKey:@"gender"];
            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"memo"] forKey:@"birthday"];
            [defaults synchronize];
            [self dismissViewControllerAnimated:NO completion:nil];
            
        }else{
            NSLog(@"%@",dict[@"message"]);
            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"登陆失败，用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
}
-(void)registerButtonClicked:(id)sender
{
    EHEStdRegisterViewController * registerViewController=[[EHEStdRegisterViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:registerViewController animated:YES completion:nil];
}
-(void)saveUserNameAndPassword
{
    NSString * userName=self.userNameTextField.text;
    NSString * password=self.passwordTextField.text;
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userName forKey:@"userName"];
    [userDefaults setObject:password forKey:@"passWord"];
    [userDefaults synchronize];
    
}
//点击背景两个TextField放弃第一响应者身份
-(IBAction)backgrounCliked:(id)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
#pragma mark- TextField Delegate Method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}


//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.txtPassWord.delegate = self;
//    self.txtUserName.delegate = self;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
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
//-(void)viewWillAppear:(BOOL)animated
//{
//    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
//    NSString * userName=[userDefaults objectForKey:@"userName"];
//    NSString * password=[userDefaults objectForKey:@"passWord"];
//    NSLog(@"userName=%@,password=%@",userName,password);
//    if (userName != nil && password!= nil)
//    {
//        [self.navigationController popViewControllerAnimated:NO];
//    }
//    
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}
//
//- (IBAction)loginButtonPressed:(id)sender {
//    
//    if(self.txtUserName.text==nil||self.txtPassWord.text==nil)
//    {
//        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名或密码不得为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
//    }
//    
//    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.txtUserName.text,[self.txtPassWord.text base64String]];
//    
//    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userlogin.action"]];
//    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"%@",[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
//    if(responseData != nil){
//        //使用系统自带JSON解析方法
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
//        NSLog(@"%@",dict);
//        if([dict[@"code"] intValue] == 0){
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:self.txtUserName.text forKey:@"userName"];
//            [defaults setObject:self.txtPassWord.text forKey:@"passWord"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"usericon"] forKey:@"userIcons"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"customerid"] forKey:@"myCustomerid"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"name"] forKey:@"name"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"telephone"] forKey:@"telephone"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"gender"] forKey:@"gender"];
//            [defaults setObject:[[dict objectForKey:@"userinfo"] objectForKey:@"memo"] forKey:@"birthday"];
//            [defaults synchronize];
//            [self dismissViewControllerAnimated:NO completion:nil];
// 
//        }else{
//            NSLog(@"%@",dict[@"message"]);
//            UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"登陆失败，用户名或密码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }
//    }
//}
//
//
//- (IBAction)cancelButtonPressed:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (IBAction)forgetPasswordButtonPressed:(id)sender {
//}
//
//- (IBAction)goToRegisterButtonPressed:(id)sender {
//    
//    EHEStdRegisterViewController *registerViewController = [[EHEStdRegisterViewController alloc] initWithNibName:nil bundle:nil];
//    [self presentViewController:registerViewController animated:YES completion:nil];
//}
//
@end
