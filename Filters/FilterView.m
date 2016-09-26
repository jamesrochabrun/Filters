//
//  FilterView.m
//  Filters
//
//  Created by James Rochabrun on 9/25/16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "FilterView.h"
#import "UICollectionView+Additions.h"
#import "FilterCVFL.h"
#import "FilterThumbnailCVCell.h"

static NSString *FilterCellID = @"FilterCellID";

@implementation FilterView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _listLayout = [[FilterCVFL alloc] init];
        [_listLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [UICollectionView collectionViewWithLayout:_listLayout inView:self delegate:self];
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[FilterThumbnailCVCell class] forCellWithReuseIdentifier:FilterCellID];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = _collectionView.frame;
    frame.size = CGSizeMake(self.frame.size.width, 120);
    frame.origin.x = 0;
    frame.origin.y = 4;
    _collectionView.frame = frame;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FilterThumbnailCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterCellID forIndexPath:indexPath];
    cell.editionType.text = @"test";
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 15;
}




@end
