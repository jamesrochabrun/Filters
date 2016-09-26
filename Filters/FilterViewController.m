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

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _filterView = [FilterView new];
        _filterView.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:_filterView];

}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect frame = _filterView.frame;
    frame.origin.x = 0;
    frame.origin.y = 200;
    frame.size.width = self.view.frame.size.width;
    frame.size.height = 200;
    _filterView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
