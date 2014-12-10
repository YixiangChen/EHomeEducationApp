//
//  EHEStdLocationViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/25/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHEStdLocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface EHEStdLocationViewController ()
@property (strong, nonatomic) UITextField *txtLocation;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lblEdit;
@property (strong, nonatomic) UILabel *lblCurrentLocation;
@property (strong, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation EHEStdLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.txtLocation = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, 250, 80)];
    if ([self.orderTable.selectedLocation isEqualToString:@""]) {
        [self.txtLocation setPlaceholder:@"请输入您的位置"];
    }else {
        [self.txtLocation setText:self.orderTable.selectedLocation];
    }
    
    
    
    UIImage *image = [ UIImage imageNamed:@"LocationIcon"];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 50)];
    self.imageView.image = image;
    
    self.lblEdit = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 60)];
    [self.lblEdit setText:@"编辑位置:"];
    [self.lblEdit setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    
    
    self.lblCurrentLocation = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 60)];
    [self.lblCurrentLocation setText:@"获取当前位置"];
    [self.lblCurrentLocation setFont:[UIFont fontWithName:kYueYuanFont size:18]];
    
    [self getAddress];
    [self setExtraCellLineHidden:self.tableView];
    
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
    self.orderTable.selectedLocation = self.txtLocation.text;
    [self.orderTable.tableView reloadData];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row == 0) {
        [self.lblEdit removeFromSuperview];
        [self.txtLocation removeFromSuperview];
        [cell.contentView addSubview:self.lblEdit];
        [cell.contentView addSubview:self.txtLocation];
    }else{
        [self.lblCurrentLocation removeFromSuperview];
        [self.imageView removeFromSuperview];
        [cell.contentView addSubview:self.lblCurrentLocation];
        [cell.contentView addSubview:self.imageView];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        [self getAddress];
        self.txtLocation.text = self.location;
        [self.tableView reloadData];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)getAddress
{
    NSUserDefaults * userDefault=[NSUserDefaults standardUserDefaults];
    NSDictionary * locationDic=[userDefault objectForKey:@"latitudeAndLongitude"];
    NSString * latitude=[locationDic objectForKey:@"latitude"];
    NSString * longitude=[locationDic objectForKey:@"longitude"];
    NSLog(@"latutide=%@,longitude=%@",latitude,longitude);
    
    CLLocation *c = [[CLLocation alloc] initWithLatitude:latitude.floatValue longitude:longitude.floatValue];
    //创建位置
    CLGeocoder *revGeo = [[CLGeocoder alloc] init];
    [revGeo reverseGeocodeLocation:c
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0)
                     {
                         NSDictionary *dict =
                         [[placemarks objectAtIndex:0] addressDictionary];
                         NSString * location=[[dict objectForKey:@"FormattedAddressLines"] objectAtIndex:0];
                         self.location = location;
                         
                     }
                     else
                     {
                         self.location = nil;
                         NSLog(@"ERROR: %@", error);
                     }
                 }];
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
