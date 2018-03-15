//
//  TTAdvertiseView.m
//  TTAdvertiseView
//
//  Created by alex on 17/4/10.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "TTAdvertiseView.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight  ([UIScreen mainScreen].bounds.size.height)

@interface TTAdvertiseView () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <NSString *>*URLStringArray;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, strong) UILabel *countdownLabel;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TTAdvertiseView {
    NSInteger _currentPage;
}

#pragma mark - initialize M

+ (instancetype)showWithImage:(UIImage *)placeholderImage countdown:(NSInteger)countdown
{
    TTAdvertiseView *advertiseView = [[TTAdvertiseView alloc] initWithImage:placeholderImage];
    advertiseView.countdown = countdown;
   
    //开启定时器
    [advertiseView.timer fire];
    
    return advertiseView;
}

- (instancetype)initWithImage:(UIImage *)placeholderImage
{
    if (self = [super init]) {
        _placeholderImage = placeholderImage;
        [self _layoutUI];
    }
    return self;
}

- (void)_layoutUI
{
  
    UIView *view = [[UIApplication sharedApplication].delegate window].rootViewController.view;
    if (!view) return;
    
    self.frame = view.frame;
    [view addSubview:self];
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[TTAdvertiseCell class] forCellWithReuseIdentifier:[TTAdvertiseCell description]];
    [self.collectionView reloadData];
}

- (void)dealloc
{
    [self removeTimer];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - Public M

- (void)updateWithURLStringArray:(NSArray<NSString *> *)URLStringArray countdown:(NSInteger)countdown
{
    self.URLStringArray = URLStringArray;
    self.countdown = countdown;
    [self.collectionView reloadData];
    //显示倒计时label
    self.countdownLabel.text = [NSString stringWithFormat:@"剩余 %ld s", _countdown];
    self.countdownLabel.hidden = NO;
}


#pragma mark - Private M

- (void)hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.URLStringArray.count == 0 ? 1 : self.URLStringArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTAdvertiseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TTAdvertiseCell description] forIndexPath:indexPath];
    cell.ttImageView.image = self.placeholderImage;
    
    if (self.URLStringArray.count) {
        NSString *urlString = self.URLStringArray[indexPath.item];
        [cell.ttImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:self.placeholderImage];
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemClickedBlock) {
        self.itemClickedBlock(indexPath);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark  - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView != self.collectionView) return;
    
    CGPoint offSet = scrollView.contentOffset;
    _currentPage = offSet.x / self.bounds.size.width;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView != self.collectionView) return;
    
    CGPoint offSet = scrollView.contentOffset;
    if(offSet.x < _currentPage * self.bounds.size.width) {
        [scrollView scrollRectToVisible:CGRectMake(_currentPage * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height) animated:NO];
    }
}

#pragma mark - Events

- (void)timerEvents:(NSTimer *)timer {

    if (_countdown == 0) {
        [self hidden];
        return;
    }
    _countdown--;
    self.countdownLabel.text = [NSString stringWithFormat:@"剩余 %ld s", _countdown];
   
}


#pragma mark - Getter M

- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerEvents:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0f;
        layout.minimumInteritemSpacing = 0.0f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO; //关闭缓冲效果
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (UILabel *)countdownLabel {
    
    if (!_countdownLabel) {
        _countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80, 30, 60, 25)];
        _countdownLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _countdownLabel.textColor = [UIColor whiteColor];
        _countdownLabel.font = [UIFont systemFontOfSize:14];
        _countdownLabel.textAlignment = NSTextAlignmentCenter;
        //初始化的时候隐藏
        _countdownLabel.hidden = YES;
        [self addSubview:_countdownLabel];
    }
    return _countdownLabel;
}

@end


@implementation TTAdvertiseCell

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
    _ttImageView.contentMode = UIViewContentModeScaleAspectFill;
    _ttImageView.clipsToBounds = YES;
    [self.contentView addSubview:_ttImageView];
}

@end
