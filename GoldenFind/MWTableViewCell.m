//
//  GFCell.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWTableViewCell.h"
#import "MWTableViewCellWithImage.h"
#import "MWTableViewCellWithMap.h"
#import "GFPlaceViewModel.h"


/// Private Methods & Properties
@interface MWTableViewCell ()

// Boolean trigerred when a delete button appears
@property (nonatomic, assign) BOOL isDeleteButtonOn;
@property (nonatomic, assign, readwrite) BOOL isSelected;
@end


@implementation MWTableViewCell


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		/// Adding the gestures for moving to detailed view and selection INvocation
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
		tapGesture.numberOfTapsRequired = 1;
		[self addGestureRecognizer:tapGesture];
		tapGesture.delegate = self;
        
        
		UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
		swipeGesture.delegate = self;
		swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
		[self addGestureRecognizer:swipeGesture];
        
		UISwipeGestureRecognizer *swipeGestureCancellation = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
		swipeGestureCancellation.delegate = self;
		swipeGestureCancellation.direction = UISwipeGestureRecognizerDirectionRight;
		[self addGestureRecognizer:swipeGestureCancellation];
        
        
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
		panGesture.delegate = self;
		// [self addGestureRecognizer:panGesture];
	}
	return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType {
	if (cellType == IMAGECELL) {
		return [[MWTableViewCellWithImage alloc]initWithReuseIdentifier:reuseIdentifier];
	}
	else {
		return [[MWTableViewCellWithMap alloc]initWithReuseIdentifier:reuseIdentifier];
	}
}

/**
 The description Methods for Debugging Purposes
 */
#pragma mark - Debugging Methods -
- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p, \"%@ type %li \">",
	        [self class], self, _titleLabel.text, (long)_cellType];
}

#pragma mark - Gesture Recgonizers -


/**
 *  The Selection Module
 *
 *  @param gestureRecgonizer gestureRecgonizer instance returned
 */
- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecgonizer {
	[[NSNotificationCenter defaultCenter] postNotificationName:MWDidSelectACell object:self];
}

/**
 *  The Re-ordering Module
 *  Not Covered NOW
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecgonizer {
	self.backgroundColor = [UIColor yellowColor];
}

/**
 *  The Deletion Module
 *
 *  @param gestureRecgonizer gesture recgonizer instance returned
 */
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)gestureRecgonizer {
	/**
	 *  Check whether it is a right or left swipe gesture and act accordingly
	 */
	if (self.isDeleteButtonOn) {
		/**
		 *  Get a reference to the button and remove it with a proper animation ,
		 *
		 */
		UIButton *deleteButton = (UIButton *)[self viewWithTag:DELETEBUTTONTAG];
        
		/**
		 *  Animate removal of delete button
		 */
		[UIView animateWithDuration:DELETEANIMATIONDURATION
		                      delay:0
		                    options:UIViewAnimationOptionAllowAnimatedContent
		                 animations: ^{
                             self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width - DELETEBUTTONWIDTH, self.frame.size.height);
                             deleteButton.frame = CGRectMake(deleteButton.frame.origin.x + DELETEBUTTONWIDTH, deleteButton.frame.origin.y, deleteButton.frame.size.width, deleteButton.frame.size.height);
                         }
         
		                 completion: ^(BOOL stop) {
                             [deleteButton removeFromSuperview];
                         }
         
         ];
		self.isDeleteButtonOn = NO;
		[[NSNotificationCenter defaultCenter] postNotificationName:MWDidCancelDeleteButton object:self];
	}
	else {
		UIButton *deleteButton = [GFPlaceViewModel getDeleteButton];
        
		[deleteButton addTarget:self action:@selector(didPressDelete) forControlEvents:UIControlEventTouchUpInside];
		[deleteButton setFrame:CGRectMake(self.frame.size.width, 0, DELETEBUTTONWIDTH, self.frame.size.height)];
        
        
		[UIView animateWithDuration:DELETEANIMATIONDURATION
		                      delay:0
		                    options:UIViewAnimationOptionAllowAnimatedContent
		                 animations: ^{
                             self.frame = CGRectMake(-DELETEBUTTONWIDTH, self.frame.origin.y, self.frame.size.width + DELETEBUTTONWIDTH, self.frame.size.height);
                             [self addSubview:deleteButton];
                         }
         
		                 completion:nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:MWDidDisplayDeleteButton object:self];
		self.isDeleteButtonOn = YES;
	}
}

// Notify the Delegate of user's decision to delete this cell
- (void)didPressDelete {
	self.isDeleteButtonOn = NO;
	[[NSNotificationCenter defaultCenter] postNotificationName:MWDidDeleteACell object:self];
}

#pragma mark - FULL SCREEN MODULE


/**
 *  Copying implementation here for the full screen purpose
 *
 *  @param zone memory part
 *
 *  @return modified version of the cell
 *
 */

- (instancetype)copyWithZone:(NSZone *)zone {
	MWTableViewCell *copy = [[[self class] allocWithZone:zone]
	                         initWithReuseIdentifier:self.reuseIdentifier cellType:self.cellType];
	[copy setAttributes:self.attributes];
	[copy setIsSelected:YES];
	[copy setGestureRecognizers:nil];
	[copy setTag:CELL_TAG];
    
	[copy setBackgroundColor:[UIColor whiteColor]];
    
	return copy;
}

- (void)startAnimatingFullScreen:(UIView *)fullScreenView {
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton addTarget:self action:@selector(didDismiss) forControlEvents:UIControlEventTouchUpInside];
	[closeButton setBackgroundColor:[UIColor redColor]];
	[closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[closeButton setTitle:@"DISMISS" forState:UIControlStateNormal];
	[closeButton setFrame:CGRectMake(0, 0, self.frame.size.width, self.superview.bounds.size.height * DISMISSBUTTONRATIO)];
	closeButton.alpha = 0;
	[fullScreenView addSubview:closeButton];
	UILabel *titleLabel = (UILabel *)[fullScreenView viewWithTag:CELL_TITLE_LABEL_TAG];
	UILabel *detailLabel = (UILabel *)[fullScreenView viewWithTag:CELL_DETAIL_LABEL_TAG];
	UIView *mainView = [fullScreenView viewWithTag:MAIN_CELL_VIEW_TAG];
    
	[UIView animateWithDuration:FULLSCREEN_ANIMATION_DURATION
	                      delay:0
	                    options:UIViewAnimationOptionAllowAnimatedContent
	                 animations: ^{
                         self.frame = CGRectMake(self.superview.bounds.origin.x, self.superview.bounds.origin.y, self.superview.bounds.size.width, self.superview.bounds.size.height);
                         
                         closeButton.alpha = 1;
                         [titleLabel setFrame:CGRectMake(WIDTH_MARGIN, closeButton.frame.origin.y + closeButton.frame.size.height + VERTICAL_MARGIN_RATIO, self.frame.size.width - (2 * WIDTH_MARGIN), self.frame.size.height * TITLE_LABEL_RATIO)];
                         [mainView setFrame:CGRectMake(WIDTH_MARGIN, titleLabel.frame.origin.y + titleLabel.frame.size.height + VERTICAL_MARGIN_RATIO, self.frame.size.width - (2 * WIDTH_MARGIN), self.frame.size.height * MAINVIEWRATIO)];
                         [detailLabel setFrame:CGRectMake(WIDTH_MARGIN, mainView.frame.origin.y + mainView.frame.size.height + VERTICAL_MARGIN_RATIO, self.frame.size.width - (2 * WIDTH_MARGIN), self.frame.size.height * DETAIL_LABEL_RATIO)];
                     }
     
	                 completion:nil];
}

/**
 *  Removal of the Full Screen through notifying the MWTableview delegate to take appropriate action
 */
- (void)didDismiss {
	[[NSNotificationCenter defaultCenter]postNotificationName:MWDidCancelCellSelection object:nil userInfo:nil];
}

@end
