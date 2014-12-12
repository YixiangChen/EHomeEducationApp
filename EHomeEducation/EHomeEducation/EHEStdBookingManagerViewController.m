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
#import "AFHTTPRequestOperation.h"
#import "MJRefresh.h"
@interface EHEStdBookingManagerViewController ()

@end

@implementation EHEStdBookingManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"订单信息";
    
    //实例化这些可变数组和可变字典，以便以后添加数据
    self.orderDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    self.sentOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.confirmedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.canceledOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.unfinishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.finishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
       self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
       self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStyleGrouped];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414, 736) style:UITableViewStyleGrouped];
    }
    //分割线为单线分割
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self.homeTeacherTableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
}

-(void) headerRefreshing {
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    
    bool refreshSuccess;
    refreshSuccess = [[EHECommunicationManager getInstance] loadAllOrderWithCustomerID:customerid.intValue];
    [self loadData];
    [self.homeTeacherTableView reloadData];
    [self.homeTeacherTableView headerEndRefreshing];
    if (refreshSuccess) {
        NSLog(@"更新成功");
    }else {
        NSLog(@"更新失败");
    }
    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
//    NSString * userName=[userDefaults objectForKey:@"userName"];
//    NSString * password=[userDefaults objectForKey:@"passWord"];
//    NSLog(@"userName=%@,password=%@",userName,password);
//    EHEStdLoginViewController *loginViewController = [[EHEStdLoginViewController alloc] initWithNibName:nil bundle:nil];
//    if (userName == nil || password== nil) {
//        //如果没有登录的话要显示登录界面，并且隐藏导航栏
//        [[self navigationController] setNavigationBarHidden:YES animated:YES];//隐藏导航栏
//        [self.navigationController pushViewController:loginViewController animated:NO];
//    }
//    else
//    {
//        [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    }
//}
//在界面刚显示出来的时候就要对数据进行更新
-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguageNotificationName" object:nil];
    [self headerRefreshing];
}
-(void) changeLanguage:(NSNotification *)noti
{
    //[self bandOrdered];
    [self.homeTeacherTableView reloadData];
}
//加载订单数组和字典
-(void)loadData
{
    //先清空所有之前的数据
    [self.orderDictionary removeAllObjects];
    [self.sentOrders removeAllObjects];
    [self.canceledOrders removeAllObjects];
    [self.confirmedOrders removeAllObjects];
    [self.unfinishedOrders removeAllObjects];
    [self.finishedOrders removeAllObjects];
    //从NSUserDefaults中获取customerid
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];

    [[EHECoreDataManager getInstance] removeAllOrdersFromCoreData];
    [[EHECommunicationManager getInstance] loadAllOrderWithCustomerID:customerid.intValue];
    
    [self.sentOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:0]];
    
    [self.confirmedOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:1]];
    
    [self.canceledOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:2]];
    [self.canceledOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:3]];
    
    [self.unfinishedOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:4]];
    [self.unfinishedOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:5]];

    [self.finishedOrders addObjectsFromArray:[[EHECoreDataManager getInstance] fetchOrderInfosWithStatus:6]];
    
    [self.homeTeacherTableView reloadData];


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return self.sentOrders.count == 0?1:self.sentOrders.count;
    }
    else if(section==1)
    {
        return self.confirmedOrders.count == 0?1:self.confirmedOrders.count;
    }
    else if(section==2)
    {
        return self.canceledOrders.count == 0?1:self.canceledOrders.count;
    }
    else if(section==3)
    {
        return self.unfinishedOrders.count == 0?1:self.unfinishedOrders.count;
    }
    else {
        return self.finishedOrders.count == 0?1:self.finishedOrders.count;
    }
    
}
//分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
//绑定数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    EHEStdBookingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdBookingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    //如果dictionary中的key对应的value有数据则返回订单数据，如果没有，则返回空
    NSArray * allOrders=nil;
    if([indexPath section]==0)
    {
    allOrders=self.sentOrders;
    }
    else if([indexPath section]==1)
    {
    allOrders=self.confirmedOrders;
    }
    else if([indexPath section]==2)
    {
    allOrders=self.canceledOrders;
    }
    else if([indexPath section]==3)
    {
    allOrders= self.unfinishedOrders;
    }
    else if([indexPath section]==4)
    {
    allOrders=self.finishedOrders;
    }
    cell.teacherIcon.image=[UIImage imageNamed:@"male_tablecell"];
    if(allOrders.count==0)
    {
        cell.labelTeacherInfomation.text=nil;
        cell.labelDate.text=nil;
        cell.teacherIcon.image=nil;
        cell.labelSubject.text=nil;
    }
    else
    {
    EHEOrder * order=[allOrders objectAtIndex:[indexPath row]];
    cell.labelTeacherInfomation.text=order.teachername;
    cell.labelTeacherInfomation.font=[UIFont fontWithName:@"FZKATJW--GB1-0" size:16.0f];
    cell.labelDate.text=order.orderdate;
    cell.labelDate.textColor=[UIColor grayColor];
    cell.labelSubject.text=[NSString stringWithFormat:@"科目:%@",order.subjectinfo];
    cell.labelSubject.font=[UIFont fontWithName:@"MYoungHKS" size:14.0f];
    cell.labelDate.font=[UIFont fontWithName:@"FZKATJW--GB1-0" size:14.0f];

    }
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击之后灰色一闪而过，不留痕迹
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //如果对应的分组没有订单数据，则点击没有效果，反之点击向bookingDetail传值order
    NSInteger section=[indexPath section];
    NSArray * ordersArray=nil;
    if(section==0)
    {
     ordersArray= self.sentOrders;
    }
    else if(section==1)
    {
      ordersArray= self.confirmedOrders;
    }
    else if(section==2)
    {
      ordersArray= self.canceledOrders;
    }
    else if(section==3)
    {
        ordersArray= self.unfinishedOrders;
    }
    else
    {
        ordersArray= self.finishedOrders;
    }
    if(ordersArray.count>0)
    {
      
    EHEStdBookingDetailViewController * bookingDetailViewController=[[EHEStdBookingDetailViewController alloc]initWithNibName:nil bundle:nil];
    EHEOrder * order=(EHEOrder *)[ordersArray objectAtIndex:[indexPath row]];
    bookingDetailViewController.order=order;
    [self.navigationController pushViewController:bookingDetailViewController animated:YES];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if(section==0)
    {
      return @"刚发出的订单";
    }
    else if(section==1)
    {
     return @"已确认的订单";
    }
    else if(section==2)
    {
        return @"取消的订单";
    }
    else if(section==3)
    {
        return @"未完成的订单";
    }
    else if(section==4)
    {
        return @"已完成的订单";
    }
    return nil;
}
@end
