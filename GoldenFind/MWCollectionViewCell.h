//
//  GFCell.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.

//  This class represents the implemntation of GFCell used in populating the GFCollectionView and its factory interface

@import UIKit;
@class MWCollectionViewCellWithImage;
@class MWCollectionViewCellWithMap;

/**
 *  Image type property
 */
typedef enum  {
	CUSTOM = 1,
	MAPCELL = 2,
	IMAGECELL = 3
}ImageType;


@interface MWCollectionViewCell : UIView


@property (nonatomic, readwrite) UILabel* titleLabel;
@property (nonatomic, readwrite) UILabel* detailLabel;
@property (nonatomic, readwrite) NSString* reuseIdentifier;
@property (nonatomic, readonly , assign ) ImageType cellType;
@property (nonatomic, readonly , assign ) NSInteger cellHeight;
@property (nonatomic, readwrite) NSDictionary* attributes;



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType ;

- (void) prepareForReuse;

@end
