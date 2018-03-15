//
//  BasicDefinition.h
//  基础宏定义

#ifndef BasicDefinition_h
#define BasicDefinition_h


// 1.屏幕尺寸大小
#define SCREEN_BOUNDS      ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH       ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT      ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE       ([[UIScreen mainScreen] scale])

// 2. 手机机型
#define IS_IPHONE_4_OR_LESS  (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH  < 568.0)
#define IS_IPHONE_5          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P         (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X          (MH_IS_IPHONE && MH_SCREEN_MAX_LENGTH == 812.0)

/// 导航条高度
#define KAPPLICATION_TOP_BAR_HEIGHT (IS_IPHONE_X ? 88.0f : 64.0f)
/// tabBar高度
#define KAPPLICATION_TAB_BAR_HEIGHT (IS_IPHONE_X ? 83.0f : 49.0f)
/// 工具条高度 (常见的高度)
#define KAPPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define KAPPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define KAPPLICATION_STATUS_BAR_HEIGHT (MH_IS_IPHONE_X ? 44 : 20.0f)

// 3. 系统版本/设备
#define KSYSTEMVERSION       ([[UIDevice currentDevice].systemVersion floatValue])

#define KSYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define KSYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define KSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define KSYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define KSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)//判断是否为iPhone
#define IS_IPAD   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)//判断是否为iPad
#define IS_IPOD   ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])//判断是否为ipod

// 4. 手机UUID
#define IPHONE_UUID           ([[UIDevice currentDevice].identifierForVendor UUIDString])

// 5. 设置字体
#define SYSTEMFONT(a)           ([UIFont systemFontOfSize:a])
#define SYSTEMBOLDFONT(a)       ([UIFont boldSystemFontOfSize:a])

// 6. 设置颜色
#define KCOLOR(r,g,b,a)            ([UIColor colorWithRed:((r)/255.0f) green:((g)/255.0f) blue:((b)/255.0f) alpha:(a)])
#define KRANDOMCOLOR               ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0])
#define KHEXCOLOR(hex)             [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
#define KHEXCOLORAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


// 7. 日志输出
#ifdef DEBUG
#define KLOG(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else
#define KLOG(...)
#endif

#define ALERT(msg) UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alert show];

// 8. 弱引用、强引用
#define DECLARE_WEAK_SELF __typeof(&*self) __weak weakSelf = self;
#define DECLARE_STRONG_SELF __typeof(&*self) __strong strongSelf = weakSelf;


// 9. 线程安全
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

// 10.设置圆角
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// 11.由角度转换弧度 由弧度转换角度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian * 180.0)/(M_PI)


// 12. 获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

// 13.获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// 14.使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

//15.判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

// 16.沙盒目录文件
#define kPathTemp NSTemporaryDirectory()//获取temp
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]//获取沙盒 Document
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] //获取沙盒 Cache

// 17.时间
#define KDATEFORMATDEFAULT  @"yyyy-MM-dd HH:mm:ss"
#define KDATEFORMAT_yMdHm   @"yy-MM-dd HH:mm"
#define KDATEFORMAT_yMdHm   @"yyyy-MM-dd HH:mm"
#define KDATEFORMAT_yMd     @"yyyy-MM-dd"
#define KDATEFORMAT_MdHms   @"MM-dd HH:mm:ss"
#define KDATEFORMAT_MdHm    @"MM-dd HH:mm"
#define KDATEFORMAT_Hms     @"HH:mm:ss"
#define KDATEFORMAT_Hm      @"HH:mm"
#define KDATEFORMAT_Md      @"MM-dd"
#define KDATEFORMAT_yMd     @"yy-MM-dd"


// 18.应用版本信息
#define KAPP_VERSION       ([[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"])
#define KAPP_BUILD         ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define KAPP_NAME          ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])

// 19.国际化
#define LOCAL_STRING(x) NSLocalizedString(x, nil)

// String安全性
#define kUnnullString(parameter)    ((parameter).length ? (parameter) : @"")

//屏幕适配参数(参照iPhone6屏幕尺寸)
#define kScreenHeightRatio       (kScreen_height / 667)
#define kScreenWidthRatio        (kScreen_width / 375)
#define kAdaptedWidthValue(x)    (x * kScreenWidthRatio)
#define kAdaptedHeightValue(y)   (y * kScreenHeightRatio)
#define kAdaptedSystemFontSize(R) (iPhonePlus ? kSysFont(R * 1.1) : kSysFont(R))

#endif /* BasicDefinition_h */
