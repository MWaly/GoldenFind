//
//  GFCollectionViewController.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//



#import "MWCollectionView.h"


@interface MWCollectionView ()

@property(nonatomic) NSMutableArray *rowRecords;
@property(nonatomic) NSMutableSet *reusePool;
@property(nonatomic) NSMutableIndexSet *visibleRows;

- (void)setup;

- (void)layoutTableRows;

@end
@implementation MWCollectionView

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

@end
