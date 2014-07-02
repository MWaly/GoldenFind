//
//  GFRowData.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlace.h"

@implementation GFPlace


+ (instancetype)createPlaceWithtitleText:(NSString*)title detailText:(NSString*)detailText
{
    return [self initWithTitle:(NSString*)];
}
+ (instancetype)createPlaceWithImage:(UIImage*)image titleText:(NSString*)title detailText:(NSString*)detailText
{

}
+ (instancetype)createPlaceWithLatitude:(NSNumber*)lat andLongtiude:(NSNumber*)lon titleText:(NSString*)title detailText:(NSString*)detailText
{


}

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ type %li \">",
            [self class], self, _titleText ,(long)PlaceType];
}
@end
