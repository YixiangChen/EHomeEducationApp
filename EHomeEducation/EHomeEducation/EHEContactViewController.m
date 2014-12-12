//
//  EHEContactViewController.m
//  EHomeEduTeacher
//
//  Created by Yixiang Chen on 12/12/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEContactViewController.h"
#import "Defines.h"

@interface EHEContactViewController ()
@property (strong, nonatomic) UILabel *lblNameOfDeveloper1;
@property (strong, nonatomic) UILabel *lblNameOfDeveloper2;

@property (strong, nonatomic) UIButton *btnEmailOfDeveloper1;
@property (strong, nonatomic) UIButton *btnEmailOfDeveloper2;

@property (strong, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation EHEContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.lblNameOfDeveloper1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 100, 30)];
    [self.lblNameOfDeveloper1 setText:@"陈沂湘"];
    [self.lblNameOfDeveloper1 setFont:[UIFont fontWithName:kYueYuanFont size:20]];
    [self.lblNameOfDeveloper1 setTextColor:kGreenForTabbaritem];

    UIImageView *imageLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 145, screenWidth - 20, 2)];
    imageLine1.image = [UIImage imageNamed:@"line"];
    
    self.btnEmailOfDeveloper1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, screenWidth - 20, 50)];
    [self.btnEmailOfDeveloper1 setTitle:@"yixiang.chen1988@googlemail.com" forState:UIControlStateNormal ];
    self.btnEmailOfDeveloper1.opaque = YES;
    [self.btnEmailOfDeveloper1.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:16]];
    [self.btnEmailOfDeveloper1 setTintColor:[UIColor whiteColor]];
    [self.btnEmailOfDeveloper1 setBackgroundColor:kLightGreenForMainColor];
    [self.btnEmailOfDeveloper1.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.btnEmailOfDeveloper1 addTarget:self action:@selector(mailToYixiang) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer1 =  [self.btnEmailOfDeveloper1 layer];
    [layer1 setMasksToBounds:YES];
    [layer1 setCornerRadius:5.0];
    
    

    
    self.lblNameOfDeveloper2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 190, 30)];
    [self.lblNameOfDeveloper2 setText:@"邱德政"];
    [self.lblNameOfDeveloper2 setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    [self.lblNameOfDeveloper2 setTextColor:kGreenForTabbaritem];
    
    UIImageView *imageLine2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 265, screenWidth - 20, 2)];
    imageLine2.image = [UIImage imageNamed:@"line"];
    
    self.btnEmailOfDeveloper2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 280, screenWidth - 20, 50)];
    [self.btnEmailOfDeveloper2 setTitle:@"846431539@qq.com" forState:UIControlStateNormal ];
    [self.btnEmailOfDeveloper2.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:16]];
    [self.btnEmailOfDeveloper2 setTintColor:kGreenForTabbaritem];
    [self.btnEmailOfDeveloper2 setTintColor:[UIColor whiteColor]];
    [self.btnEmailOfDeveloper2 setBackgroundColor:kLightGreenForMainColor];
    [self.btnEmailOfDeveloper2.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.btnEmailOfDeveloper2 addTarget:self action:@selector(mailToDezheng) forControlEvents:UIControlEventTouchUpInside];
    CALayer * layer2 =  [self.btnEmailOfDeveloper2 layer];
    [layer2 setMasksToBounds:YES];
    [layer2 setCornerRadius:5.0];
    
    [self.view addSubview:self.btnEmailOfDeveloper1];
    [self.view addSubview:self.btnEmailOfDeveloper2];
    [self.view addSubview:self.lblNameOfDeveloper1];
    [self.view addSubview:self.lblNameOfDeveloper2];
    [self.view addSubview:imageLine1];
    [self.view addSubview:imageLine2];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 80, 30)];
    [self.leftBarButton setTitle:@"<设置" forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:15]];
    [self.leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBarButton setBackgroundColor:kGreenForTabbaritem];
    [self.leftBarButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer * leftBarButtonLayer =  [self.leftBarButton layer];
    [leftBarButtonLayer setMasksToBounds:YES];
    [leftBarButtonLayer setCornerRadius:5.0];
    [leftBarButtonLayer setBorderWidth:0.5];
    [leftBarButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.navigationController.navigationBar addSubview:self.leftBarButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2 - 50, 5, 100, 30)];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setText:@"联系我们"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.titleLabel removeFromSuperview];
    [self.leftBarButton removeFromSuperview];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) mailToYixiang {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:yixiang.chen1988@googlemail.com"]];
}

-(void) mailToDezheng {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:846431539@qq.com"]];
}

@end
