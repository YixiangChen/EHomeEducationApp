//
//  EHEStdLoginViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdLoginViewController.h"
#import "MF_Base64Additions.h"

@interface EHEStdLoginViewController ()

@end

@implementation EHEStdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtPassWord.delegate = self;
    self.txtUserName.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginButtonPressed:(id)sender {
    
    NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.txtUserName.text,[self.txtPassWord.text base64String]];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userlogin.action"]];
    NSString * data = [NSString stringWithFormat:@"info=%@",postData];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(responseData != nil){
        //使用系统自带JSON解析方法
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        if([dict[@"code"] intValue] == 0){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.txtUserName.text forKey:@"userName"];
            [defaults setObject:self.txtPassWord.text forKey:@"passWord"];
            [defaults synchronize];
        }else{
            NSLog(@"%@",dict[@"message"]);
        }
    }
}

//-(void) pushToSearchingViewController {
//    EHEStdSearchingTableViewController *searchingTable =[[EHEStdSearchingTableViewController alloc] initWithNibName:nil bundle:nil];
//    UINavigationController *navi_searching = [[UINavigationController alloc] initWithRootViewController:searchingTable];
//    
//    EHEStdMapSearchingViewController * mapViewController=[[EHEStdMapSearchingViewController alloc]initWithNibName:nil bundle:nil];
//    UINavigationController * navi_mapSearching=[[UINavigationController alloc]initWithRootViewController:mapViewController];
//    navi_mapSearching.navigationBarHidden=YES;
//    
//    
//    EHEStdBookingManagerViewController *bookingManager = [[EHEStdBookingManagerViewController alloc] initWithNibName:nil bundle:nil];
//    EHEStdSettingViewController *setting = [[EHEStdSettingViewController alloc] initWithNibName:nil bundle:nil];
//    
//    UITabBarController *tab = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
//    //tab.viewControllers = @[navi_searching,bookingManager, setting];
//    tab.viewControllers = @[navi_searching,bookingManager, setting];
//    [[tab.viewControllers objectAtIndex:0] setTitle:@"首页"];
//    [[tab.viewControllers objectAtIndex:1] setTitle:@"我的"];
//    [[tab.viewControllers objectAtIndex:2] setTitle:@"设置"];
//    tab.tabBar.backgroundColor = [UIColor grayColor];
//    
//    self.window.rootViewController = tab;
//}
- (IBAction)cancelButtonPressed:(id)sender {
}

- (IBAction)forgetPasswordButtonPressed:(id)sender {
}

- (IBAction)goToRegisterButtonPressed:(id)sender {
}
@end
