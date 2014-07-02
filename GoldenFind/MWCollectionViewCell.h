//
//  GFCell.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.

//  This class represents the implemntation of GFCell used in populating the GFCollectionView and its factory interface

#import <UIKit/UIKit.h>

/**
 *  Image type property
 */
typedef enum  {
	CUSTOM = 1,
	MAPCELL = 2,
	IMAGECELL = 3
}ImageType;


@interface MWCollectionViewCell : UIView


@property (nonatomic, readwrite)UILabel* titleLabel;
@property (nonatomic, readwrite)UILabel* detailLabel;
@property (nonatomic, readwrite)NSString* cellIdentfier;
@property (nonatomic, readonly , assign ) NSInteger cellType;
@property (nonatomic, readonly , assign ) NSInteger cellHeight;


+ (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType;

@end
