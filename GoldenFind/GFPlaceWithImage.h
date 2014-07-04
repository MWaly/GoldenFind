//
//  GFPlaceWithImage.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/3/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlace.h"

@interface GFPlaceWithImage : GFPlace

+ (instancetype)createPlaceWithDictionary:(NSDictionary*)dict;
@property (nonatomic,readonly)UIImage* placeImage;

@end
