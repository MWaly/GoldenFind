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
	return wordsCount;
}

+ (UIButton *)getDeleteButton {
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	deleteButton.backgroundColor = [UIColor redColor];
	[deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
	[deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	deleteButton.tag = 1;
    
	return deleteButton;
}

@end
