//
//  ViewController.m
//  pickViewTest
//
//  Created by 〝Cow﹏. on 2020/6/28.
//  Copyright © 2020 GeomanticCompass. All rights reserved.
//

#import "ViewController.h"
#import "BaziPickViewController.h"
#import "ToolModel.h"
#import "BUIControl.h"

//现在做的鸡儿马甲、总是需要用到这个控件
//就拆出来顺便分享一下 有用到就直接用咯、
//一些代码都5 6年了、懒得改毕竟稳定不奔溃就ojbk
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DLog(@"111sss11111");
    self.view.backgroundColor = [UIColor clearColor];
    
    UIButton * pick1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    pick1Btn.frame=CGRectMake(WH_SCALE(20), WH_SCALE(110), SCREEN_WIDTH - WH_SCALE(40), WH_SCALE(40));
    [pick1Btn setTitle:@"展示全部" forState:UIControlStateNormal];
    pick1Btn.backgroundColor = RANDOM_COLOR;
    [pick1Btn.titleLabel setFont:FONT_MEDIUM(12)];
    [self.view addSubview:pick1Btn];
    [pick1Btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender)
    {
        [self showBaziAction:YES];
    }];

    UIButton * pick2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    pick2Btn.frame=CGRectMake(WH_SCALE(20), pick1Btn.bottom + WH_SCALE(12), SCREEN_WIDTH - WH_SCALE(40), WH_SCALE(40));
    [pick2Btn setTitle:@"展示底部" forState:UIControlStateNormal];
    pick2Btn.backgroundColor = RANDOM_COLOR;
    [pick2Btn.titleLabel setFont:FONT_MEDIUM(12)];
    [self.view addSubview:pick2Btn];
    [pick2Btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender)
    {
        [self showBaziAction:NO];
    }];
    
    UIButton * pick3Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    pick3Btn.frame=CGRectMake(WH_SCALE(20), pick2Btn.bottom + WH_SCALE(12), SCREEN_WIDTH - WH_SCALE(40), WH_SCALE(40));
    [pick3Btn setTitle:@"指定信息" forState:UIControlStateNormal];
    pick3Btn.backgroundColor = RANDOM_COLOR;
    [pick3Btn.titleLabel setFont:FONT_MEDIUM(12)];
    [self.view addSubview:pick3Btn];
    [pick3Btn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender)
      {
          [self baziAction];
      }];
}


#pragma ===================== 分割线 =========================
-(void)showBaziAction:(BOOL)topFlag
{
    BaziPickViewController * pickVc = [[BaziPickViewController alloc] initWithBaziFlag:topFlag];
    pickVc.ChangeBaziBlock = ^(NSString *baziBlockStr)
    {
        DLog(@"获得八字信息 === %@",baziBlockStr);
        [CowUtils showbotToastActionShort:baziBlockStr];
    };
    [self changeHoroscopePushAction:pickVc];
}

-(void)baziAction
{
    //LJDEFUAL_USTERING 默认八字结构、’|‘ 分割、可以对应自己需要的八字
    BaziPickViewController * pickVc = [[BaziPickViewController alloc] initWithBaziFlag:YES];
    pickVc.currentString_one =  @"一只老母猪|男|农历|1990|9|9|9|0|否";
    pickVc.ChangeBaziBlock = ^(NSString *baziBlockStr)
    {
        DLog(@"获得八字信息 === %@",baziBlockStr);
        [CowUtils showbotToastActionShort:baziBlockStr];
    };
    [self changeHoroscopePushAction:pickVc];
}


#pragma mark 跳转
-(void)changeHoroscopePushAction:(id)changeVC
{
    BaziPickViewController * newVC = (BaziPickViewController*)changeVC;
    newVC.definesPresentationContext = YES;
    
    UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:newVC];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    // 在这里加一个这个样式的循环
    while (topRootViewController.presentedViewController)
    {
        // 这里固定写法
        topRootViewController = topRootViewController.presentedViewController;
    }
    // 然后再进行present操作
    [topRootViewController presentViewController:nav animated:YES completion:nil];
}

@end
