//
//  MWTableView.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.


//  This file represents the implemntation for the customizable table view , re-usage pattern was inspired from the tutorial of mike-ash

@import UIKit;
#import "MWTableViewDataSource.h"
#import "MWTableViewDelegate.h"
#import "MWDefintions.h" 


@class MWTableViewCell;

@interface MWTableView : UIScrollView

/**
 *  The delegate property where selections , cell deletions , cell -reordering are notified through it
 */
@property (nonatomic, weak) id <MWTableViewDelegate> collectionViewDelegate;

/**
 *  The data source  where data to be filled by the tableview is passed through it , usually owned by the view controller owning the table view
 */
@property (nonatomic, weak) id <MWTableViewDataSource> dataSource;

/**
 *  This method deques an alaready initated cell with the passed re-use identfier and intiates a new one if not cell is avialable
 *
 *  @param reuseIdentifier String to identify type of cell needed to dequeue
 *
 *  @return object instance from the cell
 */
- (MWTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)reuseIdentifier;

/**
 *  Exactly the same as in Apple's UITableview to reload all
 */
- (void)reloadData;


@end
