//
//  ToolModel.h
//  pickViewTest
//
//  Created by MacApp on 2020/6/28.
//  Copyright © 2020 GeomanticCompass. All rights reserved.
//

#import "UIView+PSFrame.h"
#import "CowUtils.h" 

#ifndef ToolModel_h
#define ToolModel_h

#define USER_INFO_SEQ @"|"
#define LOCKED_USERSTRING_DEFUAL @"LockedUserString"

#define GOLDLBCOLOR RGBA(50, 50, 50, 1)
#define GOLDNEWCOLOR RGBA(243, 177, 89, 1)

#define randomCow(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RANDOM_COLOR randomCow(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define FONT_MEDIUM(a) [UIFont fontWithName:@"PingFangSC-Medium" size:WH_SCALE(a)]

#define RGB(R/*红*/, G/*绿*/, B/*蓝*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1]
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define CowNSStringFormat(format,...)[NSString stringWithFormat:format,##__VA_ARGS__]

#define WH_SCALE(intN) intN * (SCREEN_WIDTH >= 414 ? 1.3 : SCREEN_WIDTH == 375 ? 1.17 : 1)
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define  LL_TabbarSafeBottomMargin         (LL_iPhoneX ? 34.f : 0.f)

#define LL_iPhoneX (LL_IPhoneX_XS || LL_IPhoneXR_XSMax)
#define LL_IPhoneX_XS ([UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f) ? YES : NO
#define LL_IPhoneXR_XSMax ([UIScreen mainScreen].bounds.size.width == 414.0f && [UIScreen mainScreen].bounds.size.height == 896.0f) ? YES : NO//异性全面屏

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define DeBugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NSLog(...) NSLog(__VA_ARGS__);
#define MyNSLog(FORMAT, ...) fprintf(stderr,"[%s]:[line %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DLog(...)
#define DeBugLog(...)
#define NSLog(...)
#define MyNSLog(FORMAT, ...) nil
#endif


#define COWSHOW_DEFUAL_TITLE_UIBUTTON(btnClassName , btnFrame , btnTitle, btnFont, btnColor , bgColor , supView)\
UIButton * btnClassName =[UIButton buttonWithType:UIButtonTypeCustom];\
btnClassName.frame = btnFrame;\
btnClassName.backgroundColor = bgColor;\
btnClassName.titleLabel.font = btnFont;\
[btnClassName setTitle:btnTitle forState:UIControlStateNormal];\
[btnClassName setTitleColor:btnColor forState:UIControlStateNormal];\
[supView addSubview:btnClassName];\

#define COWSHOW_DEFUAL_LINE_UILABLE(lbClassName , lbFrame , bgColor , supView)\
UILabel * lbClassName = [[UILabel alloc] initWithFrame:lbFrame];\
lbClassName.backgroundColor = bgColor;\
[supView addSubview:lbClassName];\


#endif /* ToolModel_h */
