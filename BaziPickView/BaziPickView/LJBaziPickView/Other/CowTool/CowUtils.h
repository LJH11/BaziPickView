//
//  CowUtils.h
//  pickViewTest
//
//  Created by MacApp on 2020/6/28.
//  Copyright © 2020 GeomanticCompass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CowUtils : NSObject

//图片替换颜色
+ (UIImage *)createImageWithColor:(UIColor *)color;
//提示
+ (void)showbotToastActionShort:(NSString*)titleStr;

@end

NS_ASSUME_NONNULL_END
