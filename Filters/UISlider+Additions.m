//
//  UISlider+Additions.m
//  ooApp
//
//  Created by James Rochabrun on 8/22/16.
//  Copyright © 2016 Oomami Inc. All rights reserved.
//

#import "UISlider+Additions.h"

@implementation UISlider (Additions)

+ (UISlider *)sliderWithMinValue:(float)minValue minTrackTintColor:(NSUInteger)minTrackTintColor andMaxValue:(float)maxValue maxTrackTintColor:(NSUInteger)maxTrackTintColor continuous:(BOOL)continuous {
    
    UISlider *slider = [UISlider new];
    slider.minimumValue = minValue;
    slider.minimumTrackTintColor = [UIColor redColor];
    slider.maximumValue = maxValue;
    slider.maximumTrackTintColor = [UIColor blueColor];
    slider.continuous = continuous;
    return slider;
}


@end
