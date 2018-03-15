//
//  UITableView+TTRefresh.h
//  YDTicketTong
//
//  Created by alex on 17/3/2.
//  Copyright © 2017年 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

typedef NS_ENUM(NSInteger, TTRefreshType) {
    TTRefreshTypeReload,   //刷新数据
    TTRefreshTypeLoadMore, //加载更多
};

typedef void(^HeaderRefresh)(void);
typedef void(^FooterRefresh)(void);

@interface UITableView (TTRefresh)

- (void)openHeaderRefresh;
- (void)openFooterRefresh;
- (void)endRefresh;
- (void)beginHeaderRefresh;
- (void)beginFooterRefresh;
- (void)endRefreshWithNoMoreData;


/// 请求数据的状态，
@property (nonatomic, assign) TTRefreshType    refreshType;

@property (nonatomic, copy)HeaderRefresh headerRefresh;
@property (nonatomic, copy)FooterRefresh footerRefresh;


@end
