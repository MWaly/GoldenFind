//
//  GFRowData.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


/*
 This is the parent class for places objects  and holds the common properties and debugging 
 This is the data model which holds data parsed from the JSON feed and then passed to be processed by a view object
 */
typedef enum  {
	EMPTY = 1,
	MAP = 2,
	IMAGE = 3
}PlaceType;
@import Foundation;

@interface GFPlace : NSObject

@property (nonatomic , readwrite) NSString* titleText;
@property (nonatomic , readwrite) NSString* detailText;

@property (nonatomic , readonly) PlaceType type;


/// Initiliazers
+ (instancetype)createPlace;
+ (instancetype)createPlaceWithImage:(UIImage*)image;
+ (instancetype)createPlaceWithLatitude:(NSNumber*)lat andLongtiude:(NSNumber*)lon;


@end
