//
//  GFPlaceWithImage.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/3/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlaceWithImage.h"


@interface GFPlaceWithImage ()
// Private setter
@property (nonatomic,readwrite)UIImage *placeImage;
@property (nonatomic , readwrite) NSString* titleText;
@property (nonatomic , readwrite) NSString* detailText;
@property (nonatomic , readwrite ) PlaceType type;

@end

@implementation GFPlaceWithImage

@dynamic  titleText;
@dynamic detailText;
@dynamic type;

+ (instancetype)createPlaceWithDictionary:(NSDictionary*)dict
{
    return [[GFPlaceWithImage alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.titleText=dict[@"company"];
        self.detailText=dict[@"detail"];
        NSString *imageFilePath=[[NSBundle mainBundle] pathForResource:dict[@"image"] ofType:@"png"];
        self.placeImage=[UIImage imageWithContentsOfFile:imageFilePath];
        self.type=IMAGE;

    }
    return self;
}
@end
