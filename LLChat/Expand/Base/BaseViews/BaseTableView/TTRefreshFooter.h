//
//  TTRefreshFooter.h
//  YDTicketTong
//
//  Created by alex on 17/1/22.
//  Copyright © 2017年 alex. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface TTRefreshFooter : MJRefreshBackNormalFooter

+ (instancetype)ttFooterWithRefreshBlock:(MJRefreshComponentRefreshingBlock)block;

@end
