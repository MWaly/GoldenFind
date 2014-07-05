//
//  GFViewController.h
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

/**
 *  This class is the view controller holding the the MWTableView Instance for Demo purpose 
 */

@import UIKit;
#import "MWTableViewDataSource.h"
#import "MWTableViewDelegate.h"


@interface GFViewController : UIViewController <MWTableViewDataSource, MWTableViewDelegate>

@end
