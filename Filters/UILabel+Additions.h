//
//  UILabel+Additions.h
//  ooApp
//
//  Created by Anuj Gujar on 8/21/15.
//  Copyright (c) 2015 Oomami Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (Additions)

+ (UILabel *)labelWithText:(NSString *)text addedToView:(UIView *)view;
+ (UILabel *)labelWithText:(NSString *)text addedToView:(UIView *)view withFontSize:(NSUInteger)fontSize withTextAlignment:(NSTextAlignment)textAlignment;
- (void)withFont:(UIFont *)font textColor:(NSUInteger)color backgroundColor:(NSUInteger)backgroundColor;
- (void)withFont:(UIFont *)font textColor:(NSUInteger)color backgroundColor:(NSUInteger)backgroundColor numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment;
- (void)withIcon:(NSString *)text withFontSize:(NSUInteger)fontSize addedToView:(UIView *)view;



@end
