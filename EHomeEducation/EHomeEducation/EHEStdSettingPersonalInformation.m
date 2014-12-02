//
//  EHEStdSettingPersonalInformation.m
//  EHomeEducation
//
//  Created by MacBook Pro on 14-11-27.
//  Copyright (c) 2014年 AppChen. All rights reserved.
//

#import "EHEStdSettingPersonalInformation.h"
#import "EHEStdSettingTableViewCell.h"
#import "EHEStdSettingDetailViewController.h"
#import "EHECoreDataManager.h"
#import "EHECommunicationManager.h"
#import "EHEStdLoginViewController.h"
#import "AFHTTPRequestOperation.h"

@interface EHEStdSettingPersonalInformation ()

@end

@implementation EHEStdSettingPersonalInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * sendButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(sendInfomation)];
    self.navigationItem.rightBarButtonItem=sendButtonItem;
    self.image=nil;
    
    NSUserDefaults * userDefault=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefault objectForKey:@"myCustomerid"];

    NSString * keyString=[self getKey:@"name" andPara:customerid];
    NSLog(@"keyString=%@",keyString);
    self.name=[userDefault objectForKey:[self getKey:@"name" andPara:customerid]];
    self.gender=[userDefault objectForKey:[self getKey:@"gender" andPara:customerid]];
    self.telephoneNumber=[userDefault objectForKey:[self getKey:@"telephone" andPara:customerid]];
    self.brithday=[userDefault objectForKey:[self getKey:@"memo" andPara:customerid]];
    NSData * imageData =[userDefault objectForKey:[self getKey:@"image" andPara:customerid]];
    UIImage * myImage=[UIImage imageWithData:imageData];
    self.image=myImage;
    
}
-(void)sendInfomation
{
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];

    NSDictionary * latitudeAndLongitude= [userDefaults objectForKey:@"latitudeAndLongitude"];
    NSString * latitude=[latitudeAndLongitude objectForKey:@"latitude"];
    NSString * longitude=[latitudeAndLongitude objectForKey:@"longitude"];
    EHECommunicationManager * communicationManager=[EHECommunicationManager getInstance];
    NSLog(@"name=%@",self.telephoneNumber);
    
    NSDictionary * informationDictionary=@{@"customerid":[userDefaults objectForKey:@"myCustomerid"],@"name":self.name,@"gender":self.gender,@"telephone":self.telephoneNumber,@"latitude":latitude,@"longitude":longitude,@"majoraddress":@"北京石景山",@"memo":self.brithday};

    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    [communicationManager sendOtherInfo:informationDictionary];
    
    [self uploadUserIconWithCustomerId:customerid.intValue andImage:self.image];
    
    [userDefaults setObject:self.name forKey:[self getKey:@"name" andPara:customerid]];
    [userDefaults setObject:self.telephoneNumber forKey:[self getKey:@"telephone" andPara:customerid]];
    [userDefaults setObject:self.gender forKey:[self getKey:@"gender" andPara:customerid]];
    [userDefaults setObject:@"北京石景山" forKey:[self getKey:@"majoraddress" andPara:customerid]];
    [userDefaults setObject:self.brithday forKey:[self getKey:@"memo" andPara:customerid]];
    [userDefaults synchronize];
    
}

-(NSString*)getKey:(NSString *)para1 andPara:(NSString *)para2
{
    return [NSString stringWithFormat:@"%@%@",para1,para2];
}
-(void)viewWillAppear:(BOOL)animated
{
//    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
//    NSLog(@"customerid=%@",[userDefaults objectForKey:@"myCustomerid"]);
//    
//    NSData * imageData =[userDefaults objectForKey:[self getKey:@"image" andPara:[userDefaults objectForKey:@"myCustomerid"]]];
//    UIImage * myImage=[UIImage imageWithData:imageData];
    //self.image=myImage;
    if(self.image==nil)
    {
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        NSLog(@"customerid=%@",[userDefaults objectForKey:@"myCustomerid"]);
        NSData * imageData =[userDefaults objectForKey:[self getKey:@"image" andPara:[userDefaults objectForKey:@"myCustomerid"]]];
            UIImage * myImage=[UIImage imageWithData:imageData];
        self.image=myImage;
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)uploadUserIconWithCustomerId:(int)customerId andImage:(UIImage *)myImage {
    
    
    NSString * path = @"http://developer.bjbkws.com:8080/ehomeedu/api/customer/usericonupload.action";
    NSLog(@"%@",path);
    AFHTTPRequestSerializer * serializer = [[AFHTTPRequestSerializer alloc]init];
    NSMutableURLRequest * request = [serializer multipartFormRequestWithMethod:@"POST" URLString:path parameters:@{@"customerid":@(customerId)} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(self.image) name:@"usericon" fileName:@"png-0001.jpg" mimeType:@"image/png"];
        
    } error:nil];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //上传成功，
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        self.imageData=nil;;
        if (UIImagePNGRepresentation(self.image) == nil) {
            
            self.imageData = UIImageJPEGRepresentation(self.image, 1);
            
        } else {
            
            self.imageData = UIImagePNGRepresentation(self.image);;
        }
        NSUserDefaults * userdefaults=[NSUserDefaults standardUserDefaults];
        NSString * customerid=[userdefaults objectForKey:@"myCustomerid"];
        [userdefaults setObject:self.imageData forKey:[self getKey:@"image" andPara:customerid]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //上传失败，
        NSLog(@"%@",error);
        
    }];
    [operation start];//开始上传
    
}
#pragma mark - TableView DataSouce Method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 6;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHEStdSettingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger row = [indexPath row];
    if(row==0)
    {
        cell.nameLabel.alpha=0.0f;
        cell.settingImageView.alpha=1.0f;
        cell.iconLabel.text=@"头像";
        cell.imageIcon.image=self.image;
        cell.imageIcon.layer.cornerRadius=26.0f;
        cell.imageIcon.clipsToBounds=YES;
    }
    else if(row==1)
    {
        cell.settingLabel.text=@"姓名";
        cell.contentLabel.text=self.name;
    }
    else if(row==2)
    {
        cell.settingLabel.text=@"电话号码:";
        cell.contentLabel.text=self.telephoneNumber;
    }
    else if(row==3)
    {
        cell.settingLabel.text=@"性别:";
        cell.contentLabel.text=self.gender;
        cell.contentLabel.tag=1;
    }
    else if(row==4)
    {
        cell.settingLabel.text=@"地址:";
        cell.contentLabel.text=@"北京石景山";
    }
    else
    {
        cell.settingLabel.text=@"日期:";
        cell.contentLabel.text=self.brithday;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark - TableView Delegate Method
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
            return 70.0f;
        }
    }
    return 44.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    EHEStdSettingDetailViewController * settingDetail=[[EHEStdSettingDetailViewController alloc]init];
    NSInteger row=[indexPath row];
    if(row==0)
    {
        settingDetail.type=@"0";
        settingDetail.image=self.image;
    }
    else if(row==1)
    {
        settingDetail.type=@"1";
        settingDetail.name=self.name;
    }
    else if(row==2)
    {
        settingDetail.type=@"3";
        settingDetail.telephoneNumber=@"18500813409";
        
    }
    else if(row==3)
    {
        settingDetail.type=@"2";
    }
    else if(row==4)
    {
        return;
    }
    else
    {
        settingDetail.type=@"4";
        settingDetail.birthDate=@"2000-01-01";
    }
    settingDetail.personInfomation=self;
    UITextField * textField=(UITextField *)[self.tableView viewWithTag:1];
    if([textField.text isEqualToString:@"男"])
    {
        settingDetail.currentIndexPath=0;
    }
    else if([textField.text isEqualToString:@"女"])
    {
        settingDetail.currentIndexPath=1;
    }
    [self.navigationController pushViewController:settingDetail animated:YES];
}
@end
