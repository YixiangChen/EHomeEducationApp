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
@interface EHEStdMapSearchingViewController : UIViewController<BMKLocationServiceDelegate,BMKMapViewDelegate>
@property(strong,nonatomic)CLLocationManager * locationManager;
@property(strong,nonatomic)BMKLocationService * locationService;
@property(nonatomic)CLLocationCoordinate2D userLocation;
@property(strong,nonatomic)UIView * backgroundView;
@property(strong,nonatomic)BMKMapView * mapView;
@property(strong,nonatomic)NSArray * segmentedData;
@property(strong,nonatomic)UISegmentedControl segmentedControl;
@end
