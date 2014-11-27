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
#import "EHECommunicationManager.h"
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
    
    self.arrayTeacherInfo=[[NSMutableArray alloc]initWithCapacity:10];
    self.arrayDate=[[NSMutableArray alloc]initWithCapacity:10];
    
    self.realOrdersArray=[[NSMutableArray alloc]initWithCapacity:10];
    
    [self bandUnOrdered];
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
    
    [self bandUnOrdered];
}
-(void)bandUnOrdered
{
    [self loadData];
    for(EHEOrder * order in self.allOrdersArray)
    {
        EHECommunicationManager * communication=[EHECommunicationManager getInstance];
        [communication loadOrderDetailWithOrderID:order.orderid.intValue];
        NSString * teacherInfo=[NSString stringWithFormat:@"%@：%@",order.teachername,order.subjectinfo];
        [self.arrayTeacherInfo addObject:teacherInfo];
        [self.arrayDate addObject:order.orderdate];
        [self.realOrdersArray addObject:order];
    }
}
-(void)bandOrdered
{
    [self loadData];
    for(EHEOrder * order in self.allOrdersArray)
    {
        EHECommunicationManager * communication=[EHECommunicationManager getInstance];
        [communication loadOrderDetailWithOrderID:order.orderid.intValue];
        if([order.orderstatus isEqualToString:@"1"])
        {
            NSString * teacherInfo=[NSString stringWithFormat:@"%@：%@",order.teachername,order.subjectinfo];
            [self.arrayTeacherInfo addObject:teacherInfo];
            [self.arrayDate addObject:order.orderdate];
            [self.realOrdersArray addObject:order];
        }
    }
}
-(void)loadData
{
    [self.realOrdersArray removeAllObjects];
    self.allOrdersArray=nil;
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    [coreDataManager removeAllOrdersFromCoreData];
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    [communicationManager loadOrderInfosWithCustomerID:customerid.intValue andOrderStatus:0];
    
    self.allOrdersArray=[coreDataManager fetchOrderInfosWithCustomerID:customerid.intValue andOrderStatus:-1];
    NSLog(@"allOrdersArray 里面的个数是%d ",self.allOrdersArray.count);
    [self.arrayTeacherInfo removeAllObjects];
    [self.arrayDate removeAllObjects];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当segmentedControl方法改变时，触发该方法
-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)//当点击未完成预约时
    {
        [self bandUnOrdered];
        [self.homeTeacherTableView reloadData];
    }
    else//当点击已完成预约时
    {
        [self bandOrdered];
        [self.homeTeacherTableView reloadData];
    }
    
}
#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"有%d行数据",[self.realOrdersArray count]);
    return [self.realOrdersArray count];
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
    EHEOrder * order=(EHEOrder *)[self.realOrdersArray objectAtIndex:[indexPath row]];
    bookingDetailViewController.order=order;
    [self.navigationController pushViewController:bookingDetailViewController animated:YES];
}
@end
