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
    
    self.title=@"订单信息";
    
    //实例化这些可变数组和可变字典，以便以后添加数据
    self.orderDictionary=[[NSMutableDictionary alloc]initWithCapacity:0];
    self.sendOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.centainOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.cancledOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.unfinishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    self.finishedOrders=[[NSMutableArray alloc]initWithCapacity:10];
    
    //创建tableView并且给之放置样式
    self.homeTeacherTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
    self.homeTeacherTableView.dataSource=self;
    self.homeTeacherTableView.delegate=self;
    //分割线为单线分割
    self.homeTeacherTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.homeTeacherTableView];
    
    // Do any additional setup after loading the view from its nib.
}
//在界面刚显示出来的时候就要对数据进行更新
-(void)viewWillAppear:(BOOL)animated
{
    //通过NSUserDefaults来对用户名进行拿取
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * userName=[userDefaults objectForKey:@"userName"];
    NSString * password=[userDefaults objectForKey:@"passWord"];
    NSLog(@"userName=%@,password=%@",userName,password);
    EHEStdLoginViewController *loginViewController = [[EHEStdLoginViewController alloc] initWithNibName:nil bundle:nil];
    if (userName == nil || password== nil) {
        //如果没有登录的话要显示登录界面，并且隐藏导航栏
        [[self navigationController] setNavigationBarHidden:YES animated:YES];//隐藏导航栏
        [self.navigationController pushViewController:loginViewController animated:NO];
    }
    else
    {
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
    }
    
    [self bandOrdered];
}
//加载订单数组和字典
-(void)loadData
{
    //先清空所有之前的数据
    self.allOrdersArray=nil;
    [self.orderDictionary removeAllObjects];
    [self.sendOrders removeAllObjects];
    [self.cancledOrders removeAllObjects];
    [self.centainOrders removeAllObjects];
    [self.unfinishedOrders removeAllObjects];
    [self.finishedOrders removeAllObjects];
    //从NSUserDefaults中获取customerid
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    NSLog(@"mycustomerid=%@",customerid);
    //从coreData中获取数据
    EHECoreDataManager * coreDataManager=[EHECoreDataManager getInstance];
    [coreDataManager removeAllOrdersFromCoreData];
    //把订单数据下载到CoreData中，下载所有的订单
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    [communicationManager loadOrderInfosWithCustomerID:customerid.intValue andOrderStatus:-1];
    //从CoreData中根据customerid来获取订单信息
    self.allOrdersArray=[coreDataManager fetchOrderInfosWithCustomerID:customerid.intValue andOrderStatus:-1];
}

//加载所有的订单数据
-(void)bandOrdered
{
    //首先先加载数据
    [self loadData];
    for(EHEOrder * order in self.allOrdersArray)
    {
        //从网络上对数据进行请求
        EHECommunicationManager * communication=[EHECommunicationManager getInstance];
        [communication loadOrderDetailWithOrderID:order.orderid.intValue];
        NSLog(@"teacherName=%@,subject=%@,orderStatues=%@,orderDate=%@",order.teachername,order.subjectinfo,order.orderstatus,order.orderdate);
        //根据订单的类型对订单进行管理，不同的订单类型放在不同的数组中
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
    //对不同的订单数组放到字典中，对应不同的key，以便以后进行排序
    [self.orderDictionary setObject:self.sendOrders forKey:@"刚发出的订单"];
    [self.orderDictionary setObject:self.centainOrders forKey:@"教师确认订单"];
    [self.orderDictionary setObject:self.cancledOrders forKey:@"已取消的订单"];
    [self.orderDictionary setObject:self.unfinishedOrders forKey:@"未完成订单"];
    [self.orderDictionary setObject:self.finishedOrders forKey:@"已完成的订单"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableView DataSource Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //每个字典中的key 所对应的order的数量，如果key所对应的value没有值，那么返回1；
    NSArray * dictionaryAllKeys=[self.orderDictionary allKeys];
    NSArray * ordersInSection=[self.orderDictionary objectForKey:[dictionaryAllKeys objectAtIndex:section]];
    if([ordersInSection count]==0)
    {
        return 1;
    }
    else
    {
    return [ordersInSection count];
    }
}
//分组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.orderDictionary.allKeys count];
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
    NSArray * allKeys=[self.orderDictionary allKeys];
    NSArray * allOrders=[self.orderDictionary objectForKey:[allKeys objectAtIndex:[indexPath section]]];
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
    cell.labelDate.text=order.orderdate;
    cell.labelDate.textColor=[UIColor grayColor];
    cell.labelSubject.text=[NSString stringWithFormat:@"科目:%@",order.subjectinfo];
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
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
    NSArray * allKeys= [self.orderDictionary allKeys];
    NSString * key=[allKeys objectAtIndex:[indexPath section]];
    NSArray * valueArray= [self.orderDictionary objectForKey:key];
    if(valueArray.count==0)
    {
      
    }
    else
    {
    EHEStdBookingDetailViewController * bookingDetailViewController=[[EHEStdBookingDetailViewController alloc]initWithNibName:nil bundle:nil];
    EHEOrder * order=(EHEOrder *)[valueArray objectAtIndex:[indexPath row]];
    bookingDetailViewController.order=order;
    [self.navigationController pushViewController:bookingDetailViewController animated:YES];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //给组起名字，如果该组下没有数据，则名字加上空，反之则显示订单分组名字
    NSArray * allKeys= [self.orderDictionary allKeys];
    NSString * key=[allKeys objectAtIndex:section];
    NSArray * valueArray= [self.orderDictionary objectForKey:key];
    if(valueArray.count==0)
    {
        return [NSString stringWithFormat:@"%@(订单为空)",key];
    }
    else
    {
    return [self.orderDictionary.allKeys objectAtIndex:section];
    }
}
@end
