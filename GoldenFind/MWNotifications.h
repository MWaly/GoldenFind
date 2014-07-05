//
//  MWNotifications.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/5/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

/**
 *   This class holds the notifcations strings required by the MWTableView and its componenets to communicate and invoke actions
 */


@interface MWNotifications : NSObject

#pragma mark - Delete Notfications
extern NSString * const MWDidDisplayDeleteButton;
extern NSString * const MWDidCancelDeleteButton;
extern NSString * const MWDidDeleteACell;

#pragma mark - Selection Notfications
extern NSString * const MWDidSelectACell;
extern NSString * const MWDidCancelCellSelection;

@end
