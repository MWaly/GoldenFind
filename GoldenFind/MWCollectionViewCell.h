//
//  GFCell.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.

//  This class represents the implemntation of GFCell used in populating the GFCollectionView and its factory interface

@import UIKit;
@import QuartzCore;
@class MWCollectionViewCellWithImage;
@class MWCollectionViewCellWithMap;

/**
 *  Image type property , Initiating a new cell should specify its type from here
 
 @CUSTOM : Empty Cell
 @MAPCELL : Return cells with ready made subviews for Mapview and two labels
 @IMAGECELL :Return cells with ready made subviews for Imageview and two labels
 */


typedef enum  {
	CUSTOM = 1,
	MAPCELL = 2,
	IMAGECELL = 3
}ImageType;


@interface MWCollectionViewCell : UIView <UIGestureRecognizerDelegate>


///Title Label , which contains the main text to be displayed (E.g. Company name)
@property (nonatomic, readwrite) UILabel *titleLabel;
///Detail Label , which contains the detail text to be displayed
@property (nonatomic, readwrite) UILabel *detailLabel;

/// Reuse identfier which will be used by the table to reproduce a cell again
@property (nonatomic, readwrite) NSString *reuseIdentifier;


/// Cell Type if needed to be checked
@property (nonatomic, readonly, assign) ImageType cellType;

/// Cell height to support dynamic and variable heights
@property (nonatomic, readonly, assign) NSInteger cellHeight;

/// The row position acts as the same as Apple's impletation of IndexPath
@property (nonatomic, readonly, assign) NSUInteger rowPosition;

/// The dictionary of Attributes where keys and values will be passed to it to display them
@property (nonatomic, readwrite) NSDictionary *attributes;


@property (nonatomic, weak) id <UIGestureRecognizerDelegate> gestureRecgonizerDelegate;




/**
 *  This is the initilization method for MWCollectionViewCell which returns a child cell according to the cell type provided
 *
 *  @param reuseIdentifier String which is needed to tag the cell for re-usage purposes
 *  @param cellType        the cell type passed which might be Empty , Map or Image
 *
 *  @return object instance
 *
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType;



@end
