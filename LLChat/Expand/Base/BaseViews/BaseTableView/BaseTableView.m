//
//  BaseTableView.m
//  Countries
//
//  Created by alex on 17/4/12.
//  Copyright © 2017年 DZN Labs. All rights reserved.
//

#import "BaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"


@interface BaseTableView () <EmptyDataSetSource, EmptyDataSetDelegate>

/**
 各类空视图对象
 */
@property (nonatomic, strong) NSDictionary <NSNumber *, TTEmptyItem *> *emptyItems;
/**
 数据状态
 */
@property (nonatomic, assign) BaseDataStatus dataStatus;

@end

@implementation BaseTableView

#pragma mark - Initlialize M

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.isLoading = NO;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

#pragma mark - Public M

- (void)reloadErrorData:(NSInteger)errCode errMsg:(NSString *)errMsg {
    
    self.isLoading = NO;
    
    if (errCode == 1) {
        self.dataStatus = BaseDataStatusUnNetwork;
        [self reloadData];
    }else if (errCode == 2) {
        self.dataStatus = BaseDataStatusFailure;
        [self reloadData];
    }else {
        [self reloadData];
    }
}

- (void)setIsLoading:(BOOL)isLoading {

    if (_isLoading != isLoading) {
        _isLoading = isLoading;
        
        if (_isLoading) {
            self.dataStatus = BaseDataStatusDefault;
            [self reloadData];
        }
    }
}


#pragma mark - DZNEmptyDataSetSource

- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = [self.emptyItems objectForKey:@(self.dataStatus)].title;
    if (!title) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:title];
}

- (nullable NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *descriptionTitle = [self.emptyItems objectForKey:@(self.dataStatus)].descriptionTitle;
    if (!descriptionTitle) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:descriptionTitle];
}

- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [self.emptyItems objectForKey:@(self.dataStatus)].image;
}

- (nullable UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *buttonTitle = [self.emptyItems objectForKey:@(self.dataStatus)].buttonTitle;
    if (!buttonTitle) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:buttonTitle];
}

- (nullable UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return [self.emptyItems objectForKey:@(self.dataStatus)].buttonImage;
}

- (nullable UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldBeForcedToDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}


- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    !self.tappedBlock ? : self.tappedBlock();
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    
}

- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView {
    
}


- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView {

}

- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView {

}


#pragma mark - Getter M


- (NSDictionary <NSNumber *, TTEmptyItem *> *)emptyItems
{
    return @{
             
             @(BaseDataStatusDefault) : [[TTEmptyItem alloc] initWithTitle:nil
                                                          descriptionTitle:nil
                                                                     image:nil
                                                               buttonTitle:nil
                                                               buttonImage:nil],
             
             @(BaseDataStatusEmpty)   : [[TTEmptyItem alloc] initWithTitle:@"当前无信息"
                                                          descriptionTitle:nil
                                                                     image:nil
                                                               buttonTitle:nil
                                                               buttonImage:nil],
             
             @(BaseDataStatusFailure) : [[TTEmptyItem alloc] initWithTitle:@"请求失败，点击重试"
                                                          descriptionTitle:nil
                                                                     image:nil
                                                               buttonTitle:nil
                                                               buttonImage:nil],
             
             @(BaseDataStatusUnNetwork) : [[TTEmptyItem alloc] initWithTitle:@"请检查网路连接"
                                                            descriptionTitle:nil
                                                                       image:nil
                                                                 buttonTitle:nil
                                                                 buttonImage:nil],
             };
}

@end


@implementation TTEmptyItem

- (instancetype)initWithTitle:(NSString *)title
             descriptionTitle:(NSString *)descriptionTitle
                        image:(UIImage *)image
                  buttonTitle:(NSString *)buttonTitle
                  buttonImage:(UIImage *)buttonImage
{
    if (self = [super init]) {
        self.title = title;
        self.image = image;
        self.descriptionTitle = descriptionTitle;
        self.buttonTitle = buttonTitle;
        self.buttonImage = buttonImage;
    }
    return self;
}

@end
