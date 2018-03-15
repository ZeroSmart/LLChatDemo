//
//  BaseTableView.h
//  Countries
//
//  Created by alex on 17/4/12.
//  Copyright © 2017年 DZN Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BaseDataStatus) {

    BaseDataStatusDefault     = 0, //正常,如正在进行网络请求的时候
    BaseDataStatusEmpty       = 1, //无数据
    BaseDataStatusUnNetwork   = 2, //无网络
    BaseDataStatusFailure     = 3, //请求失败
};

typedef void(^TappedBlock)(void);

@interface BaseTableView : UITableView

/**
  数据请求失败的时候，需要调用该接口reloadData一下！

 @param errCode 错误码
 @param errMsg 错误信息
 */
- (void)reloadErrorData:(NSInteger)errCode
                 errMsg:(NSString *)errMsg;

@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, copy) TappedBlock tappedBlock;

@end


///----------------------
/// @name 空视图元素
///----------------------

@interface TTEmptyItem : NSObject

@property (nonatomic, copy) NSString  *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString  *descriptionTitle;

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, copy) NSString  *buttonTitle;


/**
 初始化方法

 @param title 文字提示 如 当前无订单，网络错误
 @param descriptionTitle 详细描述文字
 @param image 描述文字的直观图片
 @param buttonTitle 按钮文字
 @param buttonImage 按钮图片
 @return
 
 */
- (instancetype)initWithTitle:(NSString *)title
             descriptionTitle:(NSString *)descriptionTitle
                        image:(UIImage *)image
                  buttonTitle:(NSString *)buttonTitle
                  buttonImage:(UIImage *)buttonImage;

@end
