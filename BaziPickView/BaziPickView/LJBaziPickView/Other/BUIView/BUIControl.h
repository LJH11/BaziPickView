//
//  UIControl+BUIControl.h
//  BlockUI
//
//  Created by 〝Cow﹏. on 14-11-3.
//  Copyright (c) 2012年 〝Cow﹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (BUIControl)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;

@end
