//
//  EHEStdMapSearchingViewController.h
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "BMKMapView.h"
#import <CoreData/CoreData.h>
#import "EHECoreDataManager.h"
#import "EHEBaiduMapView.h"
@interface EHEStdMapSearchingViewController : UIViewController<BMKLocationServiceDelegate,BMKMapViewDelegate>
@property(strong,nonatomic)CLLocationManager * locationManager;
@property(strong,nonatomic)BMKLocationService * locationService;
@property(nonatomic)CLLocationCoordinate2D userLocation;
@property(strong,nonatomic)BMKMapView * mapView;
@property(strong,nonatomic)NSArray * teacherInfoArray;
@property(strong,nonatomic)EHEBaiduMapView * mapViewPop;
@property(strong,nonatomic)NSMutableDictionary * bubbleDictionary;

@property(nonatomic)int count;
@end
