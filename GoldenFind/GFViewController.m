//
//  GFViewController.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFViewController.h"
#import "MWCollectionView.h"
#import "GFInteractor.h"


@interface GFViewController ()

@end

@implementation GFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Get the data and parese it first
    
    MWCollectionView *collectionView=[[MWCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
