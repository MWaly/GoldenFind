//
//  GFPlaceViewModel.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFPlaceViewModel.h"

@implementation GFPlaceViewModel


// Supporting Variable Cell Height
+ (NSInteger)getHeightForNumberOfWords:(NSInteger)wordsCount {
	if (wordsCount < 80) {
		return 60;
	}
	else
		return 120;
}

@end
