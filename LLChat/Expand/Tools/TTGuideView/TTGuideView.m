//
//  TTGuideView.m
//  Example
//
//  Created by alex on 17/3/31.
//  Copyright © 2017年 com.ayundi. All rights reserved.
//

#import "TTGuideView.h"

#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH  (SCREEN_BOUNDS.size.width)
#define SCREEN_HEIGHT (SCREEN_BOUNDS.size.height)

static NSString *kAppVersion = @"tt_appVersion";

@interface TTGuideView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray          *images;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger       currentPage;
@property (nonatomic, strong) UIPageControl    *pageControl;

@end

@implementation TTGuideView

#pragma mark - Public Class M

+ (instancetype)showGuideViewWithImageArray:(NSArray<NSString *> *)imageNames {

    NSMutableArray *images = [NSMutableArray array];
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:imageName];
        !image ? : [images addObject:image];
    }
    TTGuideView *guideView = [[TTGuideView alloc] initWithImages:images];
    return guideView;
}


#pragma mark - Life M

- (void)dealloc {

    [self _unregisterForKVO];
}

#pragma mark - Private M

- (instancetype)initWithImages:(NSArray *)images {
    
    self = [super init];
    if (self) {
        self.images = images;
        [self _layoutUI];
        [self _registerForKVO];
    }
    return self;
}

- (void)_layoutUI {
 
    if ([self isFirstLaunch]) {
        
        UIView *view = [[UIApplication sharedApplication].delegate window].rootViewController.view;
        if (!view) return;
        
        self.frame = view.frame;
        [view addSubview:self];
        [self addSubview:self.collectionView];
        [self.collectionView reloadData];
        
        [self addSubview:self.pageControl];
        self.offsetY = 50;
        self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
        self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
        
        self.pageIndicatorTintColor = [UIColor grayColor];
        self.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.numberOfPages = self.images.count;
        
    } else {
        [self removeFromSuperview];
    }
}


- (BOOL)isFirstLaunch {

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDict[@"CFBundleShortVersionString"];
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    if (!version || ![currentVersion isEqualToString:version]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    return NO;
}

- (void)hiddenGuideView {

    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - KVO


- (void)_registerForKVO {
    
    for (NSString *keyPath in [self observerPaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"pageControlHidden"]) {
        self.pageControl.hidden = self.pageControlHidden;
    }else if ([keyPath isEqualToString:@"pageIndicatorTintColor"]) {
        self.pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    }else if ([keyPath isEqualToString:@"currentPageIndicatorTintColor"]) {
        self.pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    }else if ([keyPath isEqualToString:@"offsetY"]) {
        self.pageControl.frame = CGRectMake(0, self.bounds.size.height - _offsetY + 30, self.bounds.size.width, 30);
    }
}

- (void)_unregisterForKVO {
    
    for (NSString *keyPath in [self observerPaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observerPaths {
    
    return @[
             @"pageControlHidden",
             @"pageIndicatorTintColor",
             @"currentPageIndicatorTintColor",
             @"offsetY"
             ];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TTGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TTGuideCell description] forIndexPath:indexPath];
    cell.ttImageView.image = self.images[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 不是最后一页，默认不响应
    if (indexPath.item != self.images.count - 1) return;
    // 点击最后一页，跳转进应用
    [self hiddenGuideView];
}

#pragma mark - UIScrollView

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if (scrollView != self.collectionView) return;
    
    CGPoint offSet = scrollView.contentOffset;
    _currentPage = offSet.x / self.bounds.size.width;
    self.pageControl.currentPage = _currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView != self.collectionView) return;
    
    CGPoint offSet = scrollView.contentOffset;
    if(offSet.x < _currentPage * self.bounds.size.width) {
        [scrollView scrollRectToVisible:CGRectMake(_currentPage * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
    }
}

#pragma mark - Getter M

- (UICollectionView *)collectionView {

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0f;
        layout.minimumInteritemSpacing = 0.0f;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[TTGuideCell class] forCellWithReuseIdentifier:[TTGuideCell description]];
        
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {

    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 50, self.bounds.size.width, 30)];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}


@end


@implementation TTGuideCell

- (instancetype) initWithFrame:(CGRect)frame {

    if (frame.size.width == 0 && frame.size.height == 0) {
        frame = self.bounds;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self _layoutCell];
    }
    return self;
}

- (void)_layoutCell {

    _ttImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:_ttImageView];
}

@end

