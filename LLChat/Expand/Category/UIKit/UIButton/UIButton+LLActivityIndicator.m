
#import "UIButton+LLActivityIndicator.h"
#import <objc/runtime.h>
#import "UIView+Positioning.h"

static char kActivityIndicatorKey;
static NSString *_kButtonText;

@implementation UIButton (LLActivityIndicator)

- (UIActivityIndicatorView *)indicatorView
{
    UIActivityIndicatorView *view = objc_getAssociatedObject(self, &kActivityIndicatorKey);
    if (!view) {
        view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        objc_setAssociatedObject(self, &kActivityIndicatorKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:view];
    }
    
    view.frame = CGRectMake((self.width - 30) / 2, (self.height - 30) / 2, 30, 30);
    
    return view;
}

- (void)startAnimating
{
    _kButtonText = self.titleLabel.text;
    [self setTitle:nil forState:UIControlStateNormal];
    [self.indicatorView startAnimating];
}

- (void)stopAnimating
{
    [self.indicatorView stopAnimating];
    [self setTitle:_kButtonText forState:UIControlStateNormal];
}

@end
