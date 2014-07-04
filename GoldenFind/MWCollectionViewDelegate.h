//
//  GFCollectionViewDelegate.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//


@import Foundation;

@protocol MWCollectionViewDelegate <NSObject>
@required
- (void)didSelectCellWithPosition:(NSInteger)rowPosition;
- (void)didMoveCellWithPosition:(NSInteger)rowPosition;
- (void)didDeleteCellWithPosition:(NSInteger)rowPosition;

@optional
// For Dragging Detection
- (void)didStartMovingCellWithPosition:(NSInteger)rowPosition;

@end
