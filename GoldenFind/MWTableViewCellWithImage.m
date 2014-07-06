//
//  GFCellWithImage.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/2/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWTableViewCellWithImage.h"

@interface MWTableViewCellWithImage ()

@property (nonatomic, readwrite, assign) ImageType cellType;
@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *detailLabel;
@property (nonatomic, readwrite) NSDictionary *attributes;
@end

@implementation MWTableViewCellWithImage

@synthesize  cellType;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;

@synthesize attributes = _attributes;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:CGRectZero]) {
		self.reuseIdentifier = reuseIdentifier;
		self.cellType = IMAGECELL;
	}
	return self;
}

- (void)setAttributes:(NSDictionary *)attributes {
	self.titleLabel.text = attributes[@"titleLabel"];
	self.titleLabel.tag = CELL_TITLE_LABEL_TAG;
	self.detailLabel.text = attributes[@"detail"];
	self.detailLabel.tag = CELL_DETAIL_LABEL_TAG;
	self.cellImage.image = attributes[@"image"];
	self.cellImage.tag = MAIN_CELL_VIEW_TAG;
	_attributes = attributes;
	[self setNeedsLayout];
}

- (UIImageView *)cellImage {
	if (_cellImage == nil) {
		_cellImage = [[UIImageView alloc]initWithFrame:CGRectZero];
		[self addSubview:_cellImage];
	}
	return _cellImage;
}

- (UILabel *)titleLabel {
	if (_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.numberOfLines = 0;
		[_titleLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
		[self addSubview:_titleLabel];
	}
    
	return _titleLabel;
}

- (UILabel *)detailLabel {
	if (_detailLabel == nil) {
		_detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_detailLabel.numberOfLines = 0;
		[_detailLabel setFont:[UIFont fontWithName:@"Arial" size:14]];
        
		[self addSubview:_detailLabel];
	}
    
	return _detailLabel;
}

- (void)layoutSubviews {
	if (self.isSelected) {
		return;
	}
	if (_titleLabel) {
		self.titleLabel.frame = CGRectMake((self.frame.size.width / 4) + 5, 5, self.frame.size.width - (self.frame.size.width / 4) - 10, (self.frame.size.height / 2) - 5);
	}
    
	if (_detailLabel) {
		self.detailLabel.frame = CGRectMake((self.frame.size.width / 4) + 5, self.frame.size.height / 2 + 5, self.frame.size.width - (self.frame.size.width / 4) - 10, self.frame.size.height / 2 - 10);
	}
	if (_cellImage) {
		self.cellImage.frame = CGRectMake(5, 10, (self.frame.size.width / 4), (self.frame.size.height / 2) - 10);
	}
	self.layer.borderColor = [UIColor purpleColor].CGColor;
	self.layer.borderWidth = 0.25;
}

@end
