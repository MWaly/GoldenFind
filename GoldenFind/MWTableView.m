//
//  MWTableView.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

/**
 *  The class responsible for drawing the table view components , it is worth to say that re-usage pattern is followed by the tutorial published from Mike-Ash
 *
 */

#import "MWTableView.h"
#import "MWTableViewCell.h"

#define RANGES_INTERSECT(location1, length1, location2, length2) ((location1 + length1 >= location2) && (location2 + length2 >= location1))
@interface MWTableView ()

//Data which will be displayed by the table
@property (nonatomic) NSArray *tableData;

// Cells currently visible
@property (nonatomic) NSMutableArray *visibleCells;

// The first visible cell offset
@property (nonatomic) NSUInteger visibleCellsGlobalIndexOffset;

//
@property (nonatomic) NSMutableSet *reusePool;

// The totalHeight
@property (nonatomic, assign) CGFloat totalHeight;

//Array Holding Different Row Heights
@property (nonatomic)  NSMutableArray *rowHeights;


@property (nonatomic, assign) BOOL isFullScreenOn;
/**
 *  Method to calculate the heights for rows , normally needed for the scroll view to calculate its content size
 *
 *  @return array of row heights
 */
- (NSArray *)captureTableStructure;

/**
 *  Method laying out the table after scrolling
 *
 *  @param yOffset starting offset
 *  @param height  height covered to display the table view
 */
- (void)layoutTableForYOffset:(CGFloat)yOffset height:(CGFloat)height;

/**
 *  Insertion of a free cell to the queue for re-usage purposes
 *
 *  @param cell            Cell to be inserted
 *  @param reuseIdentifier String to identify the Cell
 */
- (void)enqueueReusableCell:(MWTableViewCell *)cell withIdentifier:(NSString *)reuseIdentifier;

@end
@implementation MWTableView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.visibleCells  = [@[] mutableCopy];
		self.reusePool    = [NSMutableSet set];
		self.rowHeights = [@[] mutableCopy];
        
        
        
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDeleteCellWithPosition:) name:MWDidDeleteACell object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectCellWithPosition:) name:MWDidSelectACell object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDismiss:) name:MWDidCancelCellSelection object:nil];
	}
	return self;
}

- (MWTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier {
	__block MWTableViewCell *poolCell = nil;
    
	[self.reusePool enumerateObjectsUsingBlock: ^(MWTableViewCell *cell, BOOL *stop) {
	    if ([cell.reuseIdentifier isEqualToString:reuseIdentifier]) {
	        poolCell = cell;
	        *stop = YES;
		}
	}
     
     ];
    
	if (poolCell) {
		[self.reusePool removeObject:poolCell];
	}
    
	return poolCell;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
	if (self.tableData == nil)
		[self reloadData];
    
	[self layoutTableForYOffset:CGRectGetMinY(self.bounds) height:CGRectGetHeight(self.bounds)];
}

- (void)reloadData {
	self.tableData = [self captureTableStructure];
    
	self.contentSize = CGSizeMake(self.bounds.size.width, self.totalHeight);
}

#pragma mark - Private Methods -

- (void)enqueueReusableCell:(MWTableViewCell *)cell withIdentifier:(NSString *)reuseIdentifier {
	cell.reuseIdentifier = reuseIdentifier;
	/*
     if ([cell isKindOfClass:[MWTableViewCellWithImage class]]) {
     cell.im
     }
	 */
	[self.reusePool addObject:cell];
}

- (NSArray *)captureTableStructure {
	self.totalHeight = 0.f;
	[self.rowHeights removeAllObjects];
    
	// Rows
	NSInteger numberOfRows = [self.dataSource numberOfRows];
    
	if ([self.collectionViewDelegate respondsToSelector:@selector(heightForRowAtPosition:)]) {
		for (NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
			CGFloat rowHeight = [self.dataSource heightForRowAtPosition:rowIndex];
            
			self.rowHeights[rowIndex] = @(rowHeight);
			self.totalHeight += rowHeight;
		}
	}
	else {
		for (NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++) {
			/// Setting a default value of 40 for cell size
			self.rowHeights[rowIndex] = @40;
			self.totalHeight += 40;
		}
	}
    
    
    
	return self.rowHeights;
}

#pragma mark - Layout Methods -


- (void)layoutTableForYOffset:(CGFloat)yOffset height:(CGFloat)height {
	// Remove
	NSMutableArray *newVisibleCells = [@[] mutableCopy];
	__block NSUInteger newVisibleCellsGlobalIndexOffset = self.visibleCellsGlobalIndexOffset;
    
	[self.visibleCells enumerateObjectsUsingBlock: ^(MWTableViewCell *cell, NSUInteger idx, BOOL *stop) {
	    CGFloat cellYOffset = CGRectGetMinY(cell.frame);
	    CGFloat cellHeight  = CGRectGetHeight(cell.frame);
        
	    if (RANGES_INTERSECT(yOffset, height, cellYOffset, cellHeight)) {
	        if (newVisibleCells.count == 0) {
	            newVisibleCellsGlobalIndexOffset = self.visibleCellsGlobalIndexOffset + idx;
			}
            
	        [newVisibleCells addObject:cell];
		}
	}
     
     ];
    
	[self.visibleCells removeObjectsInArray:newVisibleCells];
    
	[self.visibleCells enumerateObjectsUsingBlock: ^(MWTableViewCell *cell, NSUInteger idx, BOOL *stop) {
	    [self enqueueReusableCell:cell withIdentifier:cell.reuseIdentifier];
	    [cell removeFromSuperview];
	}
     
     ];
    
	self.visibleCells = newVisibleCells;
	self.visibleCellsGlobalIndexOffset = newVisibleCellsGlobalIndexOffset;
    
	// Add
    
    
    
	NSIndexSet *visibleCellGlobalRowIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.visibleCellsGlobalIndexOffset, self.visibleCells.count)];
    
	NSMutableArray *newCells = [NSMutableArray array];
	__block NSUInteger newCellsGlobalIndexOffset = 0;
    
	CGFloat precedingRowsYOffset = 0.f;
	for (NSInteger i = 0; i < [self.dataSource numberOfRows]; i++) {
		NSUInteger globalRowIndex = i;
		CGFloat rowYOffset = precedingRowsYOffset;
		CGFloat rowHeight  = [self.rowHeights[i] floatValue];
        
		if (![visibleCellGlobalRowIndexSet containsIndex:i] && RANGES_INTERSECT(yOffset, height, rowYOffset, rowHeight)) {
			MWTableViewCell *cell = [self.dataSource tableView:self cellAtPosition:i];
			cell.frame = CGRectMake(0.f, rowYOffset, self.frame.size.width, rowHeight);
            
			[self addSubview:cell];
            
			if (newCells.count == 0) {
				newCellsGlobalIndexOffset = globalRowIndex;
			}
			[newCells addObject:cell];
		}
        
		precedingRowsYOffset += rowHeight;
	}
    
    
	if (newCells.count > 0) {
		if (newCellsGlobalIndexOffset > self.visibleCellsGlobalIndexOffset) {
			[self.visibleCells addObjectsFromArray:newCells];
		}
		else {
			self.visibleCellsGlobalIndexOffset = newCellsGlobalIndexOffset;
			[self.visibleCells insertObjects:newCells atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newCells.count)]];
		}
	}
}

#pragma mark - Deletion Module -

- (void)didDeleteCellWithPosition:(NSNotification *)notif {
	MWTableViewCell *deletedCell = (MWTableViewCell *)[notif object];
    
	[self.collectionViewDelegate didDeleteCellWithPosition:deletedCell.rowPosition];
    
    
	NSMutableArray *arrayToRemove = [@[] mutableCopy];
    
	for (MWTableViewCell *cell in self.visibleCells) {
		if (cell.rowPosition >= deletedCell.rowPosition) {
			[cell removeFromSuperview];
			[arrayToRemove addObject:cell];
		}
	}
	[self.visibleCells removeObjectsInArray:arrayToRemove];
	[self setNeedsLayout];
}

#pragma mark - Selection Module -

- (void)didSelectCellWithPosition:(NSNotification *)notif {
	MWTableViewCell *selectedCell = (MWTableViewCell *)[notif object];
	MWTableViewCell *mockingView = [selectedCell copy];
	mockingView.frame = selectedCell.frame;
	mockingView.bounds = selectedCell.bounds;
	[mockingView setClipsToBounds:YES];
    
	[UIView animateWithDuration:0.25 animations: ^() {
	    [self addSubview:mockingView];
	}
     
                     completion: ^(BOOL finished) {
                         [self bringSubviewToFront:mockingView];
                         [self setScrollEnabled:NO];
                         [mockingView startAnimatingFullScreen:mockingView];
                         self.isFullScreenOn = YES;
                     }
     
     ];
}

- (void)didDismiss:(NSNotification *)notif {
	MWTableViewCell *viewToRemove = (MWTableViewCell *)[self viewWithTag:CELL_TAG];
    
    
	[UIView animateWithDuration:FULLSCREEN_ANIMATION_DURATION
	                      delay:0
	                    options:UIViewAnimationOptionAllowAnimatedContent
	                 animations: ^{
                         viewToRemove.frame = CGRectMake(-viewToRemove.frame.size.width, viewToRemove.frame.origin.y, viewToRemove.frame.size.width, viewToRemove.frame.size.height);
                     }
     
                     completion: ^(BOOL stop) {
                         self.isFullScreenOn = NO;
                         [self setScrollEnabled:YES];
                         [viewToRemove removeFromSuperview];
                     }
     
     ];
}

@end
