//
//  FilterThumbnailCVCell.m
//  Filters
//
//  Created by James Rochabrun on 9/25/16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "FilterThumbnailCVCell.h"
#import "FilterSettings.h"
#import "UILabel+Additions.h"



@implementation FilterThumbnailCVCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _filterType = [UILabel new];
        [_filterType setTextColor:[UIColor blackColor]];
        [_filterType setTextAlignment:NSTextAlignmentCenter];
        [_filterType setLineBreakMode:NSLineBreakByWordWrapping];
        [_filterType setNumberOfLines:0];
        
        _editionType = [UILabel new];
        [_editionType setTextColor:[UIColor blackColor]];
        [_editionType setTextAlignment:NSTextAlignmentCenter];
        [_editionType setLineBreakMode:NSLineBreakByWordWrapping];
        [_editionType setNumberOfLines:0];
        
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        _selectedView = [UIView new];
        _selectedView.backgroundColor = [UIColor orangeColor];
        _selectedView.hidden = YES;
        
        [self addSubview:_filterType];
        [self addSubview:_imageView];
        [self addSubview:_editionType];
        [self addSubview:_selectedView];
        
        //[DebugUtilities addBorderToViews:@[ self]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _filterType.frame;
    frame.size = CGSizeMake(self.frame.size.width, 15);
    frame.origin = CGPointMake(0, 0);
    _filterType.frame = frame;
    
    frame = _imageView.frame;
    frame.size = CGSizeMake(self.frame.size.width, self.frame.size.height - _filterType.frame.size.height);
    frame.origin.y = CGRectGetMaxY(_filterType.frame) + 2;
    _imageView.frame = frame;
    
    frame = _editionType.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = 30;
    frame.origin.x = 0;
    frame.origin.y = (self.frame.size.height - _filterType.frame.size.height + 2) /2;
    _editionType.frame = frame;
    
    frame = _selectedView.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = 6;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(self.frame) - 6 +  2;
    _selectedView.frame = frame;
}

- (void)setSelected:(BOOL)selected {
    
    self.selectedView.hidden = !selected;
}

- (void)setSettings:(FilterSettings *)settings {
    
    _settings = settings;
    _filter = settings.filter;
    _touched = settings.touched;
    
    [self setNeedsLayout];
}


@end
