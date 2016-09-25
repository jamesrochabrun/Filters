//
//  SlidersView.m
//  ooApp
//
//  Created by James Rochabrun on 8/21/16.
//  Copyright © 2016 Oomami Inc. All rights reserved.
//


#import "SlidersView.h"
#import "UISlider+Additions.h"
#import "CommonUIConstants.h"
#import "FilterSettings.h"

@implementation SlidersView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _slider = [UISlider sliderWithMinValue:_settings.minValue minTrackTintColor:kColorBordersAndLines andMaxValue:_settings.maxValue maxTrackTintColor:kColorBordersAndLines continuous:YES];
        [self addSubview:_slider];
        
        _nameLabel = [UILabel new];
        [_nameLabel withFont:[UIFont fontWithName:kFontLatoRegular size:kGeomFontSizeH3] textColor:kColorGrayMiddle backgroundColor:kColorClear numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter];
        [self addSubview:_nameLabel];
        
        _valueLabel = [UILabel new];
        [_valueLabel withFont:[UIFont fontWithName:kFontLatoRegular size:kGeomFontSizeH3] textColor:kColorGrayMiddle backgroundColor:kColorClear numberOfLines:0 lineBreakMode:NSLineBreakByWordWrapping textAlignment:NSTextAlignmentCenter];
        [self addSubview:_valueLabel];
    }
    return self;
}

- (void)setSettings:(FilterSettings *)settings {
    
    _settings = settings;
    _nameLabel.text = settings.displayName;
    _slider.minimumValue = settings.minValue;
    _slider.maximumValue = settings.maxValue;
    _slider.value = settings.value;
    _touched = settings.touched;
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", settings.value * settings.displayNumber];
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _nameLabel.frame;
    frame.origin.x = (width(self) - width(_nameLabel))/2;
    frame.origin.y = kGeomSpaceInter;
    frame.size.width = width(self);
    frame.size.height = 30;
    _nameLabel.frame = frame;
    
    frame = _valueLabel.frame;
    frame.size.width = 100;
    frame.size.height = 30;
    frame.origin.x = (width(self) - width(_valueLabel))/2;
    frame.origin.y = CGRectGetMaxY(_nameLabel.frame) + kGeomSpaceInter;
    _valueLabel.frame = frame;
    
    
    frame = _slider.frame;
    frame.size.width = width(self) - 70;
    frame.size.height = 30;
    frame.origin.x = (width(self) - width(_slider))/2;
    frame.origin.y = CGRectGetMaxY(_valueLabel.frame) + kGeomSpaceInter;
    _slider.frame = frame;
    
}











@end
