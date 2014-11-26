//
//  EHEStdBookingManagerViewController.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-18.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdBookingManagerViewController.h"
#import "EHECoreDataManager.h"
#import "EHEOrder.h"
#import "EHETeacher.h"
#import "EHEStdBookingDetailViewController.h"
#import "EHEStdLoginViewController.h"
@interface EHEStdBookingManagerViewController ()

@end

@implementation EHEStdBookingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.teacherArray=[[NSMutableArray alloc]initWithCapacity:10];
    //暂时先不用刷新表，待拿到真实数据然后进行意见统一后在用
    [self bandUnOrdered];
    //创建一个自定义的segmentedControl，方法已经封装
    self.segmentedControl =[[EHESegmentedControlManager alloc]initWithItems:[NSArray arrayWithObjects:@"未完成预约",@"已完成预约", nil]];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    //创建tableView并且给之放置样式
    self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    //分割线为单线分割
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * userName=[userDefaults objectForKey:@"userName"];
    NSString * password=[userDefaults objectForKey:@"passWord"];
    //[userDefaults synchronize];
    NSLog(@"userName=%@,password=%@",userName,password);
    EHEStdLoginViewController *loginViewController = [[EHEStdLoginViewController alloc] initWithNibName:nil bundle:nil];
    if (userName == nil || password== nil) {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];//隐藏导航栏
        [self.navigationController pushViewController:loginViewController animated:NO];
    }
    else
    {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
}
-(void)bandUnOrdered
{
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    self.arrayTeacherInfo=[[NSMutableArray alloc]initWithCapacity:10];
    self.arrayDate=[[NSMutableArray alloc]initWithCapacity:10];
    for(EHEOrder * order in [coreDataManager fetchAllOrders])
    {
        if([order.orderstatus isEqualToString:@"0"])
        {
            EHETeacher * teacher=[coreDataManager fetchDetailInfosWithTeacherId:order.teacherid.intValue];
            NSString * teacherInfo=[NSString stringWithFormat:@"%@：%@",teacher.name,order.subjectinfo];
            [self.arrayTeacherInfo addObject:teacherInfo];
            [self.arrayDate addObject:order.orderdate];
            [self.teacherArray addObject:teacher];
        }
    }
}
-(void)bandOrdered
{
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    self.arrayTeacherInfo=[[NSMutableArray alloc]initWithCapacity:10];
    self.arrayDate=[[NSMutableArray alloc]initWithCapacity:10];
    for(EHEOrder * order in [coreDataManager fetchAllOrders])
    {
        if([order.orderstatus isEqualToString:@"1"])
        {
            EHETeacher * teacher=[coreDataManager fetchDetailInfosWithTeacherId:order.teacherid.intValue];
            NSString * teacherInfo=[NSString stringWithFormat:@"%@：%@",teacher.name,order.subjectinfo];
            [self.arrayTeacherInfo addObject:teacherInfo];
            [self.arrayDate addObject:order.orderdate];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当segmentedControl方法改变时，触发该方法
-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)//当点击未完成预约时
    {
        self.arrayTeacherInfo=nil;
        [self bandUnOrdered];
        [self.homeTeacherTableView reloadData];
    }
    else//当点击已完成预约时
    {
        self.arrayTeacherInfo=nil;
        [self bandOrdered];
        [self.homeTeacherTableView reloadData];
    }
    
}
#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayTeacherInfo count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    EHEStdBookingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdBookingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.labelTeacherInfomation.text=[self.arrayTeacherInfo objectAtIndex:[indexPath row]];
    cell.labelDate.text=[self.arrayDate objectAtIndex:[indexPath row]];
    cell.labelDate.textColor=[UIColor grayColor];
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EHEStdBookingDetailViewController * bookingDetailViewController=[[EHEStdBookingDetailViewController alloc]initWithNibName:nil bundle:nil];
    bookingDetailViewController.teacherName=[self.arrayTeacherInfo objectAtIndex:[indexPath row]];
    bookingDetailViewController.orderDate=[self.arrayDate objectAtIndex:[indexPath row]];
    bookingDetailViewController.teacher=[self.teacherArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:bookingDetailViewController animated:YES];
}
@end
