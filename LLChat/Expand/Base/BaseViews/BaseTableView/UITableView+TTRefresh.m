//
//  UITableView+TTRefresh.m
//  YDTicketTong
//
//  Created by alex on 17/3/2.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "UITableView+TTRefresh.h"
#import "TTRefreshHeader.h"
#import "TTRefreshFooter.h"

static NSString *const kRefreshKey = @"kRefreshKey";
static NSString *const kRefreshTypeKey = @"kRefreshTypeKey";
static NSString *const kRefreshState = @"kRefreshState";

@implementation UITableView (TTRefresh)  @dynamic headerRefresh, footerRefresh;

- (void)openFooterRefresh {
    
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [TTRefreshFooter ttFooterWithRefreshBlock:^{
        [weakSelf setRefreshType:TTRefreshTypeLoadMore];
        !weakSelf.footerRefresh ? : weakSelf.footerRefresh();
    }];
}

- (void)endRefreshWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)setRefreshType:(TTRefreshType)refreshType {
    objc_setAssociatedObject(self, &kRefreshTypeKey, @(refreshType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (TTRefreshType)refreshType {
    return [objc_getAssociatedObject(self, &kRefreshTypeKey) integerValue];
}

- (void)openHeaderRefresh {
    __weak typeof(self) weakSelf = self;
    self.mj_header = [TTRefreshHeader ttHeaderWithRefreshBlock:^{
        
        weakSelf.mj_footer.state = MJRefreshStateIdle;
        [weakSelf setRefreshType:TTRefreshTypeReload];
        !weakSelf.headerRefresh ? : weakSelf.headerRefresh();
    }];
}

- (void)beginHeaderRefresh {
    [self.mj_header beginRefreshing];
}

- (void)beginFooterRefresh {
    [self.mj_footer beginRefreshing];
}

- (void)endRefresh {
    ![self.mj_header isRefreshing] ? : [self.mj_header endRefreshing];
    ![self.mj_footer isRefreshing] ? : [self.mj_footer endRefreshing];
}

@end
