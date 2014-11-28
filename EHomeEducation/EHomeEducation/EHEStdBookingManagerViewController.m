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
    self.orderDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    self.sendOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.centainOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.cancledOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.unfinishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.finishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    //暂时先不用刷新表，待拿到真实数据然后进行意见统一后在用
    
    /*
    //创建一个自定义的segmentedControl，方法已经封装
    self.segmentedControl =[[EHESegmentedControlManager alloc]initWithItems:[NSArray arrayWithObjects:@"未完成预约",@"已完成预约", nil]];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
     */
    
    //创建tableView并且给之放置样式
    self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    //分割线为单线分割
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    
    self.arrayTeacherInfo=[[NSMutableArray alloc]initWithCapacity:10];
    self.arrayDate=[[NSMutableArray alloc]initWithCapacity:10];
    
    self.realOrdersArray=[[NSMutableArray alloc]initWithCapacity:10];
    
    //[self bandOrdered];
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
    
    [self bandOrdered];
}
-(void)bandOrdered
{
    [self loadData];
    for(EHEOrder * order in self.allOrdersArray)
    {
        EHECommunicationManager * communication=[EHECommunicationManager getInstance];
        [communication loadOrderDetailWithOrderID:order.orderid.intValue];
        NSLog(@"teacherName=%@,subject=%@,orderStatues=%@,orderDate=%@",order.teachername,order.subjectinfo,order.orderstatus,order.orderdate);
        if([order.orderstatus isEqualToString:@"0"])
        {
            [self.sendOrders addObject:order];
        }
        if([order.orderstatus isEqualToString:@"1"])
        {
            [self.centainOrders addObject:order];
        }
        if([order.orderstatus isEqualToString:@"2"]||[order.orderstatus isEqualToString:@"3"])
        {
            [self.cancledOrders addObject:order];
        }
        if([order.orderstatus isEqualToString:@"4"]||[order.orderstatus isEqualToString:@"5"])
        {
            [self.unfinishedOrders addObject:order];
        }
        if([order.orderstatus isEqualToString:@"6"])
        {
            [self.finishedOrders addObject:order];
        }
    }
    [self.orderDictionary setObject:self.sendOrders forKey:@"刚发出的订单"];
    [self.orderDictionary setObject:self.centainOrders forKey:@"教师确认订单"];
    [self.orderDictionary setObject:self.cancledOrders forKey:@"已取消的订单"];
    [self.orderDictionary setObject:self.unfinishedOrders forKey:@"未完成订单"];
    [self.orderDictionary setObject:self.finishedOrders forKey:@"已完成的订单"];
}
-(void)loadData
{
    self.allOrdersArray=nil;
    [self.orderDictionary removeAllObjects];
    [self.sendOrders removeAllObjects];
    [self.cancledOrders removeAllObjects];
    [self.centainOrders removeAllObjects];
    [self.unfinishedOrders removeAllObjects];
    [self.finishedOrders removeAllObjects];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    NSLog(@"mycustomerid=%@",customerid);
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    [coreDataManager removeAllOrdersFromCoreData];
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    [communicationManager loadOrderInfosWithCustomerID:customerid.intValue andOrderStatus:-1];
    
    self.allOrdersArray=[coreDataManager fetchOrderInfosWithCustomerID:customerid.intValue andOrderStatus:-1];
    //NSLog(@"allOrdersArray 里面的个数是%d ",self.allOrdersArray.count);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section==0)
    {
        NSArray *array= [self.orderDictionary objectForKey:[self.orderDictionary.allKeys objectAtIndex:0]] ;
        return [array count];
    }
    else if(section==1)
    {
        NSArray *array= [self.orderDictionary objectForKey:[self.orderDictionary.allKeys objectAtIndex:1]] ;
        return [array count];
    }
    else if(section==2)
    {
        NSArray *array= [self.orderDictionary objectForKey:[self.orderDictionary.allKeys objectAtIndex:2]] ;
        return [array count];
    }
    else if(section==3)
    {
        NSArray *array= [self.orderDictionary objectForKey:[self.orderDictionary.allKeys objectAtIndex:3]] ;
        return [array count];
    }
    else if(section==4)
    {
      NSArray *array= [self.orderDictionary objectForKey:[self.orderDictionary.allKeys objectAtIndex:4]] ;
        return [array count];
    }
    
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.orderDictionary.allKeys count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * Identifier=@"Identifier";
    EHEStdBookingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdBookingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSArray * allKeys=[self.orderDictionary allKeys];
    NSArray * allOrders=[self.orderDictionary objectForKey:[allKeys objectAtIndex:[indexPath section]]];
    NSArray * array=[self.orderDictionary objectForKey:@"刚发出的订单"];
    NSLog(@"allOrdersCount=%d",array.count);
    EHEOrder * order=[allOrders objectAtIndex:[indexPath row]];
    cell.labelTeacherInfomation.text=order.teachername;
    cell.labelDate.text=order.orderdate;
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
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.orderDictionary.allKeys objectAtIndex:section];
}
@end
