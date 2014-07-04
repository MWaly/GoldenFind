//
//  GFCellWithImage.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWCollectionViewCell.h"

@interface MWCollectionViewCellWithImage : MWCollectionViewCell

@property(nonatomic ,readwrite) UIImageView *cellImage;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
