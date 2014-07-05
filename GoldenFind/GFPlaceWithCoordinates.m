//
//  GFPlaceWithCoordinates.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlaceWithCoordinates.h"


@interface GFPlaceWithCoordinates ()
// Private setter
@property (nonatomic, readwrite) NSNumber *lon;
@property (nonatomic, readwrite) NSNumber *lat;
@property (nonatomic, readwrite) NSString *titleText;
@property (nonatomic, readwrite) NSString *detailText;
@property (nonatomic, readwrite) PlaceType type;

@end

@implementation GFPlaceWithCoordinates



@dynamic titleText;
@dynamic detailText;
@dynamic type;

+ (instancetype)createPlaceWithDictionary:(NSDictionary *)dict {
	return [[GFPlaceWithCoordinates alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		self.titleText = dict[@"company"];
		self.detailText = dict[@"detail"];
		self.lon = dict[@"lan"];
		self.lat = dict[@"lat"];
		self.type = MAP;
	}
	return self;
}

@end
