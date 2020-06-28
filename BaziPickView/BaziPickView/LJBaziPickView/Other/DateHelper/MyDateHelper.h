//
//  MyDateHelper.h
//  Car
//
//  Created by 〝Cow﹏. on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDateHelper : NSObject

//+(BOOL)isLeapYear:(int)year;

+(int)dayOfMonthInYear:(int)year inMonth:(int)month ifNongLi:(BOOL)isNongLi;

+(BOOL)leapMonthOfYear:(int)year;

//时间切换 新版要求
+(NSString *)SqlformateNongYue:(int)day;
+(NSMutableArray *)SqlformateNongRunYue:(int)month :(NSString*)runyue;
+(NSString *)formateHour:(int)hour;
+(NSString *)formateNongYue:(int)day;
+(NSString *)formateNongHour:(int)hour;
+(NSString *)translationNumberToChinese:(NSString*)number;

//获取当前的时辰 用户缓存数据 cow
+(NSString *)formateShiCeng:(int)hour;

+(NSString *)getNowDateStr;

+(NSString *)getNowDateStr_ymdhm;

+(NSString *)timeStrTransform_timeStr:(NSString *)timeStr;

+(NSString *)timeStrTransform_timeStrNew_Json:(NSString *)timeStr;
+(NSString *)timeStrTransform_timeStr_Json:(NSString *)timeStr;
+(NSString *)timeStrTransform_timeStr_Json:(NSString *)timeStr formatterString:(NSString *)formatterString;
+(int)DoubleMonth:(int)y;
+(NSMutableArray *)formateNongRunYue:(int)month :(NSString*)runyue;

+(NSString *)LunarForSolar:(NSDate *)solarDate;
+(NSString *)LunarForGongliSolar:(NSDate *)solarDate;

+(NSString *)cowgetLunarForSolar:(int)year month:(int)month day:(int)day;
+(NSString *)translationNongliYear:(NSString *)arebic;

//可优化
+(NSString *)translationNongliYearNumber:(NSString *)arebic;
+(NSString *)translationMonthNumber:(NSString *)arebic;
+(NSString *)translationdayNumber:(NSString*)number;
@end


