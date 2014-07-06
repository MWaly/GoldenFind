//
//  GFPlaceViewModel.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


//  This class holds  the logic for view objects here

@import Foundation;
@interface GFPlaceViewModel : NSObject


/**
 *  This method returns the height according to the number of chracters , allowing dynamic height drawing for cells
 *
 *  @param wordsCount characters count
 *
 *  @return integer with the height calculated
 */
+ (NSInteger)getHeightForNumberOfWords:(NSInteger)wordsCount;


/**
 *  This method will return an object of a button tp be used in deletion , located in this class
 *
 *  @return Delete button obejct instance
 */
+ (UIButton *)getDeleteButton;

@end
