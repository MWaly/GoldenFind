//
//  GFInteractor.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


/*
 This class acts as the business engine for the application by parsing the JSON data and converting them to usable app data
 */

@import Foundation;
@class GFPlace;


@interface GFInteractor : NSObject

// returns an array full of places from file
+ (NSArray *)loadPlacesOffline;




@end
