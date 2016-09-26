//
//  UILabel+Additions.m
//  ooApp
//
//  Created by Anuj Gujar on 8/21/15.
//  Copyright (c) 2015 Oomami Inc. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)


+ (UILabel *)labelWithText:(NSString *)text addedToView:(UIView *)view {
    UILabel *l = [UILabel new];
    l.text = text;
    [view addSubview:l];
    return l;
}

+ (UILabel *)labelWithText:(NSString *)text addedToView:(UIView *)view withFontSize:(NSUInteger)fontSize withTextAlignment:(NSTextAlignment)textAlignment {
    UILabel *l = [UILabel new];
    [view addSubview:l];
    l.text = text;
//    l.font = [UIFont fontWithName:kFontLatoRegular size:fontSize];
    l.numberOfLines = 0;
    l.textAlignment = textAlignment;
    l.lineBreakMode = NSLineBreakByWordWrapping;
    l.clipsToBounds = NO;
    return l;
}

- (void)withFont:(UIFont *)font textColor:(NSUInteger)color backgroundColor:(NSUInteger)backgroundColor {
    self.font = font;
    self.textColor = [UIColor blackColor];
//    self.backgroundColor = UIColorRGBA(backgroundColor);
    self.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)withFont:(UIFont *)font textColor:(NSUInteger)color backgroundColor:(NSUInteger)backgroundColor numberOfLines:(NSInteger)numberOfLines lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment)textAlignment {
    
    [self withFont:font textColor:color backgroundColor:backgroundColor];
    self.numberOfLines = numberOfLines;
    self.lineBreakMode = lineBreakMode;
    self.textAlignment = textAlignment;
}

- (void)withIcon:(NSString *)text withFontSize:(NSUInteger)fontSize addedToView:(UIView *)view {
    
    [view addSubview:self];
    self.textAlignment = NSTextAlignmentCenter;
    self.text = text;
//    self.font = [UIFont fontWithName:kFontIcons size:fontSize];
}










@end
