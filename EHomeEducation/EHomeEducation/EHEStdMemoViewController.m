//
//  EHEStdMemoViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/25/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHEStdMemoViewController.h"


@interface EHEStdMemoViewController ()
@property (strong, nonatomic) UILabel *lblPlaceHolder;
@property (strong, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation EHEStdMemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.txtViewMemo.delegate = self;
    CALayer *layer = self.txtViewMemo.layer;
    layer.borderWidth =1.0;
    layer.cornerRadius =5.0;
    layer.borderColor = kGreenForTabbaritem.CGColor;
    self.txtViewMemo.text = self.orderTable.selectedMemo;
    
    self.lblPlaceHolder.frame =CGRectMake(20, 100, 200, 20);
    self.lblPlaceHolder.text = @"请填写备注";
    self.lblPlaceHolder.enabled = NO;//lable必须设置为不可用
    self.lblPlaceHolder.backgroundColor = [UIColor clearColor];
    [self.lblPlaceHolder setTextColor:[UIColor lightGrayColor]];
    [self.lblPlaceHolder setFont:[UIFont fontWithName:kYueYuanFont size:17]];
    [self.view addSubview:self.lblPlaceHolder];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = nil;
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.leftBarButton = [[UIButton alloc] initWithFrame:CGRectMake(3, 8, 90, 30)];
    [self.leftBarButton setTitle:@"< 教师详情" forState:UIControlStateNormal];
    [self.leftBarButton.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    [self.leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.leftBarButton setBackgroundColor:kGreenForTabbaritem];
    [self.leftBarButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer * leftBarButtonLayer =  [self.leftBarButton layer];
    [leftBarButtonLayer setMasksToBounds:YES];
    [leftBarButtonLayer setCornerRadius:5.0];
    [leftBarButtonLayer setBorderWidth:0.5];
    [leftBarButtonLayer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.navigationController.navigationBar addSubview:self.leftBarButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 100, 30)];
    [self.titleLabel setText:@"预约详情"];
    [self.titleLabel setTextColor:kGreenForTabbaritem];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont fontWithName:kYueYuanFont size:22]];
    [self.navigationController.navigationBar addSubview:self.titleLabel];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.leftBarButton removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.orderTable.selectedMemo = self.txtViewMemo.text;
    [self.orderTable.tableView reloadData];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.lblPlaceHolder.text = @"请填写备注";
    }else{
        self.lblPlaceHolder.text = @"";
    }
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

@end
