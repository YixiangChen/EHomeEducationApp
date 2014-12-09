//
//  EHEStdOrderViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//
#import "Defines.h"
#import "EHEStdOrderViewController.h"
#import "EHEStdSubjectTableTableViewController.h"
#import "EHECommunicationManager.h"
#import "EHEStdSubjectTableTableViewController.h"
#import "EHEStdLocationViewController.h"
#import "EHEStdMemoViewController.h"


@interface EHEStdOrderViewController ()
@property (strong, nonatomic) NSMutableDictionary *dictOrder;

@property (strong, nonatomic) NSArray *arrayForSection1;
@property (strong, nonatomic) NSMutableArray *dataArrayForSection1;

@property (strong, nonatomic) NSArray *arrayForSection2;
@property (strong, nonatomic) NSMutableArray *dataArrayForSection2;

@property (strong, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) UILabel *titleLabel;


@end

@implementation EHEStdOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSDictionary *dict = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    
    //for section 1
    NSArray *array1 = @[dict, dict,dict];
    self.dataArrayForSection1 = [[NSMutableArray alloc] initWithArray:array1];
    self.arrayForSection1 = @[@"辅导对象",@"辅导科目",@"辅导地点"];
    
    //for section 2
    NSArray *array2 = @[dict,dict,dict];
    self.dataArrayForSection2 = [[NSMutableArray alloc] initWithArray:array2];
    self.arrayForSection2 = @[@"日期",@"开始时间",@"结束时间"];
    

    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sendOrder)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.dictOrder = [[NSMutableDictionary alloc] init];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    self.tableView.sectionFooterHeight = 0.0;
    self.tableView.backgroundColor = [UIColor clearColor];
}

-(void)viewWillAppear:(BOOL)animated {
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


-(void) sendOrder {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [self.dictOrder setObject:[formatter stringFromDate:[NSDate date]]forKey:@"orderdate"];
    
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * customerid=[userDefaults objectForKey:@"myCustomerid"];
    NSLog(@"customerid=%@",customerid);
    if([customerid isEqualToString:@""])
    {
        UIAlertView * alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
        
    }
    
    NSUserDefaults * userDefault=[NSUserDefaults standardUserDefaults];
    NSDictionary * latitudeAndLongitude= [userDefault objectForKey:@"latitudeAndLongitude"];
    NSString * latitude=[latitudeAndLongitude objectForKey:@"latitude"];
    NSString * longitude=[latitudeAndLongitude objectForKey:@"longitude"];
    
    [self.dictOrder setObject:customerid forKey:@"customerid"];
    [self.dictOrder setObject:latitude forKey:@"latitude"];
    [self.dictOrder setObject:longitude forKey:@"longitude"];
    [self.dictOrder setObject:self.teacher.teacherId forKey:@"teacherid"];    
    [self.dictOrder setObject:@(0) forKey:@"orderstatus"];
    [self.dictOrder setObject:self.selectedLocation forKey:@"serviceaddress"];
    [self.dictOrder setObject:self.selectedObject forKey:@"objectinfo"];
    [self.dictOrder setObject:self.selectedSubjects forKey:@"subjectinfo"];
    [self.dictOrder setObject:self.selectedMemo forKey:@"memo"];
    [self.dictOrder setObject:[NSString stringWithFormat:@"%@-%@",self.selectedStartTime,self.selectedEndTime] forKey:@"timeperiod"];
    
    bool sendSuccess = [[EHECommunicationManager getInstance] sendOrder:self.dictOrder];
    if (sendSuccess) {
        [self presentSendingStatus];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArrayForSection1.count;
    } else if(section == 1){
        return self.dataArrayForSection2.count;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if(indexPath.section == 0) {
        if([[self.dataArrayForSection1[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
            return 162;
        }
    }
    
    if(indexPath.section == 1) {
        if([[self.dataArrayForSection2[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
            return 162;
        }
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *textLabel  = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 80, 30)];
    textLabel.font =[UIFont fontWithName:kYueYuanFont size:18];
    textLabel.tag = 1;
    
    UILabel *detailTextLabel  = [[UILabel alloc] initWithFrame:CGRectMake(160, 8, 120, 30)];
    detailTextLabel.font =[UIFont fontWithName:kYueYuanFont size:15];
    detailTextLabel.textColor = [UIColor lightGrayColor];
    detailTextLabel.textAlignment = NSTextAlignmentRight;
    detailTextLabel.tag = 2;

    if (indexPath.section == 0) {
        
        if ([[self.dataArrayForSection1[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
            static NSString *mainCellID = @"Cell";
            UITableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
            if (mainCell == nil) {
                mainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mainCellID];
            }
            mainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if ([[self.dataArrayForSection1[0] objectForKey:@"isAttached"] boolValue]) {
                if (indexPath.row == 0) {
                    textLabel.text = @"辅导对象";
                }
                if (indexPath.row == 2) {
                    textLabel.text = @"辅导科目";
                    detailTextLabel.text = self.selectedSubjects;
                }
                if (indexPath.row == 3) {
                    textLabel.text = @"辅导地点";
                    detailTextLabel.text = self.selectedLocation;
                }
            }else {
                textLabel.text = [self.arrayForSection1 objectAtIndex:indexPath.row];
                UILabel *label = (UILabel *)[mainCell viewWithTag:1 ];
                [label removeFromSuperview];
                [mainCell.contentView addSubview:textLabel];
                if (indexPath.row == 0) {
                    detailTextLabel.text = self.selectedObject;
                }
                if (indexPath.row == 1) {
                    detailTextLabel.text = self.selectedSubjects;
                }
                if (indexPath.row == 2) {
                    detailTextLabel.text = self.selectedLocation;
            }
            
        }

            UILabel *label = (UILabel *)[mainCell viewWithTag:1 ];
            [label removeFromSuperview];
            [mainCell.contentView addSubview:textLabel];
            
            UILabel *detailLabel = (UILabel *) [mainCell viewWithTag:2];
            [detailLabel removeFromSuperview];
            [mainCell.contentView addSubview:detailTextLabel];
            return mainCell;
        }else if ([[self.dataArrayForSection1[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]) {
            
            static NSString *attachedCellID = @"AttachedCell";
            
            EHEStdOrderTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
            if (attachedCell == nil) {
            attachedCell = (EHEStdOrderTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdOrderTableViewCell" owner:self options:nil][0];
            }
            
            self.cellForObject = attachedCell;
            return attachedCell;
        }

        
    }
    
    if (indexPath.section == 1) {
        
        if ([[self.dataArrayForSection2[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
            static NSString *mainCellID = @"Cell";
            UITableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
            if (mainCell == nil) {
                mainCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mainCellID];
            }
            if (self.dataArrayForSection2.count == 3) {
                textLabel.text = [self.arrayForSection2 objectAtIndex:indexPath.row];
                if (indexPath.row == 0) {
                    detailTextLabel.text = self.selectedDate;
                }
                if (indexPath.row == 1) {
                    textLabel.text = @"开始时间";
                    detailTextLabel.text = self.selectedStartTime;
                }
                if (indexPath.row == 2) {
                    textLabel.text = @"结束时间";
                    detailTextLabel.text = self.selectedEndTime;
                }
            }
            if (self.dataArrayForSection2.count == 4) {
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] ) {
                    if (indexPath.row == 0) {
                        textLabel.text = @"日期";
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[1] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        textLabel.text = @"日期";
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
                
                if ([[self.dataArrayForSection2[2] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        textLabel.text = @"日期";
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 2) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
            }
            if (self.dataArrayForSection2.count == 5) {
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[2] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 4) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[3] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[1] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[3] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        textLabel.text = @"开始时间";
                        detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        textLabel.text = @"结束时间";
                        detailTextLabel.text = self.selectedEndTime;
                    }
                }
            }
            
            if (self.dataArrayForSection2.count == 6) {
                if (indexPath.row == 0) {
                    detailTextLabel.text = self.selectedDate;
                }
                if (indexPath.row == 2) {
                    textLabel.text = @"开始时间";
                    detailTextLabel.text = self.selectedStartTime;
                }
                if (indexPath.row == 4) {
                    textLabel.text = @"结束时间";
                    detailTextLabel.text = self.selectedEndTime;
                }
            }
            UILabel *label = (UILabel *)[mainCell viewWithTag:1 ];
            [label removeFromSuperview];
            [mainCell.contentView addSubview:textLabel];
            
            UILabel *detailLabel = (UILabel *) [mainCell viewWithTag:2];
            [detailLabel removeFromSuperview];
            [mainCell.contentView addSubview:detailTextLabel];
            
            mainCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return mainCell;
        } else if ([[self.dataArrayForSection2[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]) {
            
            if (self.dataArrayForSection2.count == 4) {
                if (indexPath.row == 2) {
                    static NSString *attachedCellID = @"AttachedCell";
                    EHEStdTimePickerTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
                    if (attachedCell == nil) {
                        attachedCell = (EHEStdTimePickerTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdTimePickerTableViewCell" owner:self options:nil][0];
                    }
                    self.cellForStartTimePicker = attachedCell;
                    return attachedCell;
                }
                if(indexPath.row == 3){
                    static NSString *attachedCellID = @"AttachedCell";
                    EHEStdTimePickerTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
                    if (attachedCell == nil) {
                        attachedCell = (EHEStdTimePickerTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdTimePickerTableViewCell" owner:self options:nil][0];
                    }
                    self.cellForEndTimePicker = attachedCell;
                    return attachedCell;
                }
            }
            
            if (self.dataArrayForSection2.count > 4) {
                if (indexPath.row == 3 ||indexPath.row == 2) {
                    static NSString *attachedCellID = @"AttachedCell";
                    EHEStdTimePickerTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
                    if (attachedCell == nil) {
                        attachedCell = (EHEStdTimePickerTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdTimePickerTableViewCell" owner:self options:nil][0];
                    }
                    self.cellForStartTimePicker = attachedCell;
                    return attachedCell;
                }
                if (indexPath.row == 4 ||indexPath.row == 5){
                        static NSString *attachedCellID = @"AttachedCell";
                        EHEStdTimePickerTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
                        if (attachedCell == nil) {
                            attachedCell = (EHEStdTimePickerTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdTimePickerTableViewCell" owner:self options:nil][0];
                        }
                        self.cellForEndTimePicker = attachedCell;
                        return attachedCell;

                }
            }
            static NSString *attachedCellID = @"AttachedCell";
            EHEStdDatePickerTableViewCell *attachedCell = [tableView dequeueReusableCellWithIdentifier:attachedCellID];
            if (attachedCell == nil) {
                attachedCell = (EHEStdDatePickerTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHEStdDatePickerTableViewCell" owner:self options:nil][0];
            }
            
            self.cellForDatePicker = attachedCell;
            return attachedCell;
        }
    }
    if (indexPath.section == 2) {
        static NSString *cellID = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        textLabel.text = @"备注";
        detailTextLabel.text = self.selectedMemo;
        
        UILabel *label = (UILabel *)[cell viewWithTag:1 ];
        [label removeFromSuperview];
        [cell.contentView addSubview:textLabel];
        
        UILabel *detailLabel = (UILabel *) [cell viewWithTag:2];
        [detailLabel removeFromSuperview];
        [cell.contentView addSubview:detailTextLabel];
        return cell;
        }
    
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *path = nil;
    
    if (indexPath.section == 0) {
     
        if (indexPath.row == 0) {
            if ([[self.dataArrayForSection1[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
                path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
            }else{
                path = indexPath;
            }
            
            if ([[self.dataArrayForSection1[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
                // 关闭附加cell
                
                self.selectedObject = self.cellForObject.selectedObject;
                NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
                self.dataArrayForSection1[(path.row-1)] = dic;
                [self.dataArrayForSection1 removeObjectAtIndex:path.row];
                [self.tableView reloadData];
                
            }else{
                NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(YES)};
                self.dataArrayForSection1[(path.row-1)] = dic;
                NSDictionary * addDic = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
                [self.dataArrayForSection1 insertObject:addDic atIndex:path.row];
                
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
                [self.tableView endUpdates];
                
            }
        }
        
        if (([[self.dataArrayForSection1[0] objectForKey:@"isAttached"] boolValue] &&indexPath.row == 2)||(![[self.dataArrayForSection1[0] objectForKey:@"isAttached"] boolValue] &&indexPath.row == 1)) {

                EHEStdSubjectTableTableViewController *subjectViewController = [[EHEStdSubjectTableTableViewController alloc] initWithNibName:nil bundle:nil];
            
                subjectViewController.orderTable = self;
                [self.navigationController pushViewController:subjectViewController animated:YES];
        }
        
        if (([[self.dataArrayForSection1[0] objectForKey:@"isAttached"] boolValue] &&indexPath.row == 3)||(![[self.dataArrayForSection1[0] objectForKey:@"isAttached"] boolValue] &&indexPath.row == 2)) {
            
            EHEStdLocationViewController *locationViewController = [[EHEStdLocationViewController alloc] initWithNibName:nil bundle:nil];
            locationViewController.orderTable = self;
            [self.navigationController pushViewController:locationViewController animated:YES];
        }

    }
    
    if (indexPath.section == 1) {
        
        if ([[self.dataArrayForSection2[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
            path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
        }else{
            path = indexPath;
        }
        
        if ([[self.dataArrayForSection2[indexPath.row] objectForKey:@"isAttached"] boolValue]) {
            // 关闭附加cell
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyy-MM-dd"];
            self.selectedDate = [formatter stringFromDate:self.cellForDatePicker.datePicker.date] ;

            NSDateFormatter *formatter_time = [[NSDateFormatter alloc] init];
            [formatter_time setDateFormat:@"HH:mm"];
            self.selectedStartTime = [formatter_time stringFromDate:self.cellForStartTimePicker.timePicker.date];
            self.selectedEndTime = [formatter_time stringFromDate:self.cellForEndTimePicker.timePicker.date];
            
            NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
            self.dataArrayForSection2[(path.row-1)] = dic;
            [self.dataArrayForSection2 removeObjectAtIndex:path.row];
            [self.tableView reloadData];
            
        }else{
            NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(YES)};
            self.dataArrayForSection2[(path.row-1)] = dic;
            NSDictionary * addDic = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
            [self.dataArrayForSection2 insertObject:addDic atIndex:path.row];
            
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
            [self.tableView endUpdates];
            
        }

    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            EHEStdMemoViewController *memoViewController = [[EHEStdMemoViewController alloc] initWithNibName:nil bundle:nil];
            
            memoViewController.orderTable = self;
            [self.navigationController pushViewController:memoViewController animated:YES];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [view setBackgroundColor:kLightGreenForMainColor];
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
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

-(void) presentSendingStatus {
    UIView * blackView=[[UIView alloc]init];
    blackView.center=self.view.center;
    blackView.backgroundColor=[UIColor blackColor];
    blackView.alpha=0.0f;
    blackView.frame=CGRectMake(120,180, 80, 80);
    blackView.layer.cornerRadius=20.0f;
    [self.view addSubview:blackView];
    
    UILabel * label1=[[UILabel alloc]initWithFrame:CGRectMake(11, 25, 130, 30)];
    label1.textColor=[UIColor whiteColor];
    label1.backgroundColor=[UIColor clearColor];
    label1.text=@"发送成功";
    label1.font=[UIFont fontWithName:kFangZhengKaTongFont size:15.0f];
    [blackView addSubview:label1];
    
    [UIView animateWithDuration:1.0 animations:^{
        blackView.alpha=0.8f;
    }];
    [UIView animateWithDuration:2.5 animations:^{
        blackView.alpha=0.0f;
    }];
}



@end
