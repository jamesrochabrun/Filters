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
#import "FilterSettings.h"
#import "SlidersView.h"

static NSString *FilterCellID = @"FilterCellID";
static CGFloat kGeomInterImageGap = 2;
static CGFloat kGeomSpaceEdge = 6;
//filter names
static NSString *const kCIColorControls = @"CIColorControls";
static NSString *const kCIExposureAdjust = @"CIExposureAdjust";
static NSString *const kCIHighlightShadowAdjust = @"CIHighlightShadowAdjust";
static NSString *const kCIVignette = @"CIVignette";
static NSString *const kCISharpenLuminance = @"CISharpenLuminance";
static NSString *const kCIGammaAdjust = @"CIGammaAdjust";
static NSString *const kCIPhotoEffectTransfer = @"CIPhotoEffectTransfer";
static NSString *const kCIPhotoEffectChrome = @"CIPhotoEffectChrome";
static NSString *const kCIPhotoEffectInstant = @"CIPhotoEffectInstant";
static NSString *const kCIPhotoEffectFade = @"CIPhotoEffectFade";

//filter parameters keys
static NSString *const kInputPower = @"inputPower";
static NSString *const kInputEV = @"inputEV";
static NSString *const kInputSaturation = @"inputSaturation";
static NSString *const kInputContrast = @"inputContrast";
static NSString *const kInputIntensity = @"inputIntensity";
static NSString *const kInputSharpness = @"inputSharpness";
static NSString *const kInputShadowAmount = @"inputShadowAmount";
static NSString *const kInputRadius = @"inputRadius";

//filters Ranges
static CGFloat kMaxDisplay = 100.0f;
static CGFloat kContrastRange = 0.25f;
static CGFloat kSaturationRange = 0.5f;
static CGFloat kBrightnessRange = 1.0f;
static CGFloat kVignetteRange = 10.0f;
static CGFloat kSharpnessRange = 25.0f;
static CGFloat kShadowRange = 1.0f;
static CGFloat kSliderLetGoRange = 1.0f;


@interface FilterView ()
//edition filters
@property (nonatomic, strong) FilterSettings *saturationSettings;
@property (nonatomic, strong) FilterSettings *brightnessSettings;
@property (nonatomic, strong) FilterSettings *vignetteSettings;
@property (nonatomic, strong) FilterSettings *sharpnessSettings;
@property (nonatomic, strong) FilterSettings *shadowSettings;
@property (nonatomic, strong) FilterSettings *contrastSettings;
@property (nonatomic, strong) NSArray *editionFiltersArray;

//filters
@property (nonatomic, strong) FilterSettings *noFilterSettings;
@property (nonatomic, strong) FilterSettings *exposureSettings;
@property (nonatomic, strong) FilterSettings *vibrantSettings;
@property (nonatomic, strong) FilterSettings *chromeSettings;
@property (nonatomic, strong) FilterSettings *instantSettings;
@property (nonatomic, strong) FilterSettings *fadeSettings;
@property (nonatomic, strong) NSArray *filtersArray;

@property (nonatomic, strong) SlidersView *sliderView;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *filterButton;
@property (nonatomic, assign) BOOL filterMode;
@property (nonatomic) NSUInteger selectedFilter;
@property (nonatomic, strong) CIImage *filteredImageThumbnail;
@property (nonatomic, strong) CIImage *inputImage;




@end


@implementation FilterView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _listLayout = [[FilterCVFL alloc] init];
        [_listLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [UICollectionView collectionViewWithLayout:_listLayout inView:self delegate:self];
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[FilterThumbnailCVCell class] forCellWithReuseIdentifier:FilterCellID];
        
        _filterButton = [UIButton new];
        _filterButton.backgroundColor = [UIColor blueColor];
        [self addSubview:_filterButton];
        
        _editButton = [UIButton new];
        _editButton.backgroundColor = [UIColor redColor];
        [self addSubview:_editButton];
        
        _sliderView = [SlidersView new];
        _sliderView.backgroundColor = [UIColor whiteColor];
        [_sliderView.slider addTarget:self action:@selector(mainSlider:) forControlEvents:UIControlEventValueChanged];
        [_sliderView.slider addTarget:self action:@selector(mainSliderLetGo:) forControlEvents:UIControlEventTouchUpInside];
        _sliderView.hidden = YES;
        
        //edition Filters
        _saturationSettings = [[FilterSettings alloc] initWithName:kCIColorControls minValue:-kSaturationRange maxValue:kSaturationRange defaultValue:1 value:_sliderView.slider.value touched:NO displayName:@"Saturation"];
        
        _brightnessSettings = [[FilterSettings alloc] initWithName:kCIExposureAdjust minValue:-kBrightnessRange maxValue:kBrightnessRange defaultValue:0 value:_sliderView.slider.value touched:NO displayName:@"Brightness"];
        
        _shadowSettings = [[FilterSettings alloc] initWithName:kCIHighlightShadowAdjust minValue:-kShadowRange maxValue:kShadowRange defaultValue:0 value:_sliderView.slider.value touched:NO displayName:@"Shadow"];
        
        _contrastSettings = [[FilterSettings alloc] initWithName:kCIColorControls minValue:-kContrastRange maxValue:kContrastRange defaultValue:1 value:_sliderView.slider.value touched:NO displayName:@"Contrast"];
        
        _vignetteSettings = [[FilterSettings alloc] initWithName:kCIVignette minValue:0 maxValue:kVignetteRange defaultValue:0 value:_sliderView.slider.value touched:NO displayName:@"Vignette"];
        
        _sharpnessSettings = [[FilterSettings alloc] initWithName:kCISharpenLuminance minValue:0 maxValue:kSharpnessRange defaultValue:0 value:_sliderView.slider.value touched:NO displayName:@"Sharpness" ];
        
        _editionFiltersArray = @[_brightnessSettings, _contrastSettings, _saturationSettings, _sharpnessSettings, _vignetteSettings, _shadowSettings];
        
        //filters
        _noFilterSettings = [[FilterSettings alloc] initWithName:kCIGammaAdjust minValue:0 maxValue:0 defaultValue:1 value:0 touched:YES displayName:@"Normal"];
        [_noFilterSettings.filter setValue:@(_noFilterSettings.defaultValue) forKey:kInputPower];
        _exposureSettings = [[FilterSettings alloc] initWithName:kCIExposureAdjust minValue:0 maxValue:0 defaultValue:1 value:0 touched:NO displayName:@"Exposure"];
        [_exposureSettings.filter setValue:@(_exposureSettings.defaultValue) forKey:kInputEV];
        _vibrantSettings = [[FilterSettings alloc] initWithName:kCIPhotoEffectTransfer minValue:0 maxValue:0 defaultValue:0 value:0 touched:NO displayName:@"Vibrant"];
        _chromeSettings = [[FilterSettings alloc] initWithName:kCIPhotoEffectChrome minValue:0 maxValue:0 defaultValue:0 value:0 touched:NO displayName:@"Chrome"];
        _instantSettings = [[FilterSettings alloc] initWithName:kCIPhotoEffectInstant minValue:0 maxValue:0 defaultValue:0 value:0 touched:NO displayName:@"Instant"];
        _fadeSettings = [[FilterSettings alloc] initWithName:kCIPhotoEffectFade minValue:0 maxValue:0 defaultValue:0 value:0 touched:NO displayName:@"Fade"];
        _filtersArray = @[_noFilterSettings, _exposureSettings, _vibrantSettings, _chromeSettings, _instantSettings, _fadeSettings];
        
        _filterMode = YES;
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = _collectionView.frame;
    frame.size = CGSizeMake(self.frame.size.width, 135);
    frame.origin.x = 0;
    frame.origin.y = 4;
    _collectionView.frame = frame;
    
    frame = _filterButton.frame;
    frame.size.height = 44;
    frame.size.width = self.frame.size.width /2;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(_collectionView.frame) + 20;
    _filterButton.frame = frame;
    
    frame = _editButton.frame;
    frame.size.height = 44;
    frame.size.width = self.frame.size.width /2;
    frame.origin.x = CGRectGetMidX(self.frame);
    frame.origin.y = CGRectGetMaxY(_collectionView.frame) + 20;
    _editButton.frame = frame;
}

#pragma CollectionView methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FilterThumbnailCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterCellID forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    CIImage *outputImage;
    
    if (_filterMode) {
        
        FilterSettings *settings = [_filtersArray objectAtIndex:row];
        cell.settings = settings;
        cell.filterType.text = settings.displayName;
        cell.editionType.text = nil;
        
        if (settings.touched) {
            cell.selectedView.hidden = NO;
            _selectedFilter = row;
        } else {
            cell.selectedView.hidden = YES;
        }
        
        switch (row) {
            case 0:
                outputImage = [self noFilter:_filteredImageThumbnail];
                break;
            case 1:
                outputImage = [self exposureAdjust:_filteredImageThumbnail];
                break;
            case 2:
                outputImage = [self toneCurveToLinear:_filteredImageThumbnail];
                break;
            case 3:
                outputImage = [self chromeEffect:_filteredImageThumbnail];
                break;
            case 4:
                outputImage = [self photoInstant:_filteredImageThumbnail];
                break;
            case 5:
                outputImage = [self fadeEffect:_filteredImageThumbnail];
                break;
            default:
                break;
        }
        
        __weak FilterThumbnailCVCell *weakCell = cell;
        
        //perfomr delegate method;
        
//        __weak ConfirmPhotoVC *weakSelf = self;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            CGImageRef cgimg = [weakSelf.context createCGImage:outputImage fromRect:[outputImage extent]];
//            UIImage *newImg = [UIImage imageWithCGImage:cgimg];
//            [weakCell.imageView setImage:newImg];
//            CGImageRelease(cgimg);
//        });
    } else {
        
        cell.imageView.image = nil;//need assets
        cell.editionType.textColor = [UIColor blackColor];
        cell.imageView.backgroundColor = [UIColor whiteColor];
        FilterSettings *settings = [_editionFiltersArray objectAtIndex:row];
        cell.settings = settings;
        cell.editionType.text = settings.displayName;
        cell.filterType.text = nil;
        if (settings.touched) {
            cell.selectedView.hidden = NO;
        } else {
            cell.selectedView.hidden = YES;
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSUInteger count;
    
    if (_filterMode) {
        count = _filtersArray.count;
    } else {
        count = _editionFiltersArray.count;
    }
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 120 + kGeomInterImageGap);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,kGeomSpaceEdge,0,kGeomSpaceEdge);
}

#pragma FilterMethods


- (void)initializingTheFiltersWithImage:(UIImage *)image {
    
    [self.delegate setTheInputImage:image];

    UIImageView *thumbnailImageView = [UIImageView new];
    thumbnailImageView.image = image;
    thumbnailImageView.frame = CGRectMake(0, 0, 70, 70);
    thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    thumbnailImageView.clipsToBounds = YES;
    UIImage *thumbnailImage = [self imageFromView:thumbnailImageView];
    _filteredImageThumbnail = [CIImage imageWithCGImage:[thumbnailImage CGImage]];
    
    _inputImage = [CIImage imageWithCGImage:[image CGImage]];
    
    [_saturationSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    
    [_noFilterSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    [_exposureSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    [_vibrantSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    [_chromeSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    [_instantSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
    [_fadeSettings.filter setValue:_inputImage forKey:kCIInputImageKey];
}



#pragma thumbnail filters

- (CIImage *)noFilter:(CIImage *)img {
    
    CIFilter *noFilter = [CIFilter filterWithName:@"CIGammaAdjust"];
    [noFilter setValue:img forKey:kCIInputImageKey];
    [noFilter setValue:@(1) forKey:@"inputPower"];
    return noFilter.outputImage;
}

- (CIImage *)exposureAdjust:(CIImage *)img {
    
    CIFilter *expoAdjust = [CIFilter filterWithName:@"CIExposureAdjust"];
    [expoAdjust setValue:img forKey:kCIInputImageKey];
    [expoAdjust setValue:@(1) forKey:@"inputEV"];
    return expoAdjust.outputImage;
}

- (CIImage *)toneCurveToLinear:(CIImage *)img {
    
    CIFilter *toneCurveToLinear = [CIFilter filterWithName:@"CIPhotoEffectTransfer"];
    [toneCurveToLinear setValue:img forKey:kCIInputImageKey];
    return toneCurveToLinear.outputImage;
}

- (CIImage *)chromeEffect:(CIImage *)img {
    
    CIFilter *chromeEffect = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    [chromeEffect setValue:img forKey:kCIInputImageKey];
    return chromeEffect.outputImage;
}

- (CIImage *)photoInstant:(CIImage *)img {
    
    CIFilter *instant =  [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    [instant setValue:img forKey:kCIInputImageKey];
    return instant.outputImage;
}

- (CIImage *)fadeEffect:(CIImage *)img {
    
    CIFilter *fadeEffect = [CIFilter filterWithName:@"CIPhotoEffectFade"];
    [fadeEffect setValue:img forKey:kCIInputImageKey];
    return fadeEffect.outputImage;
}


- (UIImage *)imageFromView:(UIView *)v {
    UIGraphicsBeginImageContextWithOptions(v.frame.size, NO, 0.0);
    //UIGraphicsBeginImageContext(v.frame.size);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}




@end
