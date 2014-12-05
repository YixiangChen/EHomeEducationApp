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
#import "EHETeacherDetailViewController.h"
#import "EHETeacherTableViewCell.h"
#import "EHEStdLoginViewController.h"

#import "FPPopoverView.h"
#import "FPPopoverController.h"
#import "FPTouchView.h"

#import "Defines.h"

#import "EHEStdFilterByGenderViewController.h"

@interface EHEStdSearchingViewController ()

@end

@implementation EHEStdSearchingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[EHECommunicationManager getInstance]loadTeachersInfo];
    
    self.mapSearching = [[EHEStdMapSearchingViewController alloc] initWithNibName:nil bundle:nil];
    
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:[[NSArray alloc]initWithObjects:@"列表",@"地图",nil]];
    self.segmentedControl.frame = CGRectMake(40.0, 20.0,240.0, 30.0);
    self.segmentedControl.tintColor = [UIColor colorWithRed:192.0 / 256.0 green:233 / 256.0 blue:189 / 256.0 alpha:0.8];
    self.segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName, nil];
    [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    [self.segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentChanged:)forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    
    self.coreDataManager = [EHECoreDataManager getInstance];
    self.allTeachersNearby = [[NSArray alloc] initWithArray:[self.coreDataManager fetchBasicInfosOfTeachers]];
    for (EHETeacher * teacher in self.allTeachersNearby) {
        [[EHECommunicationManager getInstance] loadDataWithTeacherID:[teacher.teacherId intValue]];
    }
    
    
    
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"EHETeacher"];
    NSSortDescriptor * sd1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[sd1];
    self.fetchedResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:self.coreDataManager.context sectionNameKeyPath:@"name" cacheName:@"Teacher"];
    self.fetchedResultController.delegate = self;
    [NSFetchedResultsController deleteCacheWithName:nil];
    [self.fetchedResultController performFetch:nil];
    
    [self setupFilterView];
}

-(void) setupFilterView {
    UIButton *filterDistanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 20)];
    [filterDistanceBtn setTitle:@"距离" forState:UIControlStateNormal];
    [filterDistanceBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterDistanceBtn setBackgroundColor:kLightGreenForMainColor];
    [filterDistanceBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterDistanceBtn setTag:0];
    
    UIButton *filterGenderBtn = [[UIButton alloc] initWithFrame:CGRectMake(53, 0, 52, 20)];
    [filterGenderBtn setTitle:@"性别" forState:UIControlStateNormal];
    [filterGenderBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterGenderBtn setBackgroundColor:kLightGreenForMainColor];
    [filterGenderBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterGenderBtn setTag:1];
    
    UIButton *filterSubjectBtn = [[UIButton alloc] initWithFrame:CGRectMake(106, 0, 52, 20)];
    [filterSubjectBtn setTitle:@"科目" forState:UIControlStateNormal];
    [filterSubjectBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterSubjectBtn setBackgroundColor:kLightGreenForMainColor];
    [filterSubjectBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterSubjectBtn setTag:2];
    
    UIButton *filterAgeBtn = [[UIButton alloc] initWithFrame:CGRectMake(159, 0, 52, 20)];
    [filterAgeBtn setTitle:@"年龄" forState:UIControlStateNormal];
    [filterAgeBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterAgeBtn setBackgroundColor:kLightGreenForMainColor];
    [filterAgeBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterAgeBtn setTag:3];
    
    UIButton *filterDegreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(212, 0, 52, 20)];
    [filterDegreeBtn setTitle:@"学历" forState:UIControlStateNormal];
    [filterDegreeBtn.titleLabel setFont:[UIFont fontWithName:@"MF YueYuan (Noncommercial)" size:15.0]];
    [filterDegreeBtn setBackgroundColor:kLightGreenForMainColor];
    [filterDegreeBtn addTarget:self action:@selector(popFilterView:) forControlEvents:UIControlEventTouchUpInside];
    [filterDegreeBtn setTag:4];
    
    UIButton *filterRankBtn = [[UIButton alloc] initWithFrame:CGRectMake(265, 0, 52, 20)];
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
    NSLog(@"Tapping filter");
    
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

-(void) viewWillAppear:(BOOL)animated {
    //    [super viewWillAppear:animated];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    if ([defaults objectForKey:@"userName"] == nil || [defaults objectForKey:@"passWord"] == nil) {
    //    EHEStdLoginViewController *loginViewController = [[EHEStdLoginViewController alloc] initWithNibName:nil bundle:nil];
    //    [self presentViewController:loginViewController animated:NO completion:nil];
    //    }
}


-(void) selectedSegmentChanged:(UISegmentedControl *) seg {
    if(seg.selectedSegmentIndex==0)
    {
        self.mapSearching.mapView=nil;//在父视图中删除地图的时候，要给百度地图赋值为nil以免内存泄露
        [self.mapSearching.view removeFromSuperview];
        self.tableView.scrollEnabled=YES;
    }
    else
    {
        NSLog(@"这是地图");
        self.tableView.scrollEnabled=NO;
        self.mapSearching.searchingViewController=self;
        [self.view addSubview: self.mapSearching.view];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.fetchedResultController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> sectionInfo = self.fetchedResultController.sections[section];
    return [sectionInfo numberOfObjects];
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
    EHETeacher * teacher = [self.fetchedResultController objectAtIndexPath:indexPath];
    [cell setContent:teacher];
    
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
    EHETeacherDetailViewController *detailViewController = [[EHETeacherDetailViewController alloc] initWithNibName:nil bundle:nil];
    EHETeacher * teacher = [self.fetchedResultController objectAtIndexPath:indexPath];
    EHETeacher * teacherWithDetailInfos = [[EHECoreDataManager getInstance] fetchDetailInfosWithTeacherId:[teacher.teacherId intValue]];
    
    detailViewController.teacher = teacherWithDetailInfos;
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [leftBarButtonItem setTitle:@"返回列表"];
    [leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    [leftBarButtonItem setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor greenColor]}  forState:UIControlStateNormal];
    self.navigationItem.backBarButtonItem = leftBarButtonItem;
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

#pragma mark - NSFetchedResultsControllerDelegate协议方法
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            //刷新一下所在的section
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] //一旦使用了section，这里需要使用indexPath，如果不使用，section分区（1）,这里需要使用newIndexPath
                             withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
