//
//  EHEStdMapSearchingViewController.m
//  EHomeEducation
//
//  Created by Yixiang Chen on 11/17/14.
//  Copyright (c) 2014 AppChen. All rights reserved.
//

#import "EHEStdMapSearchingViewController.h"

@interface EHEStdMapSearchingViewController ()

@end

@implementation EHEStdMapSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([UIScreen mainScreen].bounds.size.width==320&&[UIScreen mainScreen].bounds.size.height==480)
    {
        self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        self.backgroundView.backgroundColor=[UIColor colorWithRed:150/255.0f green:205/255.0f blue:251/255.0f alpha:1.0f];
        [self.view addSubview:self.backgroundView];
        
        self.segmentedData= [[NSArray alloc]initWithObjects:@"列表",@"地图",nil];
        self.segmentedControl = [[UISegmentedControl alloc]initWithItems:self.segmentedData];
        self.segmentedControl.frame = CGRectMake(40.0, 20.0,240.0, 30.0);
        /*
         这个是设置按下按钮时的颜色
         */
        self.segmentedControl.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
        self.segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
        
        
        /*
         下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
         */
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName, nil];
        
        
        [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
        
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        
        [self.segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
        
        //设置分段控件点击相应事件
        [self.segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
        
        [self.backgroundView insertSubview:self.segmentedControl atIndex:0];
        
        
        self.mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-110)];
        self.mapView.delegate=self;
        self.locationManager=[[CLLocationManager alloc]init];
        [self.locationManager requestWhenInUseAuthorization];
        self.mapView.showsUserLocation=YES;
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        //启动LocationService
        [_locationService startUserLocationService];
        [self.view addSubview:self.mapView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
   if(Seg.selectedSegmentIndex==0)
   {
       NSLog(@"这是地图");
   }
   else
   {
       NSLog(@"这是列表");
   }
}
#pragma mark - LocationService Delegate Method
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    
}
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if(userLocation!=nil)
    {
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = userLocation.location.coordinate.latitude;
    coor.longitude = userLocation.location.coordinate.longitude;
    annotation.coordinate = coor;
    annotation.title = @"当前位置";
    [_mapView addAnnotation:annotation];
    [self.mapView setRegion:BMKCoordinateRegionMake(coor, BMKCoordinateSpanMake(0.05, 0.05)) animated:YES];
    self.mapView.zoomEnabled=YES;
    
    [self.locationService stopUserLocationService];
    }
    else
    {
        NSLog(@"。。。。");
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    self.mapView=nil;
}
@end
