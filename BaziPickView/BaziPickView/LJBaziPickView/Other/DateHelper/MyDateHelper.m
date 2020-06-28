//
//  MyDateHelper.m
//  Car
//
//  Created by 〝Cow﹏. on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyDateHelper.h"

@implementation MyDateHelper

static NSString *hourStr[] = {
    @"子", @"丑", @"丑", @"寅", @"寅", @"卯", @"卯", @"辰", @"辰", @"巳", @"巳", @"午", @"午", @"未", @"未", @"申", @"申", @"酉", @"酉", @"戌", @"戌", @"亥", @"亥" ,@"子"};
/// <summary>
/// 来源于网上的农历数据
/// </summary>
/// <remarks>
/// 数据结构如下，共使用17位数据
/// 第17位：表示闰月天数，0表示29天   1表示30天
/// 第16位-第5位（共12位）表示12个月，其中第16位表示第一月，如果该月为30天则为1，29天为0
/// 第4位-第1位（共4位）表示闰月是哪个月，如果当年没有闰月，则置0
///</remarks>
static int lunarInfo[] =
{
    0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2,
    0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977,
    0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970,
    0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950,
    0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557,
    0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573, 0x052d0, 0x0a9a8, 0x0e950, 0x06aa0,
    0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0,
    0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b5a0, 0x195a6,
    0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570,
    0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0,
    0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5,
    0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930,
    0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530,
    0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45,
    0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0,
    0x14b63};

+(int)dayOfMonthInYear:(int)year inMonth:(int)month ifNongLi:(BOOL)isNongLi{
    if(isNongLi)
    {
        return ((lunarInfo[year - 1900] & (0x10000 >> month))) > 0 ? 30 : 29;
 
    }else
    {
        if (month == 4 || month == 6 || month == 9 || month == 11) {
            return 30;
        }else if (month == 2) {
            return ((year % 4 == 0) & (month % 100 != 0) ||( year % 400 == 0)) ? 29 : 28;
        }
        return 31;
    }
}

//计算闰月 iOS闰月都为1 ++
+(int)DoubleMonth:(int)y
{
    return (lunarInfo[y - 1900] & 0xf);
}
//闰月返回对应月份
+(BOOL)leapMonthOfYear:(int)year
{
    return (lunarInfo[year - 1900] & 0xf);
}

+(NSString *)formateHour:(int)hour
{
    if(hour>=24)
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%d%@",hour,hourStr[hour]];
}

+(NSString *)formateNongHour:(int)hour
{
    if(hour>=24)
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",hourStr[hour]];
}

//获得datepick当前闰月的数据
+(NSMutableArray *)formateNongRunYue:(int)month :(NSString*)runyue
{
    NSArray * runyueArr = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:runyueArr];
    [arr insertObject:runyue atIndex:month];
    return arr;
}

+(NSString *)formateNongYue:(int)day
{
    NSString * str = day == 1 ? @"正" : day == 2 ? @"二" : day == 3 ? @"三" : day == 4 ? @"四" : day == 5 ? @"五" : day == 6 ? @"六" : day == 7 ? @"七" : day == 8 ? @"八" : day == 9 ? @"九" : day == 10 ? @"十" : day == 11 ? @"十一" : @"十二";
    return str;
}

//闰月
+(NSMutableArray *)SqlformateNongRunYue:(int)month :(NSString*)runyue
{
    NSArray * runyueArr = @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月",@""];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:runyueArr];
    [arr insertObject:runyue atIndex:month];
    return arr;
}

+(NSString *)SqlformateNongYue:(int)day
{
    NSString * str = day == 1 ? @"正" : day == 2 ? @"二" : day == 3 ? @"三" : day == 4 ? @"四" : day == 5 ? @"五" : day == 6 ? @"六" : day == 7 ? @"七" : day == 8 ? @"八" : day == 9 ? @"九" : day == 10 ? @"十" : day == 11 ? @"冬" : @"腊";
    return str;
}

+(NSString *)translationNumberToChinese:(NSString*)number
{
    NSString * transStr;
    NSArray * numberArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    NSArray * chineseArr = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"廿", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"卅", @"卅一"];
    for ( NSInteger j = 0; j < numberArr.count; j++)
    {
        if ([number isEqualToString:numberArr[j]])
        {
            transStr= chineseArr[j];
        }
    }
    return transStr;
}

//数字转换中文 后期优化
+(NSString *)translationNongliYear:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];

    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++)
    {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
       
        [chinese_numerals enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([a isEqualToString:chinese_numerals[idx]])
             {
                [sums addObject:a];
             }
         }];
    }
    
    return [NSString stringWithFormat:@"%@%@%@%@",sums[0],sums[1],sums[2],sums[3]];
}

+(NSString *)translationNongliYearNumber:(NSString *)arebic
{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arabic_numerals forKeys:chinese_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++)
    {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        
        [chinese_numerals enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([a isEqualToString:arabic_numerals[idx]])
             {
                 [sums addObject:a];
             }
         }];
    }
    
    return [NSString stringWithFormat:@"%@%@%@%@",sums[0],sums[1],sums[2],sums[3]];
}

+(NSString *)translationMonthNumber:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:arabic_numerals forKeys:chinese_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++)
    {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        
        [chinese_numerals enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([a isEqualToString:arabic_numerals[idx]])
             {
                 [sums addObject:a];
             }
         }];
    }
    NSString * returnStr;
    
    if ([arebic length]>2)
    {
        returnStr = [NSString stringWithFormat:@"%@%@",sums[0],sums[1]];
    }else{
        returnStr = [NSString stringWithFormat:@"%@",sums[0]];
    }
    return returnStr;
}

+(NSString *)translationdayNumber:(NSString*)number
{
    NSString * transStr;
    NSArray * numberArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
    NSArray * chineseArr = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"廿", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"卅", @"卅一"];
    for ( NSInteger j = 0; j < chineseArr.count; j++)
    {
        if ([number isEqualToString:chineseArr[j]])
        {
            transStr= numberArr[j];
        }
    }
    return transStr;
}

//获取当前的时辰 用户缓存数据 cow
+(NSString *)formateShiCeng:(int)hour
{
    if(hour>=24)
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",hourStr[hour]];
}

+(NSString *)getNowDateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateStr=[formatter stringFromDate: [NSDate date]];
    
    
    return dateStr;
}

+(NSString *)getNowDateStr_ymdhm
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm"];
    
    NSString *dateStr=[formatter stringFromDate: [NSDate date]];
    
    
    return dateStr;
}

+(NSString *)timeStrTransform_timeStr:(NSString *)timeStr{
    timeStr = [timeStr substringToIndex:[timeStr rangeOfString:@"+"].location];
    
//    timeStr = @"2012-09-20T20:51:37.828125+08:00";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSS"];
    
    NSDate *date = [formatter dateFromString:timeStr];
    
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    NSString *resultTimeStr = [formatter stringFromDate:date];
    
    
    return resultTimeStr;
}

+(NSString *)timeStrTransform_timeStrNew_Json:(NSString *)timeStr
{
    NSString *temp1=[timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *temp2=[temp1 stringByReplacingOccurrencesOfString:@":" withString:@""];
    temp2=[temp2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *dateq = [dateFormatter dateFromString:temp2];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    NSString *resultTimeStr = [formatter stringFromDate:dateq];
    
    return resultTimeStr;
}

+(NSString *)timeStrTransform_timeStr_Json:(NSString *)timeStr
{
    NSString *temp1=[timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    NSString *temp2=[temp1 stringByReplacingOccurrencesOfString:@")/" withString:@""];
    NSTimeInterval date_temp= [temp2 doubleValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *resultTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:date_temp]];
    
    return resultTimeStr;
}

+(NSString *)timeStrTransform_timeStr_Json:(NSString *)timeStr formatterString:(NSString *)formatterString
{
    NSString *temp1=[timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    NSString *temp2=[temp1 stringByReplacingOccurrencesOfString:@")/" withString:@""];
    NSTimeInterval date_temp= [temp2 doubleValue]/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    NSString *resultTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:date_temp]];
    
    return resultTimeStr;
}


#pragma mark 阳历转换农历函数 cow
/*
 cow 用于获取过当前时间后的农历&阳历转换
http://blog.csdn.net/studyrecord/article/details/6651794
 只需要转换
 */
+(NSString *)LunarForSolar:(NSDate *)solarDate
{
    /*
    //天干名称
    NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    //地支名称
    NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    //属相名称
    NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
     */
    
    //农历日期名
    NSArray *cDayName =
    [NSArray arrayWithObjects:
     @"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
     @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
     @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",nil];
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static long int wCurYear,wCurMonth,wCurDay;
    static long int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:solarDate];
    wCurYear  = [components year];
    wCurMonth = [components month];
    wCurDay   = [components day];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相 暂时不需要
//    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
//    NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) % 12]];
     NSString *szNongli = [NSString stringWithFormat:@"%ld年",wCurYear];
    
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1)
    {
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else
    {
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@%@月%@",szNongli,szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
    
    return lunarDate;
}
//农历转换公历
+(NSString *)LunarForGongliSolar:(NSDate *)solarDate
{
    //农历日期名
    NSArray *cDayName =
    [NSArray arrayWithObjects:
     @"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",
     @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
     @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",nil];
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static long int wCurYear,wCurMonth,wCurDay;
    static long int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:solarDate];
    wCurYear  = [components year];
    wCurMonth = [components month];
    wCurDay   = [components day];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    NSString *szNongli = [NSString stringWithFormat:@"%ld年",wCurYear];
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1)
    {
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else
    {
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@%@月%@",szNongli,szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
    
    return lunarDate;
}


+(NSString *)cowgetLunarForSolar:(int)year month:(int)month day:(int)day
{
   
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"冬",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int wCurYear,wCurMonth,wCurDay;
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    //    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:solarDate];
    wCurYear =year;
    wCurMonth = month;
    wCurDay = day;
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
  
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1){
        szNongliDay = [NSString stringWithFormat:@"%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else{
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
  

    NSString *lunarMonth=szNongliDay;
    NSString *lunarDay = [NSString stringWithFormat:@"%@",(NSString *)[cDayName objectAtIndex:wCurDay]];
    
    if([[lunarDay substringToIndex:2] isEqualToString:@"初一"])
    {
        if([szNongliDay isEqualToString:@""])
        {
            lunarDay=@"正月";
        }
        else
        {
            lunarDay=[NSString stringWithFormat:@"%@月",szNongliDay];
        }
    }
    else
    {
        
    }
    NSString *lunarDate=[NSString stringWithFormat:@"%@月|%@",lunarMonth,lunarDay];
    //    NSLog(@"%@",lunarDate);
    
    return lunarDate;
}



@end

