//
//  GFCollectionViewController.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


//  This file represents the implemntation for header 

@import UIKit;
#import "MWCollectionViewDataSource.h"
#import "MWCollectionViewDelegate.h"
@class MWCollectionViewCell;

@interface MWCollectionView : UIScrollView

@property(nonatomic, weak) id<MWCollectionViewDelegate> collectionViewDelegate;
@property(nonatomic, weak) id<MWCollectionViewDataSource> dataSource;

- (MWCollectionViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

- (void)reloadData;


@end
