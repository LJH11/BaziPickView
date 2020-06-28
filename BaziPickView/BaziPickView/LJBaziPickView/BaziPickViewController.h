//
//  BaziPickViewController.h
//  all2
//
//  Created by 〝Cow﹏. on 19-1-13.
//  Copyright (c) 2019年 BaziPickView. All rights reserved.
//

#import <UIKit/UIKit.h>

//八字选择器 优化版、有时间就对闰月判断优化吧
//字段扩展的有好几个 以前对应不同的需求定义的、如用不着先不理或者自己删除就好

//默认八字信息的结构
#define LJDEFUAL_USTERING   @"测试案例|男|公历|1990|1|1|1|0|否"

typedef void(^ViewAddHiddenBlock)(BOOL blockFlag);

@interface BaziPickViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain) UIButton *bgView;
@property BOOL bzkChangeFlag;//注意八字库修改八字的、不保存取消的也不做统一修改
@property (nonatomic,retain)NSString *currentString_one;
@property (nonatomic,retain)NSString *currentString_two;
@property (nonatomic,retain)NSString *nokonwHourStr;//不清楚时间

@property (nonatomic,retain)NSString *calculationString_one;
@property (nonatomic,retain)NSString *calculationString_two;

@property (nonatomic,strong) ViewAddHiddenBlock Viewblock;

//顶部取消及侧边文字、颜色
//唉 比较懒 就不写其他了
@property (nonatomic,strong) UIColor * topTitleColor;


/*
 点击测算的回调
 */
@property (nonatomic,strong) void(^ChangeBaziBlock)(NSString * baziBlockStr);

@property int superClassType;

/*
 是：展开整个八字信息、男女、姓名等
 否：单独八字的弹出
 */
- (id)initWithBaziFlag:(BOOL)flag;

@end
