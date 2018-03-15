//
//  TTAdvertiseView.h
//  TTAdvertiseView
//
//  Created by alex on 17/4/10.
//  Copyright © 2017年 alex. All rights reserved.
/**
    使用场景，启动页面之后的广告页从后台获取
 */

#import <UIKit/UIKit.h>

typedef void(^ItemClickedBlock)(NSIndexPath *indexPath);

@interface TTAdvertiseView : UIView

/**
 *  点击事件回调block
 */
@property (nonatomic, copy) ItemClickedBlock itemClickedBlock;

/**
 网络请求图片之前调用该方法,将页面添加到rootViewController.view上
 @param placeholderImage 占位图片,一般跟启动图片保持一致，将网络请求的时间转移到启动时间上
 @param countdown 倒计时，倒计时完成之前都未调用@selector(updateWithURLStringArray)，则页面消失
 @return 返回view
 */

+ (instancetype)showWithImage:(UIImage *)placeholderImage
                    countdown:(NSInteger)countdown;


/**
 更新数据
 @param URLStringArray 图片Url数组
 @Param countdown 图片显示倒计时
 */
- (void)updateWithURLStringArray:(NSArray <NSString *>*)URLStringArray
                       countdown:(NSInteger)countdown;


@end

@interface TTAdvertiseCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *ttImageView;



@end
