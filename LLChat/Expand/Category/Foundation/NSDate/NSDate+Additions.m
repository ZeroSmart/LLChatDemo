//
//  NSDate+Additions.m
//  YunDiTrip
//
//  Created by yyl on 16/4/7.
//  Copyright © 2016年 shenzhen yundi technology co.,Ltd. All rights reserved.
//

#import "NSDate+Additions.h"
#import <UIKit/UIKit.h>

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth|  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (Additions)

+ (NSDate *)dateFromInterval:(NSTimeInterval)timeInterval {
    if (timeInterval <= 0) {
        return [NSDate date];
    } else {
        return [NSDate dateWithTimeIntervalSince1970:timeInterval];
    }
}

+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval {
    
    NSDate *date = [NSDate dateFromInterval:timeInterval];
    
    return [NSDate formatDate:date withFormat:kDateFormat_yyMdHm];
}

+ (NSString *)dateStrFromInterval:(NSTimeInterval)timeInterval withFormat:(NSString *)format {
    
    NSDate *date = [NSDate dateFromInterval:timeInterval];
    
    return [NSDate formatDate:date withFormat:format];
}

+ (NSString *)formatDate:(NSDate *)date withFormat:(NSString*)format {
    if (date) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        NSString *currentDateStr = [dateFormatter stringFromDate:date];
        return currentDateStr;
    } else {
        return nil;
    }
}

+ (NSDate *)dateFromStr:(NSString *)str withFormat:(NSString*)format { 
    if (str.length <= 0) {
        return [NSDate date];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        NSDate *currentDate = [dateFormatter dateFromString:str];
        return currentDate;
    }
}

- (NSDate *)dateNextDay:(NSInteger)spaceDay {
    NSDate *newDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([self timeIntervalSinceReferenceDate] + spaceDay * 24*3600)];
    return newDate;
}


+ (NSString *)formatYTTWithDateComponents:(NSDateComponents *)components {
    
    if (!components) {
        //默认为当前时间
        //components = [[NSDateComponents alloc] init];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        components = [calendar components:unitFlags fromDate:[NSDate date]];
    }
    
    NSString *yyt = @"";
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    NSDate *yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    
    NSString * dateString = [NSString stringWithFormat:@"%04ld-%02ld-%02ld", (long)components.year, (long)components.month, (long)components.day];
    
    if ([dateString isEqualToString:todayString]) {
        yyt = @"(今天)";
    } else if ([dateString isEqualToString:yesterdayString]) {
        yyt = @"(昨天)";
    }else if ([dateString isEqualToString:tomorrowString]) {
        yyt = @"(明天)";
    }
    
    NSString *dateStr = [NSString stringWithFormat:@"%04ld-%02ld-%02ld%@", (long)components.year, (long)components.month, (long)components.day, yyt];
    return dateStr;
}

+ (NSString *)formatYTTWithDate:(NSDate *)date {
 
//    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    return [NSDate formatYTTWithDateComponents:components];
    
}

- (long long)longlongTimeIntervalSince1970 {
    NSTimeInterval time = [self timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型 
    return dTime;
}

 
+ (NSString *)formatTimerCount:(NSInteger)timerCount {
    NSString *result;
    
    if (timerCount < 10) {
        return [NSString stringWithFormat:@"00:0%zd", timerCount];
        
    }else if (timerCount >= 10 && timerCount < 60) {
        return [NSString stringWithFormat:@"00:%zd", timerCount];
        
    }else if (timerCount >= 60 && timerCount < 600) {
        NSInteger timerCountLeft = timerCount % 60;
        NSInteger timerMinute = timerCount / 60;
        if (timerCountLeft < 10) {
            return [NSString stringWithFormat:@"0%zd:0%zd", timerMinute, timerCountLeft];
        }
        
        return [NSString stringWithFormat:@"0%zd:%zd", timerMinute,timerCountLeft];
    }else {
        //超过10分钟了
        return @"10:00";
    }
    
    return result;
}

+ (NSString *)timeFormat:(NSInteger)waitTime {
    NSString *time = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)waitTime/60,(long)waitTime%60];
    return time;
}




//****************************************************** NSDate (Extension)
- (NSUInteger)day {
    return [NSDate day:self];
}

- (NSUInteger)month {
    return [NSDate month:self];
}

- (NSUInteger)year {
    return [NSDate year:self];
}

- (NSUInteger)hour {
    return [NSDate hour:self];
}

- (NSUInteger)minute {
    return [NSDate minute:self];
}

- (NSUInteger)second {
    return [NSDate second:self];
}

+ (NSUInteger)day:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#endif
    return [dayComponents day];
}

+ (NSUInteger)month:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)year:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)hour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)minute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)second:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)daysInYear {
    return [NSDate daysInYear:self];
}

+ (NSUInteger)daysInYear:(NSDate *)date {
    return [self isLeapYear:date] ? 366 : 365;
}

- (BOOL)isLeapYear {
    return [NSDate isLeapYear:self];
}

+ (BOOL)isLeapYear:(NSDate *)date {
    NSUInteger year = [date year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)formatYMD {
    return [NSDate formatYMD:self];
}

+ (NSString *)formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)[date year],(unsigned long)[date month], (unsigned long)[date day]];
}

- (NSUInteger)weeksOfMonth {
    return [NSDate weeksOfMonth:self];
}

+ (NSUInteger)weeksOfMonth:(NSDate *)date {
    return [[date lastdayOfMonth] weekOfYear] - [[date begindayOfMonth] weekOfYear] + 1;
}

- (NSUInteger)weekOfYear {
    return [NSDate weekOfYear:self];
}

+ (NSUInteger)weekOfYear:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date year];
    
    NSDate *lastdate = [date lastdayOfMonth];
    
    for (i = 1;[[lastdate dateAfterDay:-7 * i] year] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)dateAfterDay:(NSUInteger)day {
    return [NSDate dateAfterDate:self day:day];
}

+ (NSDate *)dateAfterDate:(NSDate *)date day:(NSInteger)day {
    if (!date) {
        return nil;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)dateAfterMonth:(NSUInteger)month {
    return [NSDate dateAfterDate:self month:month];
}

+ (NSDate *)dateAfterDate:(NSDate *)date month:(NSInteger)month {
    if (!date) {
        return nil;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)begindayOfMonth {
    return [NSDate begindayOfMonth:self];
}

+ (NSDate *)begindayOfMonth:(NSDate *)date {
    return [self dateAfterDate:date day:-[date day] + 1];
}

- (NSDate *)lastdayOfMonth {
    return [NSDate lastdayOfMonth:self];
}

+ (NSDate *)lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self begindayOfMonth:date];
    return [[lastDate dateAfterMonth:1] dateAfterDay:-1];
}

- (NSUInteger)daysAgo {
    return [NSDate daysAgo:self];
}

+ (NSUInteger)daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)weekday {
    return [NSDate weekday:self];
}

+ (NSInteger)weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)isToday {
    return [self isSameDay:[NSDate date]];
}


- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateAfterDate:[NSDate date] day:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateAfterDate:[NSDate date] day:-1];
}


- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}


+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

- (NSDate *)dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr? retStr: @"";
}

+ (NSDate *)dateWithString:(NSString *)string format:(NSString *)format {
    
    NSDate *date = nil; 
    @try {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:format];
        date = [inputFormatter dateFromString:string];
    } @catch (NSException *exception) { 
    } @finally {
        
    }
    return date;
}

- (NSUInteger)daysInMonth:(NSUInteger)month {
    return [NSDate daysInMonth:self month:month];
}

+ (NSUInteger)daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)daysInMonth {
    return [NSDate daysInMonth:self];
}

+ (NSUInteger)daysInMonth:(NSDate *)date {
    return [self daysInMonth:date month:[date month]];
}

- (NSString *)timeInfo {
    return [NSDate timeInfoWithDate:self];
}

+ (NSString *)timeInfoWithDate:(NSDate *)date {
    return [self timeInfoWithDateString:[self stringWithDate:date format:[self ymdHmsFormat]]];
}

+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self dateWithString:dateString format:[self ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate month] - [date month]);
    int year = (int)([curDate year] - [date year]);
    int day = (int)([curDate day] - [date day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate month] == 1 && [date month] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self daysInMonth:date month:[date month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate day] + (totalDays - (int)[date day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate month];
            int preMonth = (int)[date month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)ymdFormat {
    return [NSDate ymdFormat];
}

- (NSString *)hmsFormat {
    return [NSDate hmsFormat];
}

- (NSString *)ymdHmsFormat {
    return [NSDate ymdHmsFormat];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

- (NSDate *)offsetYears:(int)numYears {
    return [NSDate offsetYears:numYears fromDate:self];
}

+ (NSDate *)offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetMonths:(int)numMonths {
    return [NSDate offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetDays:(int)numDays {
    return [NSDate offsetDays:numDays fromDate:self];
}

+ (NSDate *)offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetHours:(int)hours {
    return [NSDate offsetHours:hours fromDate:self];
}

+ (NSDate *)offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)offsetSeconds:(int)second {
    return [NSDate offsetSeconds:second fromDate:self];
}

+ (NSDate *)offsetSeconds:(int)second fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSCalendarUnitDay
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setSecond:second];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}


+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number withFormatter:(NSString *)formatter
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    
    NSDate * date = [NSDate date];
    NSDateFormatter * inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:formatter];
    
    for (int i = 0; i<number; i++)
    {
        NSString * days = [inputFormatter stringFromDate:[self offsetDays:i fromDate:date]];
        [array addObject:days];
    }

    return array;
}
+(NSMutableArray *)getDataFromTodayToNumberDaysLater:(int)number
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<number; i++)
    {
        NSDate * date = [self offsetDays:i fromDate:[NSDate date]];
        [array addObject:date];
    }
    
    return array;
}
+(NSString *)getTimeWithNumberDaysLater:(NSUInteger)datys andEndHourTime:(NSString *)endTime;
{
    NSDate * date = [[NSDate date] dateAfterDay:datys];
    NSString * string = [NSString stringWithFormat:@"%@ %@:00:00",[date formatYMD],endTime];
    NSDate * getDate = [NSDate dateFromStr:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval time = [getDate timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    NSString *curTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    return curTime;
}
+(NSDate *)getTimeWithNumberHoursLater:(int)hours
{
    NSString * hour = [NSString stringWithFormat:@"%d",[[NSDate formatDate:[NSDate date] withFormat:@"HH"] intValue]+hours];
    NSDate * time = nil;
    if ([hour intValue]>24)
    {
        time = [NSDate dateWithString:[NSDate getTimeWithNumberDaysLater:1 andEndHourTime:[NSString stringWithFormat:@"%d",hours]] format:kDateFormatDefault];
    }
    else
    {
        NSString * nowTime = [NSDate stringWithDate:[NSDate date] format:kDateFormatDefault];
        NSMutableString * mutableStringNow = [NSMutableString stringWithString:nowTime];
        [mutableStringNow replaceCharactersInRange:NSMakeRange(11, 2) withString:hour];
        time = [NSDate dateWithString:[NSString stringWithFormat:@"%@",mutableStringNow] format:kDateFormatDefault];
    }
    return time;
}
+(NSDate *)getTimeWithDateString:(NSString *)dateString andEndHourTime:(NSString *)endTime;
{
    NSDate * date = [NSDate dateFromStr:dateString withFormat:kDateFormatDefault];
    NSString * string = [NSString stringWithFormat:@"%@ %@:00:00",[date formatYMD],endTime];
    NSDate * getDate = [NSDate dateFromStr:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return getDate;
}
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents  *comp = [calendar components:NSCalendarUnitDay
                                              fromDate:fromDate
                                                toDate:toDate
                                               options:NSCalendarWrapComponents];
         return comp.day;
}


+ (NSDateComponents *)numWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate unitFlags:(NSCalendarUnit)unitFlags {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:unitFlags
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp;
}

+ (NSInteger)numberOfMonthsWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:NSCalendarUnitMonth
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp.month;
}
+ (NSDateComponents *)dateComponentsYearsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:kCFCalendarUnitYear|kCFCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp;
}

+ (NSDateComponents *)dateComponentsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp;
}

+ (NSDateComponents *)dateComponentsUntilSecondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp;
}

+ (NSInteger)secondsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:NSCalendarUnitSecond
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp.second;
}

+ (NSInteger)numberOfHourWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents  *comp = [calendar components:NSCalendarUnitHour
                                          fromDate:fromDate
                                            toDate:toDate
                                           options:NSCalendarWrapComponents];
    return comp.hour;
}

+ (NSString *)timeStampSince1970WithDefalutFormatTimeString:(NSString *)timeString
{
    NSDate *date = [NSDate dateFromStr:timeString withFormat:kDateFormat_yyMdHm];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
}
+ (NSString *)timeStampSince1970WithString:(NSString *)timeString withFormat:(NSString*)format
{
    NSDate *date = [NSDate dateFromStr:timeString withFormat:format];
    return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]*1000];
}

- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [components setDay:1];
    
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

- (NSDate *)dateFormatYMD000000 {
    NSString *str = [NSString stringWithFormat:@"%@ 00:00:00", [NSDate formatDate:self withFormat:kDateFormat_yMd]];
    return [NSDate dateWithString:str format:kDateFormatDefault];
}

- (NSDate *)dateFormatYMD235959 {
    NSString *str = [NSString stringWithFormat:@"%@ 23:59:59", [NSDate formatDate:self withFormat:kDateFormat_yMd]];
    return [NSDate dateWithString:str format:kDateFormatDefault];
}

+ (NSInteger)compareWithDate1:(NSDate *)date1 date2:(NSDate *)date2 {
    NSDate *tempDate1 = [date1 dateFormatYMD000000];
    NSDate *tempDate2 = [date2 dateFormatYMD000000];
    return [tempDate1 compare:tempDate2];
}

+ (NSDate *)dateFormateWithYDate:(NSDate *)yDate hDate:(NSDate *)hDate {
    
    NSString *yStr = [NSDate formatDate:yDate withFormat:kDateFormat_yMd];
    NSString *hStr = [NSDate formatDate:hDate withFormat:kDateFormatTime];
    NSString *str = [NSString stringWithFormat:@"%@ %@", yStr, hStr];
    return [NSDate dateWithString:str format:kDateFormatDefault];
}

+ (NSString *)hourMinuteDateFromHour:(NSString *)hour
{
    if (!hour) {
        return @"0分钟";
    }
    
    CGFloat fHour = hour.floatValue;
    NSInteger h = fHour / 1;
    
    if (h > 0) {
        return  [NSString stringWithFormat:@"%ld小时%.0f分钟", h, (fHour - h) * 60];
    }
    return [NSString stringWithFormat:@"%.0f分钟", (fHour - h) * 60];
}

@end
