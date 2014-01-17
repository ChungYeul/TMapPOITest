//
//  ViewController.m
//  TMapPOITest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#define TOOLBAR_HEIGHT 64
@interface ViewController ()<UISearchBarDelegate, TMapViewDelegate>
@property (strong, nonatomic) TMapView *mapView;
@end

@implementation ViewController
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.mapView clearCustomObjects];
    
    NSString *keyword = searchBar.text;
    TMapPathData *path = [[TMapPathData alloc] init];
    NSArray *result = [path requestFindTitlePOI:keyword];
    NSLog(@"Number of POI : %d", result.count);
    
    int i = 0;
    for (TMapPOIItem *item in result) {
        NSLog(@"Name : %@ - Point : %@", [item getPOIName], [item getPOIPoint]);
        
        NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc] init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"red_pin.png"]];
        
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [self.mapView addCustomObject:marker ID:markerID];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    CGRect rect = CGRectMake(0, TOOLBAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HEIGHT);
    self.mapView = [[TMapView alloc] initWithFrame:rect];
    [self.mapView setSKPMapApiKey:@"82add192-7843-36bc-b1fd-175e2c70faad"];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
