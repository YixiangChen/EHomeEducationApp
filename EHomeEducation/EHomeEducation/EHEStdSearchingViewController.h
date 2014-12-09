//
//  EHEStdSearchingViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/30/14.
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

@interface EHEStdSearchingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic)UISegmentedControl * segmentedControl;
@property(strong, nonatomic) EHEStdMapSearchingViewController *mapSearching;
@property(strong, nonatomic) NSMutableArray *allTeachersNearby;
@property(strong, nonatomic) EHEStdFilterByGenderViewController *filterByGenderController;
@property(strong, nonatomic) EHEStdFilterByDistanceViewController *filterByDistanceController;
@property(strong, nonatomic) EHEStdFilterByAgeViewController *filterByAgeController;
@property(strong, nonatomic) EHEStdFilterBySubjectsViewController *filterBySubjectsController;

+(NSString *) calculateDistanceFromOriginLatitude:(float) originLat andOriginLong:(float) originLong ToDestinationLatitude:(float)desLat andDesLong:(float) desLong;

@end
