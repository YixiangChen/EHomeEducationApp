//
//  EHEStdSearchingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/30/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "Defines.h"
#import "EHEStdSearchingViewController.h"
#import "EHETeacher.h"
#import "EHECommunicationManager.h"
#import "EHECoreDataManager.h"
#import "EHETchDetailViewController.h"
#import "EHETeacherTableViewCell.h"
#import "EHEStdLoginViewController.h"

#import "FPPopoverView.h"
#import "FPPopoverController.h"
#import "FPTouchView.h"

#import "MJRefresh.h"

@interface EHEStdSearchingViewController ()

@end

@implementation EHEStdSearchingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapSearching = [[EHEStdMapSearchingViewController alloc] initWithNibName:nil bundle:nil];
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:[[NSArray alloc]initWithObjects:@"列表",@"地图",nil]];
    
    self.segmentedControl.frame = CGRectMake(80.0, 20.0,160.0, 30.0);
    self.segmentedControl.tintColor = kGreenForTabbaritem;
    self.segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:kYueYuanFont size:17],NSFontAttributeName,kGreenForTabbaritem, NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [self.segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.allTeachersNearby = [[NSMutableArray alloc] initWithArray:[[EHECoreDataManager getInstance] fetchBasicInfosOfTeachers]];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if(screenWidth==320&&screenHeight==480)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 85, 320,335) style:UITableViewStylePlain];
        self.filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 65, 375, 20)];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 85, 320,423) style:UITableViewStylePlain];
        self.filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 65, 375, 20)];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 85, 375, 667-135) style:UITableViewStylePlain];
        self.filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 65, 375, 20)];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 85, 414, 667-105) style:UITableViewStylePlain];
        self.filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 65, 375, 20)];
    }
    
    [self.tableView addSubview:self.filterView];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self setupFilterView];
    
    [self.view addSubview:self.filterView];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //[self.tableView headerBeginRefreshing];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults * userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * userName=[userDefaults objectForKey:@"userName"];
    NSString * password=[userDefaults objectForKey:@"passWord"];
    if(userName==nil||password==nil)
    {
        EHEStdLoginViewController * loginViewController=[[EHEStdLoginViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:loginViewController animated:NO completion:nil];
    }else {
        
    }
}
-(void) headerRefreshing {
    bool refreshSuccess;
    refreshSuccess = [[EHECommunicationManager getInstance] loadTeachersInfo];
    [self.allTeachersNearby removeAllObjects];
    self.allTeachersNearby = [[NSMutableArray alloc] initWithArray:[[EHECoreDataManager getInstance] fetchBasicInfosOfTeachers]];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    if (refreshSuccess) {
        NSLog(@"更新成功");
    }else {
        NSLog(@"更新失败");
    }
    
}

-(void) setupFilterView {
    
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    UIButton *filterDistanceBtn;
    UIButton *filterGenderBtn;
    UIButton *filterSubjectBtn;
    UIButton *filterAgeBtn;
    UIButton *filterDegreeBtn;
    UIButton *filterRankBtn;
    if(screenWidth==320&&screenHeight==480)
    {
        filterDistanceBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 20)];
        filterGenderBtn= [[UIButton alloc] initWithFrame:CGRectMake(53, 0, 52, 20)];
        filterSubjectBtn= [[UIButton alloc] initWithFrame:CGRectMake(106, 0, 52, 20)];
        filterAgeBtn= [[UIButton alloc] initWithFrame:CGRectMake(159, 0, 52, 20)];
        filterDegreeBtn= [[UIButton alloc] initWithFrame:CGRectMake(212, 0, 52, 20)];
        filterRankBtn= [[UIButton alloc] initWithFrame:CGRectMake(265, 0, 52, 20)];
    }
    else if(screenWidth==320&&screenHeight==568)
    {
        filterDistanceBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 20)];
        filterGenderBtn= [[UIButton alloc] initWithFrame:CGRectMake(53, 0, 52, 20)];
        filterSubjectBtn= [[UIButton alloc] initWithFrame:CGRectMake(106, 0, 52, 20)];
        filterAgeBtn= [[UIButton alloc] initWithFrame:CGRectMake(159, 0, 52, 20)];
        filterDegreeBtn= [[UIButton alloc] initWithFrame:CGRectMake(212, 0, 52, 20)];
        filterRankBtn= [[UIButton alloc] initWithFrame:CGRectMake(265, 0, 52, 20)];
    }
    else if(screenWidth==375&&screenHeight==667)
    {
        filterDistanceBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 61, 20)];
        filterGenderBtn= [[UIButton alloc] initWithFrame:CGRectMake(62, 0, 61, 20)];
        filterSubjectBtn= [[UIButton alloc] initWithFrame:CGRectMake(124, 0, 61, 20)];
        filterAgeBtn= [[UIButton alloc] initWithFrame:CGRectMake(186, 0, 61, 20)];
        filterDegreeBtn= [[UIButton alloc] initWithFrame:CGRectMake(248, 0, 61, 20)];
        filterRankBtn= [[UIButton alloc] initWithFrame:CGRectMake(310, 0, 63, 20)];
    }
    else if(screenWidth==414&&screenHeight==736)
    {
        filterDistanceBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 69, 20)];
        filterGenderBtn= [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 69, 20)];
        filterSubjectBtn= [[UIButton alloc] initWithFrame:CGRectMake(140, 0, 69, 20)];
        filterAgeBtn= [[UIButton alloc] initWithFrame:CGRectMake(210, 0, 69, 20)];
        filterDegreeBtn= [[UIButton alloc] initWithFrame:CGRectMake(280, 0, 69, 20)];
        filterRankBtn= [[UIButton alloc] initWithFrame:CGRectMake(350, 0, 69, 20)];
    }
    
    [filterDistanceBtn setTitle:@"距离" forState:UIControlStateNormal];
    [filterDistanceBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterDistanceBtn setBackgroundColor:kLightGreenForMainColor];
    [filterDistanceBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterDistanceBtn setTag:0];
    
    
    [filterGenderBtn setTitle:@"性别" forState:UIControlStateNormal];
    [filterGenderBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterGenderBtn setBackgroundColor:kLightGreenForMainColor];
    [filterGenderBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterGenderBtn setTag:1];
    
    
    [filterSubjectBtn setTitle:@"科目" forState:UIControlStateNormal];
    [filterSubjectBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterSubjectBtn setBackgroundColor:kLightGreenForMainColor];
    [filterSubjectBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterSubjectBtn setTag:2];
    
    
    [filterAgeBtn setTitle:@"年龄" forState:UIControlStateNormal];
    [filterAgeBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterAgeBtn setBackgroundColor:kLightGreenForMainColor];
    [filterAgeBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterAgeBtn setTag:3];
    
    
    [filterDegreeBtn setTitle:@"学历" forState:UIControlStateNormal];
    [filterDegreeBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterDegreeBtn setBackgroundColor:kLightGreenForMainColor];
    [filterDegreeBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterDegreeBtn setTag:4];
    
    
    [filterRankBtn setTitle:@"评价" forState:UIControlStateNormal];
    [filterRankBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterRankBtn setBackgroundColor:kLightGreenForMainColor];
    [filterRankBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterRankBtn setTag:5];
    
    //self.filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 255, 20)];
    [self.filterView addSubview:filterDistanceBtn];
    [self.filterView addSubview:filterGenderBtn];
    [self.filterView addSubview:filterSubjectBtn];
    [self.filterView addSubview:filterAgeBtn];
    [self.filterView addSubview:filterDegreeBtn];
    [self.filterView addSubview:filterRankBtn];
    
}

-(void) popFilterView:(id) sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == 0) {
        if (self.filterByDistanceController == nil) {
            self.filterByDistanceController= [[EHEStdFilterByDistanceViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByDistanceController];
        popover.contentSize = CGSizeMake(180, 95);
        self.filterByDistanceController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    if (btn.tag == 1) {
        if (self.filterByGenderController == nil) {
            self.filterByGenderController= [[EHEStdFilterByGenderViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByGenderController];
        popover.contentSize = CGSizeMake(200, 200);
        self.filterByGenderController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    if (btn.tag == 2) {
        if (self.filterBySubjectsController == nil) {
            self.filterBySubjectsController= [[EHEStdFilterBySubjectsViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterBySubjectsController];
        popover.contentSize = CGSizeMake(260, 350);
        self.filterBySubjectsController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    if (btn.tag == 3) {
        if (self.filterByAgeController == nil) {
            self.filterByAgeController= [[EHEStdFilterByAgeViewController alloc] initWithNibName:nil bundle:nil];
        }
        FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:self.filterByAgeController];
        popover.contentSize = CGSizeMake(230, 100);
        self.filterByAgeController.popController = popover;
        [popover presentPopoverFromView:btn];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) viewWillAppear:(BOOL)animated {
    //    [super viewWillAppear:animated];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    if ([defaults objectForKey:@"userName"] == nil || [defaults objectForKey:@"passWord"] == nil) {
    //    EHEStdLoginViewController *loginViewController = [[EHEStdLoginViewController alloc] initWithNibName:nil bundle:nil];
    //    [self presentViewController:loginViewController animated:NO completion:nil];
    //    }
//}


-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)
    {
        self.mapSearching.mapView=nil;//在父视图中删除地图的时候，要给百度地图赋值为nil以免内存泄露
        [self.mapSearching.view removeFromSuperview];
        self.tableView.scrollEnabled=YES;
    }
    else
    {
        self.tableView.scrollEnabled=NO;
        self.mapSearching.searchingViewController=self;
        [self.view addSubview: self.mapSearching.view];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.allTeachersNearby.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"Cell";
    EHETeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = (EHETeacherTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"EHETeacherTableViewCell" owner:self options:nil][0];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    EHETeacher * teacher = [self.allTeachersNearby objectAtIndex:indexPath.row];
    [cell setContent:teacher];
    
    cell.teacherImage.image = nil;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageName = [NSString stringWithFormat:@"image_for_teacher_%d",[teacher.teacherId intValue]];
    NSData *data = [defaults objectForKey:imageName];
    UIImage * imageForTeacher = [[UIImage alloc] initWithData:data];
    
    if (imageForTeacher == nil)
    {
        
        if ([teacher.gender isEqualToString:@"男"]) {
            imageForTeacher = [UIImage imageNamed:@"male_tablecell"];
        }else {
            imageForTeacher = [UIImage imageNamed:@"female_tablecell"];
        }
        
        
        cell.teacherImage.image = imageForTeacher;
        [[EHECommunicationManager getInstance] loadTeacherIconForTeacher:teacher completionBlock:^(NSString * status)  {
            if ([status isEqualToString:kConnectionSuccess])
            {
                NSData * image_data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"image_for_teacher_%d",teacher.teacherId.intValue]];
                UIImage *image = [[UIImage alloc] initWithData:image_data];
                cell.teacherImage.image = image;
            }
        }];
        
    }
    else {
        cell.teacherImage.image = imageForTeacher;
    }
    
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    EHETchDetailViewController *detailViewController = [[EHETchDetailViewController alloc] initWithNibName:nil bundle:nil];
    EHETeacher * teacher = [self.allTeachersNearby objectAtIndex:indexPath.row];
    
    detailViewController.teacher = teacher;
    
    NSDictionary *dictForLoaction = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitudeAndLongitude"] ;
    detailViewController.distance = [EHEStdSearchingViewController calculateDistanceFromOriginLatitude:[[dictForLoaction objectForKey:@"latitude"] floatValue] andOriginLong:[[dictForLoaction objectForKey:@"longitude"] floatValue] ToDestinationLatitude:teacher.latitude.floatValue andDesLong:teacher.longitude.floatValue];
    // Pass the selected object to the new view controller.
    
    // Push the view controller.


    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

+ (NSString *)calculateDistanceFromOriginLatitude:(float)originLat andOriginLong:(float)originLong ToDestinationLatitude:(float)desLat andDesLong:(float)desLong {
    CLLocation * origin = [[CLLocation alloc] initWithLatitude:originLat longitude:originLong];
    CLLocation * destination = [[CLLocation alloc] initWithLatitude:desLat longitude:desLong];
    
    CLLocationDistance distance = [origin distanceFromLocation:destination] / 1000;
    return [NSString stringWithFormat:@"%.02f km", distance];
}



@end
