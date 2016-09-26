//
//  FilterView.h
//  Filters
//
//  Created by James Rochabrun on 9/25/16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterViewDelegate <NSObject>
- (void)setTheInputImage:(UIImage *)image;



@end

@interface FilterView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *listLayout;
@property (nonatomic, weak) id<FilterViewDelegate>delegate;


@end
