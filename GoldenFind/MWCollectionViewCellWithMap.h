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

/**
 *  Property of Mapview holding the map to be displayed by the cell
 */
@property (nonatomic, readwrite) MKMapView *map;

/**
 *  The designated initliazer
 *
 *  @param reuseIdentifier String which is needed to tag the cell for re-usage purposes
 *
 *  @return object instance of MWCollecitonViewCell
 *
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
