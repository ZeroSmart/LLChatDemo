//
//  NSDate+Additions.h
//  YunDiTrip
//
//  Created by yyl on 16/4/7.
//  Copyright © 2016年 shenzhen yundi technology co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/********************** time ****************************/

#pragma mark - 时间格式
#define kDateFormatDefault     @"yyyy-MM-dd HH:mm:ss"
#define kDateFormat_yyMdHm     @"yy-MM-dd HH:mm"
#define kDateFormat_yyyyMdHm   @"yyyy-MM-dd HH:mm"
#define kDateFormat_yMd        @"yyyy-MM-dd"
#define kDateFormat_MdHms      @"MM-dd HH:mm:ss"
#define kDateFormat_MdHm       @"MM-dd HH:mm"
#define kDateFormat_MdHm1      @"MM/dd HH:mm"
#define kDateFormatTime        @"HH:mm:ss"
#define kDateFormat_Hm         @"HH:mm"
#define kDateFormat_ms         @"mm:ss"
#define kDateFormat_Md         @"MM-dd"
#define kDateFormat_M_d_       @"MM月dd日"
#define kDateFormat_yyMd       @"yy-MM-dd"
#define kDateFormat_YYMMdd     @"yyyyMMdd"
#define kDateFormat_yyyyMdHms  @"yyyyMMddHHmmss"
#define kDateFormat_yyyyMMddHHmmssSSS   @"yyyy-MM-dd HH:mm:ss.SSS"
#define kDateFormat_yyyyMdHm_ForPoint   @"yyyy.MM.dd HH:mm"
#define kDateFormat_yyyyMMddHHmm        @"yyyy/MM/dd HH:mm"
#define KDateFormat_yyyy @"yyyy"
#define kDateFormat_M_dHm @"MM月dd HH:mm"
#define kDateFormat_MdE @"MM-dd EE"
#define kDateFormat_E_Md @"EE HH:mm"
#define kDateFormat_M_yyyy @"MM'月 'yyyy"
#define kDateFormat_yMd_Hm_E @"yyyy年MM月dd HH:mm EE"


/********************** time ****************************/

static NSString * const FORMAT_PAST_SHORT = @"yyyy/MM/dd";
static NSString * const FORMAT_PAST_TIME = @"ahh:mm";
static NSString * const FORMAT_THIS_WEEK = @"eee ahh:mm";
static NSString * const FORMAT_THIS_WEEK_SHORT = @"eee";
static NSString * const FORMAT_YESTERDAY = @"ahh:mm";
static NSString * const FORMAT_TODAY = @"ahh:mm";

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (Additions)


/**
 *  将时间戳转换成日期格式
 *
 *  @param timeInterval
 *
 *  @return
 */
+ (NSDate *)dateFromInterval:(NSTimeInterval)timeInterval;

/**
 *  将时间戳转换成字符串日期格式  yyyy-MM-dd HH:mm:ss
 *
 *  @param timeInterval
 *
 *  @return
 */
+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval;

/**
 *  将时间戳转换成 指定字符串日期格式
 *
 *  @param timeInterval
 *
 *  @return
 */
+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval withFormat:(NSString*)format;

/**
 *  将日期转换成指定格式的字符串
 *
 *  @param date
 *  @param format
 *
 *  @return
 */
+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString*)format;

/**
 *  将制定格式的字符串转换成时间
 *
 *  @param str
 *  @param format
 *
 *  @return
 */

+ (NSDate *)dateFromStr:(NSString *)str withFormat:(NSString*)format;

/**
 *  得到制定日期的前一天 或后一天
 *
 *  @param spaceDay +1: 后一天  -1: 前一天
 *
 *  @return
 */
- (NSDate *)dateNextDay:(NSInteger)spaceDay;


/**
 *  将日期格式化成   2016-04-19(今天, 昨天, 明天)
 *
 *  @param components
 *
 *  @return
 */
+ (NSString *)formatYTTWithDateComponents:(NSDateComponents *)components;

+ (NSString *)formatYTTWithDate:(NSDate *)date;

/**
 *  返回整数秒时间戳
 *
 *  @return
 */
- (long long)longlongTimeIntervalSince1970;

/**
 *  bob 的方法
 *
 */
+ (NSString *)formatTimerCount:(NSInteger)timerCount;
+ (NSString *)timeFormat:(NSInteger)waitTime;


/// 将当前时间显示格式（2016-07-19 12：00）的时间字符串，转成since1970的时间戳
+ (NSString *)timeStampSince1970WithDefalutFormatTimeString:(NSString *)timeString;


//日期转化时间戳
+ (NSString *)timeStampSince1970WithString:(NSString *)timeString withFormat:(NSString*)format;


/**
 *  获得date当前月的第一天是星期几
 *
 *  @return
 */
- (NSInteger)weekdayOfFirstDayInDate;


/**
 *  将日期格式化成 yyyy-MM-dd 00:00:00日期
 *
 *  @return
 */
- (NSDate *)dateFormatYMD000000;

/**
 *  将日期格式化成 yyyy-MM-dd 23:59:59日期
 *
 *  @return
 */
- (NSDate *)dateFormatYMD235959;

/**
 *  将两个如期转换成 yyyy-MM-dd 比较大小
 *
 *  @param date1
 *  @param date2
 *
 *  @return  1: date1>date2  0:date1=date2 -1:date1<date2
 */
+ (NSInteger)compareWithDate1:(NSDate *)date1 date2:(NSDate *)date2;

//****************************************************** NSDate (Extension)


/**
 * 获取日、月、年、小时、分钟、秒
 */
- (NSUInteger)day;
- (NSUInteger)month;
- (NSUInteger)year;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;
+ (NSUInteger)day:(NSDate *)date;
+ (NSUInteger)month:(NSDate *)date;
+ (NSUInteger)year:(NSDate *)date;
+ (NSUInteger)hour:(NSDate *)date;
+ (NSUInteger)minute:(NSDate *)date;
+ (NSUInteger)second:(NSDate *)date;

/**
 * 获取一年中的总天数
 */
- (NSUInteger)daysInYear;
+ (NSUInteger)daysInYear:(NSDate *)date;

/**
 * 判断是否是润年
 * @return YES表示润年，NO表示平年
 */
- (BOOL)isLeapYear;
+ (BOOL)isLeapYear:(NSDate *)date;

/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)weekOfYear;
+ (NSUInteger)weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)formatYMD;
+ (NSString *)formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)weeksOfMonth;
+ (NSUInteger)weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)begindayOfMonth;
+ (NSDate *)begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)lastdayOfMonth;
+ (NSDate *)lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)dateAfterDay:(NSUInteger)day;
+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)dateAfterMonth:(NSUInteger)month;
+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)offsetYears:(int)numYears;
+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)offsetMonths:(int)numMonths;
+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)offsetDays:(int)numDays;
+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)offsetHours:(int)hours;
+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate;


/**
 * 返回second小时后的日期
 */
- (NSDate *)offsetSeconds:(int)second;
+ (NSDate *)offsetSeconds:(int)second fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)daysAgo;
+ (NSUInteger)daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)weekday;
+ (NSInteger)weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)dayFromWeekday;
+ (NSString *)dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)isSameDay:(NSDate *)anotherDate;

/**
 *  是否是今天
 *
 *  @return Return if self is today
 */
- (BOOL)isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isThisWeek;
/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format;

/**
 * 获取指定月份的天数
 */
- (NSUInteger)daysInMonth:(NSUInteger)month;
+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)daysInMonth;
+ (NSUInteger)daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)timeInfo;
+ (NSString *)timeInfoWithDate:(NSDate *)date;
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ymdFormat;
- (NSString *)hmsFormat;
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdFormat;
+ (NSString *)hmsFormat;
+ (NSString *)ymdHmsFormat;

/**
 * abner 获取今天开始到 N 天以后  之间的天数信息   指定格式化时间格式
 */
+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number withFormatter:(NSString *)formatter;

/**
 * abner 获取今天开始到 N 天以后  之间的天数信息
 */
+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number;

/**
 * abner 获取今天开始到 N 天以后的时间 结束时间以 N 天以后的哪个小时为准例如:@:"10"
 */
+(NSString *)getTimeWithNumberDaysLater:(NSUInteger)datys andEndHourTime:(NSString *)endTime;

/**
 * abner 获取以某天时间(字符串格式的时间)以后的哪个小时为准例如:@:"10"
 */
+(NSDate *)getTimeWithDateString:(NSString *)dateString andEndHourTime:(NSString *)endTime;

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 *  根据unitFlags类型 获取两个日期之间的 天数 或 小时 或 分 或 秒
 *
 *  @param fromDate
 *  @param toDate
 *  @param unitFlags
 *
 *  @return
 */
+ (NSDateComponents *)numWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate unitFlags:(NSCalendarUnit)unitFlags;


/**
 * @method
 *
 * @brief 获取两个日期之间的月数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfMonthsWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// 获取年的差值
+ (NSDateComponents *)dateComponentsYearsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// 获取日、时、分的差值
+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// 获取日、时、分、秒的差值
+ (NSDateComponents *)dateComponentsUntilSecondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/// 获取两个时间相距的秒数
+ (NSInteger)secondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

// 获取两个时间相距的小时
+ (NSInteger)numberOfHourWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 *  将一个日期的年月日 和 名一个日期的时分秒 拼接成一个新的日期
 *
 *  @param yDate
 *  @param hDate
 *
 *  @return
 */
+ (NSDate *)dateFormateWithYDate:(NSDate *)yDate hDate:(NSDate *)hDate;


// 0.25 h ---> 15 分钟
+ (NSString *)hourMinuteDateFromHour:(NSString *)hour;


@end
