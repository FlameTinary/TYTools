//
//  NSString+TYStringExtension.m
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "NSString+TYStringExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TYStringExtension)

//转换MD5
- (NSString *)md5String{
    const char *value = [self UTF8String];

    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    return outputString;
}

- (NSString *)stringToDate {
    return [self stringToCustomDate:@"yyyy-MM-dd HH:mm:ss"];
}

//返回年月日,时分格式的字符串
- (NSString *)stringToYearMonthDayHourMinuteDate{
    return [self stringToCustomDate:@"yyyy-MM-dd HH:mm"];
}

/**
 //返回自定义格式的字符串
 
 @param dateString 自定义的时间字符串格式
 
 @return return 返回指定格式的时间字符串
 */
- (NSString *)stringToCustomDate:(NSString *)dateString{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:dateString];
    NSString *strDate = [dateFormatter stringFromDate:timeData];
    return strDate;
}

//比较两个日期的大小,格式为yyyy-MM-dd HH:mm:ss
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate{
    NSDateFormatter *dateformater=[[NSDateFormatter alloc]init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateA=[[NSDate alloc]init];
    NSDate *dateB=[[NSDate alloc]init];
    
    dateA=[dateformater dateFromString:aDate];
    dateB=[dateformater dateFromString:bDate];
    NSComparisonResult result=[dateA compare:dateB];
    
    if(result==NSOrderedSame){
        //相等
        return 0;
    }else if (result==NSOrderedAscending){
        //bDate比aDate大
        return 1;
    }else if(result==NSOrderedDescending){
        //bDate比aDate小
        return -1;
    }
    return 2;
}

/**
 倒计时
 */
static  NSDateFormatter *countDownFormatter = nil;
- (NSString *)countDownStringWithData {
    
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:ceil([self doubleValue]/1000)];
    
    if (countDownFormatter==nil) {
        
        countDownFormatter = [[NSDateFormatter alloc] init];
        
        [countDownFormatter setDateStyle:NSDateFormatterMediumStyle];
        [countDownFormatter setTimeStyle:NSDateFormatterShortStyle];
        [countDownFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [countDownFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSString *strDate = [countDownFormatter stringFromDate:timeData];
    
    return strDate;
}

- (NSString *)returnChinaTimeData{
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    //    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:1511057014];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:timeData];
    return strDate;
}

//判断内容是否含有中文
- (BOOL)containChinese{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

- (BOOL)isAllBlank {
    // 判断文字是否全空格
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([temp length]==0) {
        return YES;
    }
    return NO;
}


+ (NSString *)filterEmojiWithText:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}


/*
 *利用Emoji表情最终会被编码成Unicode，因此，
 *只要知道Emoji表情的Unicode编码的范围，
 *就可以判断用户是否输入了Emoji表情。
 */
- (BOOL)hasContainsEmoji
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}
@end
