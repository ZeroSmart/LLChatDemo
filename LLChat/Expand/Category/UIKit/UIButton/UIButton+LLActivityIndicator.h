

#import <UIKit/UIKit.h>

@interface UIButton (LLActivityIndicator)

@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;

- (void)startAnimating;

- (void)stopAnimating;

@end
