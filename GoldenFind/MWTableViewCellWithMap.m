//
//  MWTableViewCellWithMap.m
//  GoldenFind
//
//  Created by Mohamed Mokhles Waly on 7/3/14.
//  Copyright (c) 2014 Mokhles. All rights reserved.
//

#import "MWTableViewCellWithMap.h"


@interface MWTableViewCellWithMap ()
@property (nonatomic, readwrite, assign) ImageType cellType;
@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) UILabel *detailLabel;
@end

@implementation MWTableViewCellWithMap
@synthesize cellType;
@synthesize titleLabel = _titleLabel;
@synthesize detailLabel = _detailLabel;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:CGRectZero]) {
        self.reuseIdentifier = reuseIdentifier;
        self.cellType = MAPCELL;
    }
    return self;
}

- (void)setAttributes:(NSDictionary *)attributes {
    self.titleLabel.text = attributes[@"titleLabel"];
    self.detailLabel.text = attributes[@"detail"];
    self.map.centerCoordinate = CLLocationCoordinate2DMake([attributes[@"lat"] doubleValue], [attributes[@"lon"] doubleValue]);
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (MKMapView *)map {
    if (_map == nil) {
        _map = [[MKMapView alloc]initWithFrame:CGRectZero];
        [self addSubview:_map];
    }
    return _map;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextColor:[UIColor redColor]];
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
    if (_titleLabel) {
        self.titleLabel.frame = CGRectMake((self.frame.size.width / 4) + 5, 5, self.frame.size.width - (self.frame.size.width / 4) - 10, (self.frame.size.height / 2) - 5);
    }
    
    if (_detailLabel) {
     	self.detailLabel.frame = CGRectMake((self.frame.size.width / 4) + 5, self.frame.size.height / 2 + 5, self.frame.size.width - (self.frame.size.width / 4) - 10, self.frame.size.height / 2 - 10);
    }
    if (_map) {
        self.map.frame = CGRectMake(5, 10, (self.frame.size.width / 4), (self.frame.size.height / 2) - 10);
          self.map.tag=5;
    }
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 0.25;
}

@end
