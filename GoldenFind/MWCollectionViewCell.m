//
//  GFCell.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWCollectionViewCell.h"
#import "MWCollectionViewCellWithImage.h"
#import "MWCollectionViewCellWithMap.h"

/// Private Methods & Properties
@interface MWCollectionViewCell ()

// Boolean trigerred when a delete button appears
@property (nonatomic, assign) BOOL isDeleteButtonOn;
@end


@implementation MWCollectionViewCell


- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		/// Adding the gestures for moving to detailed view
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
		tapGesture.numberOfTapsRequired = 1;
		[self addGestureRecognizer:tapGesture];
		tapGesture.delegate = self;
        
        
		UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
		swipeGesture.delegate = self;
		[self addGestureRecognizer:swipeGesture];
        
        
		UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
		panGesture.delegate = self;
		// [self addGestureRecognizer:panGesture];
	}
	return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier cellType:(ImageType)cellType {
	if (cellType == IMAGECELL) {
		return [[MWCollectionViewCellWithImage alloc]initWithReuseIdentifier:reuseIdentifier];
	}
	else {
		return [[MWCollectionViewCellWithMap alloc]initWithReuseIdentifier:reuseIdentifier];
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

///////////////////////| The Selection Module |\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
- (void)handleTapGesture:(UITapGestureRecognizer *)gestureRecgonizer {
	self.backgroundColor = [UIColor redColor];
}

///////////////////////| The Re-Ordering Module |\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecgonizer {
	self.backgroundColor = [UIColor yellowColor];
}

///////////////////////| The Deleting Module |\\\\\\\\\\\\\\\\\\\\\\\\\\\
//
- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)gestureRecgonizer {
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	deleteButton.backgroundColor = [UIColor redColor];
	[deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
	[deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[deleteButton addTarget:self action:@selector(didPressDelete) forControlEvents:UIControlEventTouchUpInside];
	[deleteButton setFrame:CGRectMake(self.frame.size.width, 0, 80, self.frame.size.height)];
    
	[UIView animateWithDuration:1.0
	                      delay:0.3
	                    options:UIViewAnimationOptionAllowAnimatedContent
	                 animations: ^{
                         self.frame = CGRectMake(-80, self.frame.origin.y, self.frame.size.width + 80, self.frame.size.height);
                         [self addSubview:deleteButton];
                     }
     
	                 completion:nil];
	self.isDeleteButtonOn = YES;
}

// Notify the Delegate of user's decision to delete this cell
- (void)didPressDelete {
}

@end
