//
//  MWTableViewDataSource.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


/**
 *  The protocol which provides MWTableView with necessary info to build up its cells
 */

@import Foundation;

@class MWTableView;
@class MWTableViewCell;

@protocol MWTableViewDataSource <NSObject>
@required
/**
 *  This method provides number of rows in the tableview
 *
 *  @return integer carrying the rows count
 */
- (NSInteger)numberOfRows;

/**
 *  Acts the same like the cellForRowAtIndexPath of Apple's implemntation , however designed for one row only
 *
 *  @param tableView   the table view to build the cells in
 *  @param rowPosition the cell to return at this specific row position
 *
 *  @return the returned cell
 */
- (MWTableViewCell *)tableView:(MWTableView *)tableView cellAtPosition:(NSInteger)rowPosition;

/**
 *  Returns the height for a cell at the specified position , can have a default value or customizable as in the demo example
 *
 *  @param rowPosition position of the cell in the array
 *
 *  @return the cell height
 */
- (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition;


@end
