//
//  EHEStdSearchingTableViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EHECoreDataManager.h"
#import "EHEStdMapSearchingViewController.h"
#import "EHEStdFilterByGenderViewController.h"
#import "EHEStdFilterByDistanceViewController.h"
#import "EHEStdFilterByAgeViewController.h"
#import "EHEStdFilterBySubjectsViewController.h"

@interface EHEStdSearchingTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>
@property(strong, nonatomic) EHECoreDataManager *coreDataManager;
@property(strong, nonatomic) NSFetchedResultsController *fetchedResultController;
@property(strong,nonatomic)UISegmentedControl * segmentedControl;
@property(strong, nonatomic) EHEStdMapSearchingViewController *mapSearching;
@property(strong, nonatomic) NSArray *allTeachersNearby;
@property(strong, nonatomic) EHEStdFilterByGenderViewController *filterByGenderController;
@property(strong, nonatomic) EHEStdFilterByDistanceViewController *filterByDistanceController;
@property(strong, nonatomic) EHEStdFilterByAgeViewController *filterByAgeController;
@property(strong, nonatomic) EHEStdFilterBySubjectsViewController *filterBySubjectsController;

@end
