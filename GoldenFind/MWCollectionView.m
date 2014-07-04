//
//  GFCollectionViewController.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//



#import "MWCollectionView.h"
#import "MWCollectionViewCell.h"

#define RANGES_INTERSECT(location1, length1, location2, length2) ((location1 + length1 >= location2) && (location2 + length2 >= location1))
@interface MWCollectionView ()

//Data which will be displayed by the table
@property(nonatomic) NSArray *tableData;

// Cells currently visible
@property(nonatomic) NSMutableArray *visibleCells;

// The first visible cell offset
@property(nonatomic) NSUInteger      visibleCellsGlobalIndexOffset;

//
@property(nonatomic) NSMutableSet   *reusePool;

// The totalHeight
@property (nonatomic,assign)CGFloat totalHeight;

//Array Holding Different Row Heights
@property(nonatomic)  NSMutableArray   *rowHeights;

- (NSArray *)captureTableStructure;
- (void)layoutTableForYOffset:(CGFloat)yOffset height:(CGFloat)height;
- (void)enqueueReusableCell:(MWCollectionViewCell *)cell withIdentifier:(NSString *)reuseIdentifier;

@end
@implementation MWCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.visibleCells  = [@[]mutableCopy];
        self.reusePool    = [NSMutableSet set];
        self.rowHeights=[@[]mutableCopy];
        
    }
    return self;
}


- (MWCollectionViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier
{
    __block MWCollectionViewCell *poolCell = nil;
    
    [self.reusePool enumerateObjectsUsingBlock:^(MWCollectionViewCell *cell, BOOL *stop) {
        if([cell.reuseIdentifier isEqualToString:reuseIdentifier])
        {
            poolCell = cell;
            *stop = YES;
        }
    }];
    
    if(poolCell)
    {
        [self.reusePool removeObject:poolCell];
        [poolCell prepareForReuse];
    }
    
    return poolCell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.tableData == nil) [self reloadData];
    
    [self layoutTableForYOffset:CGRectGetMinY(self.bounds) height:CGRectGetHeight(self.bounds)];
    
}

- (void)reloadData
{
    self.tableData = [self captureTableStructure];
    
    self.contentSize = CGSizeMake(self.bounds.size.width,self.totalHeight);
}


#pragma mark - Private Methods

- (void)enqueueReusableCell:(MWCollectionViewCell *)cell withIdentifier:(NSString *)reuseIdentifier
{
    cell.reuseIdentifier = reuseIdentifier;
    [self.reusePool addObject:cell];
}

- (NSArray *)captureTableStructure
{

    self.totalHeight = 0.f;
    [self.rowHeights removeAllObjects];
    
        // Rows
        NSInteger numberOfRows = [self.dataSource numberOfRows];
   
        if([self.collectionViewDelegate respondsToSelector:@selector(heightForRowAtPosition:)])
        {
            for(NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++)
            {
                
                CGFloat rowHeight = [self.dataSource heightForRowAtPosition:rowIndex];
                
                self.rowHeights[rowIndex] = @(rowHeight);
                self.totalHeight += rowHeight;
            }
        }
        else
        {
            for(NSInteger rowIndex = 0; rowIndex < numberOfRows; rowIndex++)
            {
                /// Setting a default value of 40 for cell size
                self.rowHeights[rowIndex] = @40;
                self.totalHeight += 40;
                           }
        }


    
    return self.rowHeights;
}

#pragma mark Layout Methods

- (void)layoutTableForYOffset:(CGFloat)yOffset height:(CGFloat)height
{
    // Remove
    NSMutableArray *newVisibleCells = [@[]mutableCopy];
    __block NSUInteger newVisibleCellsGlobalIndexOffset = self.visibleCellsGlobalIndexOffset;
    
    [self.visibleCells enumerateObjectsUsingBlock:^(MWCollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
        CGFloat cellYOffset = CGRectGetMinY(cell.frame);
        CGFloat cellHeight  = CGRectGetHeight(cell.frame);
        
        if(RANGES_INTERSECT(yOffset, height, cellYOffset, cellHeight))
        {
            if(newVisibleCells.count == 0)
            {
                newVisibleCellsGlobalIndexOffset = self.visibleCellsGlobalIndexOffset + idx;
            }
            
            [newVisibleCells addObject:cell];
        }
    }];
    
    [self.visibleCells removeObjectsInArray:newVisibleCells];
    
    [self.visibleCells enumerateObjectsUsingBlock:^(MWCollectionViewCell *cell, NSUInteger idx, BOOL *stop) {
        [self enqueueReusableCell:cell withIdentifier:cell.reuseIdentifier];
        [cell removeFromSuperview];
    }];
    
    self.visibleCells = newVisibleCells;
    self.visibleCellsGlobalIndexOffset = newVisibleCellsGlobalIndexOffset;
    
    // Add
  
    
   
    NSIndexSet *visibleCellGlobalRowIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.visibleCellsGlobalIndexOffset, self.visibleCells.count)];
    
    NSMutableArray *newCells = [NSMutableArray array];
    __block NSUInteger newCellsGlobalIndexOffset = 0;
    
    
    
    
                                           CGFloat precedingRowsYOffset = 0.f;
                                           for(NSInteger i = 0; i < [self.dataSource numberOfRows]; i++)
                                           {
                                                 NSUInteger globalRowIndex = i;
                                               CGFloat rowYOffset = precedingRowsYOffset;
                                               CGFloat rowHeight  = [self.rowHeights[i] floatValue];
                                               
                                               if(![visibleCellGlobalRowIndexSet containsIndex:i] && RANGES_INTERSECT(yOffset, height, rowYOffset, rowHeight))
                                               {
                                                   
                                                   
                                                   MWCollectionViewCell *cell = [self.dataSource tableView:self cellAtPosition:i];
                                                   cell.frame = CGRectMake(0.f, rowYOffset, self.frame.size.width, rowHeight);
                                  
                                                   [self addSubview:cell];
                                                   
                                                   if(newCells.count == 0)
                                                   {
                                                       newCellsGlobalIndexOffset = globalRowIndex;
                                                   }
                                                   [newCells addObject:cell];
                                               }
                                               
                                               precedingRowsYOffset += rowHeight;
                                           }

    
    if(newCells.count > 0)
    {
        if(newCellsGlobalIndexOffset > self.visibleCellsGlobalIndexOffset)
        {
            [self.visibleCells addObjectsFromArray:newCells];
        }
        else
        {
            self.visibleCellsGlobalIndexOffset = newCellsGlobalIndexOffset;
            [self.visibleCells insertObjects:newCells atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newCells.count)]];
        }
    }
}




@end
