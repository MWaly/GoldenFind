//
//  GFViewController.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "GFViewController.h"
#import "MWCollectionView.h"
#import "GFInteractor.h"
#import "GFPlaceViewModel.h"
#import "GFPlace.h"
#import "MWCollectionViewCell.h"


@interface GFViewController ()
@property (nonatomic,strong)NSArray* arrayOfPlaces;
@end

@implementation GFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Get the data and parse it first
    self.arrayOfPlaces= [GFInteractor loadPlacesOffline][0];
    MWCollectionView *collectionView=[[MWCollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    collectionView.collectionViewDelegate=self;
    collectionView.dataSource=self;
    
    
    
    [self.view addSubview:collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Source -

- (NSInteger)numberOfRows
{
    return [self.arrayOfPlaces count];
}
- (MWCollectionViewCell *)tableView:(MWCollectionView *)tableView cellAtPosition:(NSInteger)rowPosition
{

    static NSString *reuseIdentifier = @"MAPCELL";
    static NSString *reuseIdentifier2 = @"IMAGECELL";
    
    GFPlace *currentPlace=self.arrayOfPlaces[rowPosition];
    
    // Handling Map Type Cell
    if (currentPlace.type==MAP) {
        MWCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            cell = [[MWCollectionViewCell alloc]initWithReuseIdentifier:reuseIdentifier cellType:MAPCELL];
            NSLog(@"New one map");

        }
        [cell setAttributes:@{@"titleLabel":currentPlace.titleText,@"detail":currentPlace.detailText,@"lon":[currentPlace valueForKey:@"lon"],@"lat":[currentPlace valueForKey:@"lat"]}];
        
        return cell;
    }
    
    else
    {
            MWCollectionViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier2];
            if (imageCell == nil) {
             imageCell = [[MWCollectionViewCell alloc]initWithReuseIdentifier:reuseIdentifier2 cellType:IMAGECELL];
                   NSLog(@"New one image");
                
            }
       [imageCell setAttributes:@{@"titleLabel":currentPlace.titleText,@"detail":currentPlace.detailText,@"image":[currentPlace valueForKey:@"placeImage"]}];
            return imageCell;
        }

}


- (NSInteger)heightForRowAtPosition:(NSInteger)rowPosition
{
    GFPlace *place=self.arrayOfPlaces[rowPosition];
    return [GFPlaceViewModel getHeightForNumberOfWords:[place.detailText length]];
}



@end
