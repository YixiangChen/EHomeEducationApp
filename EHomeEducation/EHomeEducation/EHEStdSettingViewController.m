//
//  EHEStdSettingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdSettingViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "EHEStdSettingPersonalInformation.h"
#import "EHEStdLoginViewController.h"
#import "EHEStdLoginViewController.h"
#import "UIImageView+AFNetworking.h"
#import "EHECommunicationManager.h"
#import "EHEStdEveluationViewController.h"
#import "Reachability.h"
#import "Defines.h"
@interface EHEStdSettingViewController ()

@end

@implementation EHEStdSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.check=NO;
    //    UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.title=@"设置";
    self.detailType=[[NSString alloc]init];
    self.tableViewSetting=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+10) style:UITableViewStyleGrouped];
    self.tableViewSetting.dataSource=self;
    self.tableViewSetting.delegate=self;
    self.tableViewSetting.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableViewSetting];
    
    self.personalInfomationArray=[NSArray arrayWithObjects:@"头像",@"评论",nil];
    self.imageData=[[NSMutableData alloc]initWithCapacity:10];
    self.systemSettingArray=[NSArray arrayWithObjects:@"系统设置",@"退出登录",nil];
    self.connectAndShareArray=[NSArray arrayWithObjects:@"分享",@"联系我们", nil];
    
    self.testArray=[[NSArray alloc]initWithObjects:@"",@"",@"男",@"18500813409",@"1989-11-24", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"xianshile");
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
    if([self checkIfNetWorking])
    {
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        self.userIconString=[userDefaults objectForKey:@"userIcons"];
        NSString * urlString=[NSString stringWithFormat:@"%@%@",kURLLoadUserIcon,self.userIconString];
        NSURL * url=[NSURL URLWithString:urlString];
        NSURLRequest * request=[NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    else
    {
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        NSData * imageData=[userDefaults objectForKey:[self getKey:@"image" andCustomerid:[userDefaults objectForKey:@"myCustomerid"]]];
        self.userImage=[UIImage imageWithData:imageData];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:@"ChangeLanguageNotificationName" object:nil];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.userImage=[[UIImage alloc]initWithData:self.imageData];
    [self.tableViewSetting reloadData];
}
-(void)changeLanguage:(NSNotification *)noti
{
    if([self checkIfNetWorking])
    {
        EHECommunicationManager * commucationManager=[EHECommunicationManager getInstance];
        self.userImage=[UIImage imageWithData:[commucationManager downloadUserIcon:self.userIconString]];
        NSLog(@"userImage=%@",self.userIconString);
    }
    else
    {
        NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
        NSData * imageData=[userDefaults objectForKey:[self getKey:@"image" andCustomerid:[userDefaults objectForKey:@"myCustomerid"]]];
        self.userImage=[UIImage imageWithData:imageData];
    }
    [self.tableViewSetting reloadData];
}

//判断有无网络
-(BOOL)checkIfNetWorking
{
    self.check=YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus])
    {
        case NotReachable:
            self.check  = NO;
            NSLog(@"没有网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"有网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"有网络");
            break;
    }
    return self.check;
}

#pragma mark- TableView DataSource Method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return [self.personalInfomationArray count];
    }
    else if(section==1)
    {
        return [self.systemSettingArray count];
    }
    else
    {
        return [self.connectAndShareArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Identifier=@"Identifier";
    EHEStdSettingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if(!cell)
    {
        cell=[[EHEStdSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    //第一个分组
    if(section==0)
    {
        if(row==0)//第一分组 第一行
        {
            //cell.settingLabel.text=[self.personalInfomationArray objectAtIndex:0];
            if(self.check==NO)//更改姓名 字段的高度，只改一次
            {
                CGRect frames=cell.settingLabel.frame;
                frames.size.height+=26;
                cell.settingLabel.frame=frames;
                self.check=YES;
                cell.contentLabel.alpha=0.0f;
            }
            cell.nameLabel.text=[userDefaults objectForKey:@"userName"];
            cell.settingImageView.image=self.userImage;
            
            [cell.settingImageView.layer setBorderColor: [[UIColor grayColor] CGColor]];//边框灰色
            [cell.settingImageView.layer setBorderWidth: 1.0];//宽度为1
            [cell.settingImageView.layer setCornerRadius:26.0f];//圆角
            [cell.settingImageView.layer setMasksToBounds:YES];
        }
        else
        {
            cell.settingLabel.text=[self.personalInfomationArray objectAtIndex:row];
            cell.nameLabel.alpha=0.0f;
        }
        cell.contentLabel.text=[self.testArray objectAtIndex:row];
    }
    else if(section==1)//第二个分组
    {
        cell.settingLabel.text=[self.systemSettingArray objectAtIndex:row];
        cell.nameLabel.alpha=0.0f;
        if([indexPath row]==1)
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    else//第三个分组
    {
        cell.settingLabel.text=[self.connectAndShareArray objectAtIndex:row];
        cell.nameLabel.alpha=0.0f;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(NSString *)getKey:(NSString *)para1 andCustomerid:(NSString *)para2
{
    return [NSString stringWithFormat:@"%@%@",para1,para2];
}
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
#pragma mark- TableView Delegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击之后灰色一闪而过，不留痕迹
    [self.tableViewSetting deselectRowAtIndexPath:indexPath animated:NO];
    
    //点击第一个分组的时候
    if([indexPath section]==0)
    {
        if([indexPath row]==0)
        {
        EHEStdSettingPersonalInformation * personInfomation=[[EHEStdSettingPersonalInformation alloc]init];
            NSLog(@"self.userImage=%@",self.userImage);
            personInfomation.image=self.userImage;
        [self.navigationController pushViewController:personInfomation animated:YES];
        }
        else if([indexPath row]==1)
        {
            EHEStdEveluationViewController * comment=[[EHEStdEveluationViewController alloc]initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:comment animated:YES];
        }
    }
    
    if([indexPath section]==1)
    {
      if([indexPath row]==1)
      {
          
          LXActionSheet * actionSheet = [[LXActionSheet alloc]initWithTitle:@"确定要退出E家教吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil];
          [actionSheet showInView:self.view];
      }
    }
    
    //点击第三个分组的时候
    if([indexPath section]==2)
    {
        if([indexPath row]==0)//点击第三个分组的第一行，即分享cell的时候
        {
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
            
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                               defaultContent:@"默认分享内容，没内容时显示"
                                                        image:[ShareSDK imageWithPath:imagePath]
                                                        title:@"ShareSDK"
                                                          url:@"http://www.sharesdk.cn"
                                                  description:@"这是一条测试信息"
                                                    mediaType:SSPublishContentMediaTypeNews];
            //创建分享信息后，分享成功与否的返回
            [ShareSDK showShareActionSheet:nil
                                 shareList:nil
                                   content:publishContent
                             statusBarTips:YES
                               authOptions:nil
                              shareOptions: nil
                                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                        if (state == SSResponseStateSuccess)
                                        {
                                            NSLog(@"分享成功");
                                        }
                                        else if (state == SSResponseStateFail)
                                        {
                                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                                        }
                                    }];
        }
    }
}
//对每个分组的说明和描述
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0)
    {
        return @"个人资料";
    }
    else  if(section==1)
    {
        return @"系统设置";
    }
    else
    {
        return @"联系我们";
    }
}
#pragma mark - LXActionSheetDelegate

- (void)didClickOnButtonIndex:(NSInteger *)buttonIndex
{
   if((int)buttonIndex==0)
   {
       NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
       [userDefaults removeObjectForKey:@"userName"];
       [userDefaults removeObjectForKey:@"passWord"];
       [userDefaults synchronize];
       
       EHEStdLoginViewController * loginViewController=[[EHEStdLoginViewController alloc]initWithNibName:nil bundle:nil];
       [[self navigationController] setNavigationBarHidden:YES animated:YES];//隐藏导航栏
       [self.navigationController pushViewController:loginViewController animated:NO];
   }
}
@end
