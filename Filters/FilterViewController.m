//
//  FilterViewController.m
//  Filters
//
//  Created by James Rochabrun on 9/25/16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterView.h"

@interface FilterViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FilterView *filterView;


@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _filterView = [FilterView new];
    [self.view addSubview:_filterView];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
        
    CGRect frame = _filterView.frame;
    frame.size.width = self.view.frame.size.width;
    frame.size.height = 220;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(self.view.frame) - frame.size.height;
    _filterView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
