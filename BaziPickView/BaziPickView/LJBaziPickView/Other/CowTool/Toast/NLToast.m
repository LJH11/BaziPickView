//
//  NLToast.m
//  NLUitlsLib
//
//  Created by MD313 on 13-8-13.
//  Copyright (c) 2013年 MD313. All rights reserved.
//

#import "NLToast.h"
#import "iToast.h"

@implementation NLToast

-(void)show:(NSString*)text
    gravity:(NLToastGravity)gravity
   duration:(NLToastDuration)duration
{
    NSInteger dur;
    switch (duration)
    {
        case NLToastDurationLong:
        {
            dur = 10000;
        }
            break;
        case NLToastDurationNormal:
        {
            dur = 3000;
        }
            break;
        case NLToastDurationShort:
        {
            dur = 1000;
        }
            break;
            
        default:
            break;
    }
    iToastGravity gra = (iToastGravity)gravity;
    [[[[iToast makeText:text] setGravity:gra] setDuration:dur] show];
}

@end
