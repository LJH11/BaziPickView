//
//  NLToast.h
//  NLUitlsLib
//
//  Created by MD313 on 13-8-13.
//  Copyright (c) 2013年 MD313. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum 
{
	NLToastGravityTop = 1000001,
	NLToastGravityBottom,
	NLToastGravityCenter
}NLToastGravity;

typedef enum 
{
	NLToastDurationLong = 10000,
	NLToastDurationShort = 1000,
	NLToastDurationNormal = 3000
}NLToastDuration;


@interface NLToast : NSObject

/***
 显示toast
 
 text - 显示的文字内容
 gravity － 显示的位置(NLToastGravity)
 duration - toast显示持续的时间(NLToastDuration);
 */

-(void)show:(NSString*)text
    gravity:(NLToastGravity)gravity
   duration:(NLToastDuration)duration;

@end
