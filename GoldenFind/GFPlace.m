//
//  GFPlace.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlace.h"

#import "GFPlaceWithCoordinates.h"
#import "GFPlaceWithImage.h"



@interface GFPlace ()

@property (nonatomic, readwrite) NSString *titleText;
@property (nonatomic, readwrite) NSString *detailText;
@property (nonatomic, readwrite) PlaceType type;

@end

@implementation GFPlace


- (instancetype)initWithDictionary:(NSDictionary *)dict {
	if (![dict[@"image"] isKindOfClass:[NSNull class]]) {
		return [GFPlaceWithImage createPlaceWithDictionary:dict];
	}
	else
		return [GFPlaceWithCoordinates createPlaceWithDictionary:dict];
}

/*
 + (instancetype)createPlaceWithtitleText:(NSString*)title detailText:(NSString*)detailText
 {
 return nil;
 }
 + (instancetype)createPlaceWithImage:(UIImage*)image titleText:(NSString*)title detailText:(NSString*)detailText
 {
 
 }
 + (instancetype)createPlaceWithLatitude:(NSNumber*)lat andLongtiude:(NSNumber*)lon titleText:(NSString*)title detailText:(NSString*)detailText
 {
 
 
 }
 */
- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p, \"%@ type %li \">",
	        [self class], self, _titleText, (long)_type];
}

@end
