//
//  GFCellWithImage.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.

/**
 *  This a subclass for MWCollectionViewCell which is designed for cell requiring image reprentation
 *
 */

#import "MWCollectionViewCell.h"

@interface MWCollectionViewCellWithImage : MWCollectionViewCell

/**
 *  Property of image view holding the image displayed by the cell
 */
@property (nonatomic) UIImageView *cellImage;


/**
 *  The designated initliazer
 *
 *  @param reuseIdentifier String which is needed to tag the cell for re-usage purposes
 *
 *  @return object instance of MWCollecitonViewCell
 *
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
