//
//  GFCell.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWCollectionViewCell.h"

@implementation MWCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


/*
The description Methods for Debugging Purposes
*/

- (NSString*)description {
    return [NSString stringWithFormat:@"<%@: %p, \"%@ type %li \">",
            [self class], self, _titleLabel.text ,(long)_cellType];
}
@end
