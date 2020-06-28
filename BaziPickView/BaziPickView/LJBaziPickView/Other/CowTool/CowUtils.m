//
//  CowUtils.m
//  pickViewTest
//
//  Created by MacApp on 2020/6/28.
//  Copyright © 2020 GeomanticCompass. All rights reserved.
//

#import "CowUtils.h"
#import "NLToast.h"

@implementation CowUtils

//图片替换颜色
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//提示
+ (void)showbotToastActionShort:(NSString*)titleStr
{
    [[[NLToast alloc] init] show:titleStr
                         gravity:NLToastGravityBottom
                        duration:NLToastDurationShort];
}
@end
