最近马甲项目总是需要用到、刚好有点时间就拆出来、有需要参考到的可以看看。 用了n年了、主要稳定不奔溃 一些代码后期看情况需要再优化吧。

八字类型的弹出时间选择控件、方法简单、公农历转换 、24时辰功能、大小闰月 封装。

一句回调即可

选择公历时候无闰月样式

选择农历时候且当前年月有闰月样式、可以选择勾选

简单的公农历形式

#=========================== 分割线 代码使用 ======================

 BaziPickViewController * pickVc = [[BaziPickViewController alloc] initWithBaziFlag:topFlag];

   pickVc.ChangeBaziBlock = ^(NSString *baziBlockStr)

    {

        DLog(@"获得八字信息 === %@",baziBlockStr);

        [CowUtils showbotToastActionShort:baziBlockStr];

    };

    [self changeHoroscopePushAction:pickVc];

设置当前的时间信息、按照 ‘| ’分割的构造

pickVc.currentString_one =  @"一只老母猪|男|农历|1990|9|9|9|0|否";

喜欢的就点个赞吧、一般比较懒很少去写去分享、给点动力咯~

没了大概就这样、有空再优化吧、继续学习！
