//
//  MWTableViewDelegate.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.

/**
 *  The protocol which recieves actions invoked on the table view , there is a need to implement this protocol if selection , reordering or deletion is of the requirements
 */


@import Foundation;

@protocol MWTableViewDelegate <NSObject>
@required
- (void)didSelectCellWithPosition:(NSInteger)rowPosition;
- (void)didMoveCellWithPosition:(NSInteger)rowPosition;
- (void)didDeleteCellWithPosition:(NSInteger)rowPosition;

@optional
// For Dragging Detection
- (void)didStartMovingCellWithPosition:(NSInteger)rowPosition;

@end
