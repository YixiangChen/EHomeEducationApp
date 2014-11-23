//
//  EHEStdRegisterViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdRegisterViewController.h"
#import "MF_Base64Additions.h"

@interface EHEStdRegisterViewController ()

@end

@implementation EHEStdRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtRegisterName.delegate = self;
    self.txtRegisterPassword.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)registerButtonPressed:(id)sender {
        NSString * postData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",self.txtRegisterName.text,[self.self.txtRegisterPassword.text base64String]];
        
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://218.249.130.194:8080/ehomeedu/api/customer/userregister.action"]];
        NSString * data = [NSString stringWithFormat:@"info=%@",postData];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        if(responseData != nil){
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
            if([dict[@"code"] intValue] == 0){
                //注册成功，
                int uid = [dict[@"id"] intValue]; //得到服务器端生成的用户编号。
                NSLog(@"%@,id:%d",dict[@"message"],uid);
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSLog(@"%@",dict[@"message"]);
            }
        }
    
    }

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
