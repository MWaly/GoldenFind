//
//  GFCollectionViewDataSource.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

@import Foundation;
@class MWCollectionView;
@class MWCollectionViewCell;

@protocol MWCollectionViewDataSource <NSObject>
@required
- (NSInteger)numberOfRows;
- (MWCollectionViewCell *)tableView:(MWCollectionView *)tableView cellAtPosition:(NSInteger)rowPosition;
@optional
- (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition;


@end
