//
//  GFPlace.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


/*
 This is the parent class for places objects  and holds the common properties and debugging 
 This is the data model which holds data parsed from the JSON feed and then passed to be processed by a view object
 */
@import Foundation;



typedef enum  {
	EMPTY = 1,
	MAP = 2,
	IMAGE = 3
}PlaceType;


@interface GFPlace : NSObject

@property (nonatomic , readonly) NSString* titleText;
@property (nonatomic , readonly) NSString* detailText;
@property (nonatomic , readonly ) PlaceType type;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end
