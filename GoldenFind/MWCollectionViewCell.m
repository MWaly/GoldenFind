//
//  GFCell.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWCollectionViewCell.h"
#import "MWCollectionViewCellWithImage.h"
#import "MWCollectionViewCellWithMap.h"

@implementation MWCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType
{
    if (cellType==IMAGECELL) {
        return [[MWCollectionViewCellWithImage alloc]initWithReuseIdentifier:reuseIdentifier ];
        
    }
    else
    {
        return [[MWCollectionViewCellWithMap alloc]initWithReuseIdentifier:reuseIdentifier ];
    }
}


/*
 The description Methods for Debugging Purposes/Users/macbookpro/Desktop/Apps/GoldenFind/GoldenFind/MWCollectionViewCell.m
 */

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ type %li \">",
            [self class], self, _titleLabel.text ,(long)_cellType];
}
- (void) prepareForReuse{}
@end
