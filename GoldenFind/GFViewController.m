//
//  GFViewController.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFViewController.h"
#import "MWTableView.h"
#import "GFInteractor.h"
#import "GFPlaceViewModel.h"
#import "GFPlace.h"
#import "MWTableViewCell.h"


@interface GFViewController ()
@property (nonatomic, strong) NSMutableArray *arrayOfPlaces;
@property (nonatomic, strong) MWTableView *tableView;
@end

@implementation GFViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    
	// Get the data and parse it first
	self.arrayOfPlaces = [GFInteractor loadPlacesOffline][0];
	self.tableView = [[MWTableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
	self.tableView.collectionViewDelegate = self;
	self.tableView.dataSource = self;
    
    
    
	[self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Data Source -

- (NSInteger)numberOfRows {
	return [self.arrayOfPlaces count];
}

- (MWTableViewCell *)tableView:(MWTableView *)tableView cellAtPosition:(NSInteger)rowPosition {
	static NSString *reuseIdentifier = @"MAPCELL";
	static NSString *reuseIdentifier2 = @"IMAGECELL";
    
	GFPlace *currentPlace = self.arrayOfPlaces[rowPosition];
    
	// Handling Map Type Cell
	if (currentPlace.type == MAP) {
		MWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
		if (cell == nil) {
			cell = [[MWTableViewCell alloc]initWithReuseIdentifier:reuseIdentifier cellType:MAPCELL];
			NSLog(@"New one map");
		}
		[cell setAttributes:@{ @"titleLabel":currentPlace.titleText, @"detail":currentPlace.detailText, @"lon":[currentPlace valueForKey:@"lon"], @"lat":[currentPlace valueForKey:@"lat"] }
         
         ];
		cell.rowPosition = rowPosition;
		return cell;
	}
    
	else {
		MWTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
		if (imageCell == nil) {
			imageCell = [[MWTableViewCell alloc]initWithReuseIdentifier:reuseIdentifier2 cellType:IMAGECELL];
			NSLog(@"New one image");
		}
		[imageCell setAttributes:@{ @"titleLabel":[NSString stringWithFormat:@"%@ %li", currentPlace.titleText, (long)[self heightForRowAtPosition:rowPosition]], @"detail":currentPlace.detailText, @"image":[currentPlace valueForKey:@"placeImage"] }
         ];
		imageCell.rowPosition = rowPosition;
		return imageCell;
	}
}

- (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition {
	GFPlace *place = self.arrayOfPlaces[rowPosition];
	return [GFPlaceViewModel getHeightForNumberOfWords:[place.detailText length]];
}

#pragma mark - Deleting Module -
- (void)didDeleteCellWithPosition:(NSInteger)rowPosition {
	[self.arrayOfPlaces removeObjectAtIndex:rowPosition];
	[self.tableView reloadData];
}

@end
