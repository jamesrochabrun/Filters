//
//  UISlider+Additions.h
//  ooApp
//
//  Created by James Rochabrun on 8/22/16.
//  Copyright © 2016 Oomami Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (Additions)
+ (UISlider *)sliderWithMinValue:(float)minValue minTrackTintColor:(NSUInteger)minTrackTintColor andMaxValue:(float)maxValue maxTrackTintColor:(NSUInteger)maxTrackTintColor continuous:(BOOL)continuous;
@end
