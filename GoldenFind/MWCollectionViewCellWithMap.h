//
//  MWCollectionViewCellWithMap.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/3/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

@import MapKit;
#import "MWCollectionViewCell.h"

@interface MWCollectionViewCellWithMap : MWCollectionViewCell


@property(nonatomic,readwrite) MKMapView *map;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier ;
@end
