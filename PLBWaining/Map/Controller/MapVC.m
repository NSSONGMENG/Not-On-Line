//
//  MapVC.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "MapVC.h"

@interface MapVC ()<MKMapViewDelegate>

@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self layoutMKMapView];
}

-(void)layoutMKMapView{
    MKMapView * mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.delegate = self;
    
    mapView.mapType = MKMapTypeStandard;                    //使用标准地图风格
    mapView.zoomEnabled = YES;                              //地图可缩放
    mapView.scrollEnabled = YES;                            //地图可滚动
    
    CLLocationCoordinate2D center = {39.5426,116.2329};     //设置地图中心经纬度
    MKCoordinateSpan span;                                  //设置地图显示的范围
    span.latitudeDelta = 0.01;                              //设置中心点偏移量
    span.longitudeDelta = 0.01;
    
    MKCoordinateRegion regon = {center,span};               //设置地图的显示中心和范围
    
    [mapView setRegion:regon];                              //设置当前地图的显示中心和范围
    
    [self.view addSubview:mapView];
}
#pragma Mark -----------代理方法------------


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
