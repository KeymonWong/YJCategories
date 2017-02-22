//
//  NSDate+YJSuperExt.m
//  YJCategoriesGather
//
//  Created by YJHou on 2015/3/17.
//  Copyright © 2015年 侯跃军 houmanager@Hotmail.com. All rights reserved.
//

#import "NSDate+YJSuperExt.h"

#define YJ_EACH_MINUTE	60
#define YJ_EACH_HOUR	3600
#define YJ_EACH_DAY	    86400
#define YJ_EACH_WEEK	604800
#define YJ_EACH_YEAR	31556926

/** 日期组成部分 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#define YJ_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({ \
unsigned components;\
if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
}else{ \
components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
} \
components; \
})\
_Pragma("clang diagnostic pop") \

#else
#define YJ_NSDATE_UTILITIES_COMPONENT_FLAGS \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
({\
unsigned components = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit); \
components; \
})\
_Pragma("clang diagnostic pop") \

#endif

@implementation NSDate (YJSuperExt)

/** 当前日历 */
+ (NSCalendar *)yj_currentCalendar{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - 日期拆解
/** 年 */
- (NSInteger)yj_year{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.year;
}

- (NSInteger)yj_month{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.month;
}

- (NSInteger)yj_day{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.day;
}

- (NSInteger)yj_nearestHour{
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_EACH_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components = [[NSDate yj_currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components = [[NSDate yj_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components =  [[NSDate yj_currentCalendar] components:NSHourCalendarUnit fromDate:newDate];
#endif
    return components.hour;
}

- (NSInteger)yj_hour{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.hour;
}

- (NSInteger)yj_minute{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.minute;
}

- (NSInteger)yj_second{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.second;
}

- (NSInteger)yj_nthWeekday{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)yj_weekday{
    NSDateComponents *components = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    return components.weekday;
}

#pragma mark - 格式化日期
/** 使用dateStyle timeStyle格式化时间 */
- (NSString *)yj_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

/** 根据指定format返回 String 时间 */
- (NSString *)yj_stringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)yj_shortString{
    return [self yj_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)yj_shortDateString{
    return [self yj_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)yj_shortTimeString{
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)yj_mediumString{
    return [self yj_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)yj_mediumTimeString{
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)yj_mediumDateString{
    return [self yj_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)yj_longString{
    return [self yj_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)yj_longTimeString{
    return [self yj_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)yj_longDateString{
    return [self yj_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - 从当前日期相对日期时间
/** 增加 days 天时间 */
- (NSDate *)yj_dateByAddingDays:(NSUInteger)days{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

/** 当前时间增加 dHours 个小时 */
- (NSDate *)yj_dateByAddingHours:(NSInteger)dHours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_EACH_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

/** 当前时间增加 dMinutes 分钟 */
- (NSDate *)yj_dateByAddingMinutes:(NSInteger)dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_EACH_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 时间比较

/** 比较年月日是否相等 */
- (BOOL)yj_isEqualToDateIgnoreTime:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

/** 是否是今天 */
- (BOOL)yj_isToday{
    return [self yj_isEqualToDateIgnoreTime:[NSDate date]];
}

/** 是否是明天 */
- (BOOL)yj_isTomorrow{
    return [self yj_isEqualToDateIgnoreTime:[[NSDate date] yj_dateByAddingDays:1]];
}

/** 是否是昨天 */
- (BOOL)yj_isYesterday{
    return [self yj_isEqualToDateIgnoreTime:[[NSDate date] yj_dateByAddingDays:-1]];
}

/** 是否是同一周 */
- (BOOL)yj_isEqualWeekWithDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:YJ_NSDATE_UTILITIES_COMPONENT_FLAGS fromDate:aDate];

    if (components1.weekOfYear != components2.weekOfYear) return NO;
    return (fabs([self timeIntervalSinceDate:aDate]) < YJ_EACH_WEEK);
}

/** 是否是本周 */
- (BOOL)yj_isThisWeek{
    return [self yj_isEqualWeekWithDate:[NSDate date]];
}

/** 是否是上一周 */
- (BOOL)yj_isNextWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + YJ_EACH_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yj_isEqualWeekWithDate:newDate];
}

/** 是否是上一周 */
- (BOOL)yj_isBeforeWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - YJ_EACH_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yj_isEqualWeekWithDate:newDate];
}

/** 是否是同一个月 */
- (BOOL)yj_isEqualMonthWithDate:(NSDate *)aDate{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    NSDateComponents *components1;
    NSDateComponents *components2;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f){
        components1 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
        components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#pragma clang diagnostic pop
    }
#else
    NSDateComponents *components1 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [[NSDate yj_currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
#endif
    
    return ((components1.month == components2.month) && (components1.year == components2.year));
}

/** 是否是本月 */
- (BOOL)jk_isThisMonth{
    return [self jk_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL) jk_isLastMonth
{
    return [self jk_isSameMonthAsDate:[[NSDate date] jk_dateBySubtractingMonths:1]];
}

- (BOOL) jk_isNextMonth
{
    return [self jk_isSameMonthAsDate:[[NSDate date] jk_dateByAddingMonths:1]];
}





@end