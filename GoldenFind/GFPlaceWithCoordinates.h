//
//  GFPlaceWithCoordinates.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

@import UIKit;
#import "GFPlace.h"

@interface GFPlaceWithCoordinates : GFPlace

@property (nonatomic,readwrite)NSNumber *lon;
@property (nonatomic,readwrite)NSNumber *lat;

@end
