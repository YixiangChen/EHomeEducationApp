//
//  EHEStdOrderViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/21/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

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


@end

@implementation EHEStdOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预约信息";
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


}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void) sendOrder {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [self.dictOrder setObject:[formatter stringFromDate:[NSDate date]]forKey:@"orderdate"];
    
    [self.dictOrder setObject:@(143) forKey:@"customerid"];
    [self.dictOrder setObject:@(119.000000) forKey:@"latitude"];
    [self.dictOrder setObject:@(39.000000) forKey:@"longitude"];
    [self.dictOrder setObject:self.teacher.teacherId forKey:@"teacherid"];    
    [self.dictOrder setObject:@(0) forKey:@"orderstatus"];
    [self.dictOrder setObject:self.selectedLocation forKey:@"serviceaddress"];
    [self.dictOrder setObject:self.selectedObject forKey:@"objectinfo"];
    [self.dictOrder setObject:self.selectedSubjects forKey:@"subjectinfo"];
    [self.dictOrder setObject:self.selectedMemo forKey:@"memo"];
    [self.dictOrder setObject:[NSString stringWithFormat:@"%@-%@",self.selectedStartTime,self.selectedEndTime] forKey:@"timeperiod"];
    
    [[EHECommunicationManager getInstance] sendOrder:self.dictOrder];
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
                    mainCell.textLabel.text = @"辅导对象";
                    mainCell.detailTextLabel.text = self.selectedObject;
                }
                if (indexPath.row == 2) {
                    mainCell.textLabel.text = @"辅导科目";
                    mainCell.detailTextLabel.text = self.selectedSubjects;
                }
                if (indexPath.row == 3) {
                    mainCell.textLabel.text = @"辅导地点";
                    mainCell.detailTextLabel.text = self.selectedLocation;
                }
            }else {
            mainCell.textLabel.text = [self.arrayForSection1 objectAtIndex:indexPath.row];
                if (indexPath.row == 0) {
                    mainCell.detailTextLabel.text = self.selectedObject;
                }
                if (indexPath.row == 1) {
                    mainCell.detailTextLabel.text = self.selectedSubjects;
                }
                if (indexPath.row == 2) {
                    mainCell.detailTextLabel.text = self.selectedLocation;
            }
            
        }
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
                mainCell.textLabel.text = [self.arrayForSection2 objectAtIndex:indexPath.row];
                if (indexPath.row == 0) {
                    mainCell.detailTextLabel.text = self.selectedDate;
                }
                if (indexPath.row == 1) {
                    mainCell.textLabel.text = @"开始时间";
                    mainCell.detailTextLabel.text = self.selectedStartTime;
                }
                if (indexPath.row == 2) {
                    mainCell.textLabel.text = @"结束时间";
                    mainCell.detailTextLabel.text = self.selectedEndTime;
                }
            }
            if (self.dataArrayForSection2.count == 4) {
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] ) {
                    if (indexPath.row == 0) {
                        mainCell.textLabel.text = @"日期";
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[1] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        mainCell.textLabel.text = @"日期";
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
                
                if ([[self.dataArrayForSection2[2] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        mainCell.textLabel.text = @"日期";
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 2) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
            }
            if (self.dataArrayForSection2.count == 5) {
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[2] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 4) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[0] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[3] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 2) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
                if ([[self.dataArrayForSection2[1] objectForKey:@"isAttached"] boolValue] && [[self.dataArrayForSection2[3] objectForKey:@"isAttached"] boolValue]) {
                    if (indexPath.row == 0) {
                        mainCell.detailTextLabel.text = self.selectedDate;
                    }
                    if (indexPath.row == 1) {
                        mainCell.textLabel.text = @"开始时间";
                        mainCell.detailTextLabel.text = self.selectedStartTime;
                    }
                    if (indexPath.row == 3) {
                        mainCell.textLabel.text = @"结束时间";
                        mainCell.detailTextLabel.text = self.selectedEndTime;
                    }
                }
            }
            
            if (self.dataArrayForSection2.count == 6) {
                if (indexPath.row == 0) {
                    mainCell.detailTextLabel.text = self.selectedDate;
                }
                if (indexPath.row == 2) {
                    mainCell.textLabel.text = @"开始时间";
                    mainCell.detailTextLabel.text = self.selectedStartTime;
                }
                if (indexPath.row == 4) {
                    mainCell.textLabel.text = @"结束时间";
                    mainCell.detailTextLabel.text = self.selectedEndTime;
                }
            }
            
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
        cell.textLabel.text = @"备注";
        cell.detailTextLabel.text = self.selectedMemo;
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
    [view setBackgroundColor:[UIColor greenColor]];
    return view;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
