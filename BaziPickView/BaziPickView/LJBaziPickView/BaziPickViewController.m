//
//  BaziPickViewController.m
//  all2
//
//  Created by 〝Cow﹏. on 19-1-13.
//  Copyright (c) 2019年 BaziPickView. All rights reserved.
//

#import "BaziPickViewController.h"
#import "MyDateHelper.h"
#import "ToolModel.h"
#import "BUIControl.h"


@interface BaziPickViewController ()
{
    BOOL showBaziFlag;
    //日历参数
    UIView *myPickerView;
    UIPickerView *datePickerView;
    BOOL isShow;
    
    UIButton *gongliButton;
    UIButton *nongliButton;
    UIButton *runButton;
    UILabel *runLabel;
    
    BOOL isLady0,isLunar0,isLeap0,isLeapChecked0;
    long int year0,month0,day0,hour0;

    UIView *horoscopeEditView;
    
    //第一个八字
    UIImageView *selected_one;//“勾”图片
    UIButton *selectedBtn_one;//选择八字按钮
    UILabel *userStringLabel_one;//用户八字
    
    UIView *editingView_one;
    UITextField *userName_one;//姓名
    UIButton *userSexBtn_one;//性别
    UILabel *horoscopeLabel_one;//八字
    
    UIView *editButtonView_one;//编辑按钮
    UILabel *editLabel_one;//编辑文字
    int sexValue_one;//性别值
    BOOL isEditing_one;//正在编辑
    
    UIButton *sexButton_man;
    UIButton *sexButton_woman;
    
    //第二个八字
    UIImageView *selected_two;
    UIButton *selectedBtn_two;
    UILabel *userStringLabel_two;
    
    UIView *editingView_two;
    UITextField *userName_two;
    UIButton *userSexBtn_two;
    UIView *editButtonView_two;
    UILabel *horoscopeLabel_two;
    
    UILabel *editLabel_two;
    int sexValue_two;
    BOOL isEditing_two;//正在编辑
    
    int topPickHeight,topPickBgHeight;
    int currentSelectType;//当前选择编辑的八字，1《--》2
    
}

@end

@implementation BaziPickViewController

@synthesize calculationString_one,calculationString_two,currentString_one,currentString_two;
@synthesize superClassType;
//@synthesize changeDelegate;
@synthesize bgView;

- (id)initWithBaziFlag:(BOOL)flag
{
    self = [super init];
    if (self)
    {
        showBaziFlag = flag;
        topPickHeight = WH_SCALE(214);
        topPickBgHeight = WH_SCALE(420) + LL_TabbarSafeBottomMargin;
    }
    return self;
}

-(NSString *)explainUserString:(NSString *)str
{
    NSArray *array=[str componentsSeparatedByString:@"|"];
    NSString *name=[array objectAtIndex:0] ;
    NSString *sexStr = [array objectAtIndex:1];
    NSString *riLiStr = [array objectAtIndex:2];
    NSString *yearStr = [array objectAtIndex:3];
    NSString *monthStr = [array objectAtIndex:4];
    NSString *dayStr = [array objectAtIndex:5];
    NSString *hourStr = [array objectAtIndex:6];
    NSString *isLeapStr = [array objectAtIndex:8];
    
    NSString *hourString_temp = [MyDateHelper formateHour:hourStr.intValue];
    NSString *myUserString=[NSString stringWithFormat:@"%@ %@ %@ %@%@年%@月%@日%@时",name,sexStr,riLiStr,[isLeapStr isEqualToString:@"是"]?@"闰":@"",yearStr,monthStr,dayStr,hourString_temp];
    if ([_nokonwHourStr length] > 0)
    {
        myUserString=[NSString stringWithFormat:@"%@ %@ %@ %@%@年%@月%@日",name,sexStr,riLiStr,[isLeapStr isEqualToString:@"是"]?@"闰":@"",yearStr,monthStr,dayStr];
    }
    return myUserString;
    
}

-(void)setDatePickerState:(NSString *)_userString
{
    if (_userString == nil)
    {
        _userString = LJDEFUAL_USTERING;
        self.calculationString_one = _userString;
        [self initWithUserData];
    }
    //名字｜男｜农历｜年｜月｜日｜时｜分｜是（闰）  9
    NSArray *arr = [_userString componentsSeparatedByString:USER_INFO_SEQ];
    //NSString *nameStr = [arr objectAtIndex:0];
    NSString *sexStr = [arr objectAtIndex:1];
    NSString *riLiStr = [arr objectAtIndex:2];
    NSString *yearStr = [arr objectAtIndex:3];
    NSString *monthStr = [arr objectAtIndex:4];
    NSString *dayStr = [arr objectAtIndex:5];
    NSString *hourStr = [arr objectAtIndex:6];
    NSString *isLeapStr = [arr objectAtIndex:8];
    
    //self.userNameTemp = nameStr;
    isLady0 = [sexStr isEqualToString:@"女"];
    isLunar0 = [riLiStr isEqualToString:@"农历"];
    year0 = yearStr.intValue;
    month0 = monthStr.intValue;
    day0 = dayStr.intValue;
    hour0 = hourStr.intValue;
    isLeap0 = [isLeapStr isEqualToString:@"是"];
    isLeapChecked0 = isLeap0;
    //NSString *hourString_temp = [MyDateHelper formateHour:hour0];
    
    if(isLeap0){
        [runButton setHidden:NO];
        [runLabel setHidden:NO];
        [runButton setSelected:YES];
    }
    if (!isLunar0) {
        [nongliButton setSelected:NO];
        [gongliButton setSelected:YES];
        isLunar0=NO;
    }else{
        [nongliButton setSelected:YES];
        [gongliButton setSelected:NO];
        isLunar0=YES;
    }
    [datePickerView setTintColor:RGB(51, 51, 51 )];
    [datePickerView selectRow:year0-1901 inComponent:0 animated:YES];
    [datePickerView selectRow:month0-1 inComponent:1 animated:YES];
    [datePickerView selectRow:day0-1 inComponent:2 animated:YES];
    [datePickerView selectRow:hour0 inComponent:3 animated:YES];
    [datePickerView reloadAllComponents];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self keyboardShowAction];
}

-(void)keyboardShowAction
{
    [self.view endEditing:YES];

      [UIView animateWithDuration:0.3f animations:^{
          self->myPickerView.frame=CGRectMake(self->myPickerView.frame.origin.x, SCREEN_HEIGHT-self->topPickHeight - WH_SCALE(13) - LL_TabbarSafeBottomMargin, self->myPickerView.frame.size.width, self->myPickerView.frame.size.height);

      } completion:^(BOOL finished){}];
}

//性别选择
-(void)userSexBtnAction:(id)sender
{
//    [self keyboardShowAction];

    UIButton *button=(UIButton *)sender;
    if (button.tag==10001)
    {
        [sexButton_man setSelected:YES];
        [sexButton_woman setSelected:NO];
        sexButton_man.layer.borderColor = GOLDNEWCOLOR.CGColor;
        sexButton_woman.layer.borderColor = [UIColor whiteColor].CGColor;
        
        sexValue_one=1;
        self.calculationString_one=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_one.text,sexValue_one==1?@"男":@"女",isLunar0?@"农历":@"公历",year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];

    }else
    {
        [sexButton_man setSelected:NO];
        [sexButton_woman setSelected:YES];
         sexButton_woman.layer.borderColor = GOLDNEWCOLOR.CGColor;
         sexButton_man.layer.borderColor = [UIColor whiteColor].CGColor;
        sexValue_one=0;
        self.calculationString_one=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_one.text,sexValue_one==1?@"男":@"女",isLunar0?@"农历":@"公历",year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];

    }
}

//八字选择
-(void)selectEditHoroscope:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==10001) {
        selected_one.hidden=NO;
        selected_two.hidden=YES;
        currentSelectType=1;
        if (isEditing_two) {
            UIButton *button_temp=[UIButton buttonWithType:UIButtonTypeCustom];
            button_temp.tag=10002;
            [self editHoroscopeAction:button_temp];
        }
        
    }else{
        selected_one.hidden=YES;
        selected_two.hidden=NO;
        currentSelectType=2;
        if (isEditing_one) {
            UIButton *button_temp=[UIButton buttonWithType:UIButtonTypeCustom];
            button_temp.tag=10001;
            [self editHoroscopeAction:button_temp];
        }
        
    }
    
    [self editHoroscopeAction:button];
}

-(void)editHoroscopeAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==10001) {
        if (!isEditing_one) {
            isEditing_one=YES;
            userStringLabel_one.hidden=YES;
            selectedBtn_one.hidden=YES;
            editingView_one.hidden=NO;
            editLabel_one.text=@"确认";
            [self setDatePickerState:self.calculationString_one];
            [self horoscopeBtnAction:button];
        }else{
            isEditing_one=NO;
            userStringLabel_one.hidden=NO;
            selectedBtn_one.hidden=NO;
            editingView_one.hidden=YES;
            editLabel_one.text=@"编辑";
            [userName_one resignFirstResponder];
            userStringLabel_one.text=[self explainUserString:self.calculationString_one];
            
            [self dateValueComformButtonClick];
        }
        
    }else if(button.tag==10002){
        if (!isEditing_two) {
            isEditing_two=YES;
            userStringLabel_two.hidden=YES;
            selectedBtn_two.hidden=YES;
            editingView_two.hidden=NO;
            editLabel_two.text=@"确认";
            [self setDatePickerState:self.calculationString_two];
            [self horoscopeBtnAction:button];
        }else{
            isEditing_two=NO;
            userStringLabel_two.hidden=NO;
            selectedBtn_two.hidden=NO;
            editingView_two.hidden=YES;
            editLabel_two.text=@"编辑";
            [userName_two resignFirstResponder];
            userStringLabel_two.text=[self explainUserString:self.calculationString_two];
            
            [self dateValueComformButtonClick];
        }
    }
}

-(void)horoscopeBtnAction:(id)sender
{
    
    isShow=YES;
    
    [UIView animateWithDuration:0.3f animations:^{
        self->horoscopeEditView.frame=CGRectMake(0, SCREEN_HEIGHT-self->topPickBgHeight, SCREEN_WIDTH, self->topPickBgHeight);
    } completion:^(BOOL finished){}];
    
    UIButton *button=(UIButton *)sender;
    if (button.tag==10001) {
        currentSelectType=1;
        [self setDatePickerState:self.calculationString_one];
        [userName_one resignFirstResponder];
    }
    
    if (button.tag==10002) {
        currentSelectType=2;
        [self setDatePickerState:self.calculationString_two];
        [userName_two resignFirstResponder];
    }
    
    [UIView beginAnimations:@"showPicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    myPickerView.frame=CGRectMake(myPickerView.frame.origin.x, SCREEN_HEIGHT-topPickHeight - WH_SCALE(13) - LL_TabbarSafeBottomMargin, myPickerView.frame.size.width, myPickerView.frame.size.height);
    [UIView commitAnimations];
    
    
}

-(void)dateValueComformButtonClick
{
    if (!isShow) {
        return;
    }
    
    isShow=NO;
    [UIView beginAnimations:@"hidePicker" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3f];
    myPickerView.frame=CGRectMake(myPickerView.frame.origin.x, SCREEN_HEIGHT, myPickerView.frame.size.width, myPickerView.frame.size.height);
    [UIView commitAnimations];
    
}

-(void)comfrimButtonAction
{
    [UIView animateWithDuration:0.3f animations:^{

        [self dateValueComformButtonClick];
        [self->userName_one resignFirstResponder];
        [self->userName_two resignFirstResponder];
    } completion:^(BOOL finished){

        if (!self.bzkChangeFlag)
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.calculationString_one forKey:LOCKED_USERSTRING_DEFUAL];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        if (self.ChangeBaziBlock)
        {
            self.ChangeBaziBlock(self.calculationString_one);
        }
        
//        if ([self->changeDelegate respondsToSelector:@selector(finishEditHoroscope:)]) {
//            [changeDelegate performSelector:@selector(finishEditHoroscope:) withObject:self.calculationString_one];
//        }
        
         [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)initDatePickView
{
    myPickerView=[[UIView alloc] initWithFrame:CGRectMake(WH_SCALE(0), SCREEN_HEIGHT, SCREEN_WIDTH, topPickHeight)];
    [myPickerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:myPickerView];
    
    UIView *pickerToolBg=[[UIView alloc] initWithFrame:CGRectMake( 0, 0, myPickerView.width, WH_SCALE(42))];
    //pickerToolBg.image=[UIImage imageNamed:@"toolbar_bg_1.png"];
    pickerToolBg.backgroundColor=[UIColor whiteColor];
    pickerToolBg.layer.masksToBounds = YES;
    pickerToolBg.userInteractionEnabled = YES;
    [myPickerView addSubview:pickerToolBg];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:pickerToolBg.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerTopRight cornerRadii:CGSizeMake( WH_SCALE(8), WH_SCALE(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = pickerToolBg.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    pickerToolBg.layer.mask = maskLayer;


    //删除旧代码直接替换
    [self showGongliSwitchBtnActionView:@"公历" btn2Name:@"农历" leftVc:[UIView new] rightVc:[UIView new] supView:myPickerView];
    
    runButton=[UIButton buttonWithType:UIButtonTypeCustom];
    runButton.frame=CGRectMake(CGRectGetMaxX(nongliButton.frame)+WH_SCALE(9), WH_SCALE(24), WH_SCALE(20), WH_SCALE(20));
    runButton.hidden=YES;
    [runButton setImage:[UIImage imageNamed:@"xieyi1.png"] forState:UIControlStateNormal];
    [runButton setImage:[UIImage imageNamed:@"xieyi2.png"] forState:UIControlStateSelected];
    [runButton addTarget:self action:@selector(runBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [myPickerView addSubview:runButton];
    
    runLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(runButton.frame), runButton.top, WH_SCALE(30), WH_SCALE(20))];
    runLabel.text=@"闰月";
    runLabel.hidden=YES;
    runLabel.textColor= RGB(180, 180, 180);
    runLabel.backgroundColor=[UIColor clearColor];
    runLabel.font=FONT_MEDIUM(13);
    [myPickerView addSubview:runLabel];

    int showPickY = showBaziFlag ? pickerToolBg.bottom + WH_SCALE(22) : pickerToolBg.bottom +  WH_SCALE(2);
    datePickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, showPickY ,myPickerView.width , WH_SCALE(190))];
    datePickerView.dataSource=self;
    datePickerView.backgroundColor = [UIColor whiteColor];
    datePickerView.delegate=self;
    datePickerView.layer.masksToBounds = YES;
//    datePickerView.showsSelectionIndicator=YES;
    [myPickerView addSubview:datePickerView];
    
    UIBezierPath *maskPickPath = [UIBezierPath bezierPathWithRoundedRect:datePickerView.bounds byRoundingCorners:UIRectCornerBottomLeft  | UIRectCornerBottomRight cornerRadii:CGSizeMake( WH_SCALE(8), WH_SCALE(8))];
    CAShapeLayer *maskPickLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskPickLayer.frame = datePickerView.bounds;
    //设置图形样子
    maskPickLayer.path = maskPickPath.CGPath;
    datePickerView.layer.mask = maskPickLayer;


    if (!showBaziFlag)
    {
        [runButton setFrame:CGRectMake( WH_SCALE(13), WH_SCALE(16), WH_SCALE(20), WH_SCALE(20))];
        [runLabel setFrame:CGRectMake( runButton.right + WH_SCALE(6), runButton.top, WH_SCALE(40), WH_SCALE(20))];

        COWSHOW_DEFUAL_TITLE_UIBUTTON(sureBtn, CGRectMake(SCREEN_WIDTH - WH_SCALE(67), WH_SCALE(9.5), WH_SCALE(50), WH_SCALE(30)), @"确认", FONT_MEDIUM(12), GOLDNEWCOLOR, [UIColor clearColor], myPickerView)
        sureBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [sureBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender)
        {
            [self comfrimButtonAction];
        }];

        COWSHOW_DEFUAL_LINE_UILABLE(botline, CGRectMake(0,  WH_SCALE(50), SCREEN_WIDTH, 1), RGB(236, 236, 236), myPickerView)
    }
    
}

-(void)initWithUserData
{
    if (self.calculationString_one) {
        NSArray *arr_temp=[[self explainUserString:self.calculationString_one] componentsSeparatedByString:@" "];
        if ([arr_temp count]==0) {
            return;
        }
        userName_one.text=[arr_temp objectAtIndex:0];

        //当前的可设置多个颜色
        [self getLableShowHadLbTitleColor:@[[NSString stringWithFormat:@"   %@  ",[arr_temp objectAtIndex:2]], [arr_temp objectAtIndex:3], @""] textColor:@[RGB(119, 119, 119),RGB(119, 119, 119),RGB(119, 119, 119)] textFont:@[FONT_MEDIUM(13),FONT_MEDIUM(13),FONT_MEDIUM(13)] titleLb:horoscopeLabel_one];

        if ([(NSString*)[arr_temp objectAtIndex:1] compare:@"男"]==0)
        {
            sexValue_one=1;
            [sexButton_man setSelected:YES];
            [sexButton_woman setSelected:NO];
            sexButton_man.layer.borderColor = GOLDNEWCOLOR.CGColor;
            sexButton_woman.layer.borderColor = [UIColor whiteColor].CGColor;
        }else{
            sexValue_one=0;
            [sexButton_man setSelected:NO];
            [sexButton_woman setSelected:YES];
            sexButton_man.layer.borderColor = [UIColor whiteColor].CGColor;
            sexButton_woman.layer.borderColor = GOLDNEWCOLOR.CGColor;
        }
    }
    
    if (self.calculationString_two) {
        NSArray *arr_temp=[[self explainUserString:self.calculationString_two] componentsSeparatedByString:@" "];
        if ([arr_temp count]==0) {
            return;
        }
        userName_two.text=[arr_temp objectAtIndex:0];
        [userSexBtn_two setTitle:[arr_temp objectAtIndex:1] forState:UIControlStateNormal];
        [userSexBtn_two setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        horoscopeLabel_two.text=[NSString stringWithFormat:@"%@ %@",[arr_temp objectAtIndex:2],[arr_temp objectAtIndex:3]];
        if ([(NSString*)[arr_temp objectAtIndex:1] compare:@"男"]==0) {
            sexValue_two=1;
        }else{
            sexValue_two=0;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark 八字界面
-(void)commendAction:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"测算"])
    {
        if ([userName_one.text length] > 5)
        {
            [CowUtils showbotToastActionShort:@"当前名字长度不符合、超过5个字"];
            return;
        }
    }
   
    switch (button.tag) {
        case 10001:
        {
            [UIView animateWithDuration:0.3f animations:^{
                [self->myPickerView setFrameY:SCREEN_HEIGHT];
                self->horoscopeEditView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self->topPickBgHeight);
                [self dateValueComformButtonClick];
                [self->userName_one resignFirstResponder];
                [self->userName_two resignFirstResponder];
            } completion:^(BOOL finished){
                [self dismissViewControllerAnimated:NO completion:nil];
            }];
            break;
        }
        case 10002:
        {
            [UIView animateWithDuration:0.3f animations:^{

                [self->myPickerView setFrameY:SCREEN_HEIGHT];
                
                self->horoscopeEditView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self->topPickBgHeight);
                
                [self dateValueComformButtonClick];
                [self->userName_one resignFirstResponder];
                [self->userName_two resignFirstResponder];
            } completion:^(BOOL finished){
                
                if (!self.bzkChangeFlag)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:self.calculationString_one forKey:LOCKED_USERSTRING_DEFUAL];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }

                if (self.ChangeBaziBlock)
                {
                    self.ChangeBaziBlock(self.calculationString_one);
                }

                [self dismissViewControllerAnimated:NO completion:nil];
            }];
            break;
        }
        default:
            break;
    }
    
    
    if (self.Viewblock)
    {
        self.Viewblock(YES);
    }
}

//显示的八字界面、另一个样式
-(void)showPickViewUI
{
    topPickBgHeight = WH_SCALE(230);
    horoscopeEditView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, topPickBgHeight)];//SCREEN_HEIGHT-396.0
      horoscopeEditView.backgroundColor= [UIColor whiteColor];
      horoscopeEditView.layer.masksToBounds = YES;
      [self.view addSubview:horoscopeEditView];

       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:horoscopeEditView.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerTopRight cornerRadii:CGSizeMake( WH_SCALE(8), WH_SCALE(8))];
      CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
      //设置大小
      maskLayer.frame = horoscopeEditView.bounds;
      //设置图形样子
      maskLayer.path = maskPath.CGPath;
      horoscopeEditView.layer.mask = maskLayer;

}

//显示八字的界面信息
-(void)initWithHoroscopeEditView
{
    
    horoscopeEditView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, topPickBgHeight)];//SCREEN_HEIGHT-396.0
    horoscopeEditView.backgroundColor= [UIColor whiteColor];
    horoscopeEditView.layer.masksToBounds = YES;
    [self.view addSubview:horoscopeEditView];
    
     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:horoscopeEditView.bounds byRoundingCorners:UIRectCornerTopLeft  | UIRectCornerTopRight cornerRadii:CGSizeMake( WH_SCALE(8), WH_SCALE(8))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = horoscopeEditView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    horoscopeEditView.layer.mask = maskLayer;

    
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake( WH_SCALE(13), WH_SCALE(10), WH_SCALE(50), WH_SCALE(26));
    cancelButton.tag=10001;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, -WH_SCALE(25), 0, 0);
    [cancelButton setTitleColor:self.topTitleColor forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:FONT_MEDIUM(12)];
    [cancelButton addTarget:self action:@selector(commendAction:) forControlEvents:UIControlEventTouchUpInside];
    [horoscopeEditView addSubview:cancelButton];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, WH_SCALE(8), SCREEN_WIDTH, 35.0)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.text=@"输入八字";
    titleLabel.font= FONT_MEDIUM(14);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=RGB(51, 51, 51);
    [horoscopeEditView addSubview:titleLabel];
    
    UIButton *submitButton=[UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame=CGRectMake(SCREEN_WIDTH-WH_SCALE(63), WH_SCALE(10), WH_SCALE(50), cancelButton.height);
    submitButton.tag=10002;
    [submitButton setTitle:@"测算" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:FONT_MEDIUM(12)];
    submitButton.titleEdgeInsets = UIEdgeInsetsMake(0, WH_SCALE(25), 0, 0);
    [submitButton setTitleColor:GOLDNEWCOLOR forState:UIControlStateNormal];
//    [submitButton setBackgroundImage:[UIImage imageNamed:@"record_btn3.png"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(commendAction:) forControlEvents:UIControlEventTouchUpInside];
    [horoscopeEditView addSubview:submitButton];

    COWSHOW_DEFUAL_LINE_UILABLE(lineLb, CGRectMake(0, WH_SCALE(45), SCREEN_WIDTH, 1), RGB(216, 216, 216), horoscopeEditView)

    int sizeLbY = WH_SCALE(26);
    UILabel *nameLabel1=[[UILabel alloc] initWithFrame:CGRectMake( cancelButton.left, lineLb.bottom + WH_SCALE(18), WH_SCALE(35), WH_SCALE(25))];
    nameLabel1.backgroundColor=[UIColor clearColor];
    nameLabel1.text=@"姓名";
    nameLabel1.textAlignment = NSTextAlignmentLeft;
    nameLabel1.font = FONT_MEDIUM(12);
    nameLabel1.textColor=self.topTitleColor;
    [horoscopeEditView addSubview:nameLabel1];
    
//    userName_one=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel1.frame), nameLabel1.top - (WH_SCALE(38) - nameLabel1.height)/2, WH_SCALE(256), WH_SCALE(38))];
    [userName_one setFrame:CGRectMake(CGRectGetMaxX(nameLabel1.frame), nameLabel1.top - (WH_SCALE(38) - nameLabel1.height)/2, WH_SCALE(256), WH_SCALE(38))];
    userName_one.backgroundColor= RGB(243, 243, 243);
    userName_one.font=FONT_MEDIUM(12);
    userName_one.clearButtonMode=UITextFieldViewModeWhileEditing;
    userName_one.textColor=[UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1.0];
    userName_one.layer.masksToBounds = YES;
    userName_one.layer.cornerRadius = WH_SCALE(10);
    userName_one.borderStyle=UITextBorderStyleNone;
    userName_one.delegate=self;
    [horoscopeEditView addSubview:userName_one];
    
    //后期再优化喔、直接修改
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, userName_one.height)];
    userName_one.leftView = paddingView1;
    userName_one.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *sexLabel1=[[UILabel alloc] initWithFrame:CGRectMake(nameLabel1.left, CGRectGetMaxY(nameLabel1.frame) + sizeLbY, nameLabel1.width, nameLabel1.height)];
    sexLabel1.backgroundColor=[UIColor clearColor];
    sexLabel1.text=@"性别";
    sexLabel1.textAlignment = NSTextAlignmentLeft;
    sexLabel1.textColor=self.topTitleColor;
    sexLabel1.font=FONT_MEDIUM(12);
    [horoscopeEditView addSubview:sexLabel1];
    
    sexButton_man=[UIButton buttonWithType:UIButtonTypeCustom];
    sexButton_man.frame=CGRectMake(userName_one.left, userName_one.bottom + WH_SCALE(9), WH_SCALE(122), WH_SCALE(38));
    sexButton_man.tag=10001;
    sexButton_man.selected = YES;
    sexButton_man.layer.masksToBounds = YES;
    [sexButton_man setTitle:@"男" forState:UIControlStateNormal];
    sexButton_man.titleLabel.font=FONT_MEDIUM(13);
    sexButton_man.layer.cornerRadius = WH_SCALE(10);

    [sexButton_man setBackgroundImage:[CowUtils createImageWithColor:RGB(254, 239, 215)] forState:UIControlStateNormal];
    [sexButton_man setBackgroundImage:[CowUtils createImageWithColor:RGB(252, 177, 57)] forState:UIControlStateSelected];
    [sexButton_man setBackgroundImage:[CowUtils createImageWithColor:RGB(254, 239, 215)] forState:UIControlStateHighlighted];
    [sexButton_man setTitleColor:RGB(252, 177, 57) forState:UIControlStateNormal];
    [sexButton_man setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    [sexButton_man addTarget:self action:@selector(userSexBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [horoscopeEditView addSubview:sexButton_man];
    
    sexButton_woman=[UIButton buttonWithType:UIButtonTypeCustom];
    sexButton_woman.frame=CGRectMake(sexButton_man.right + WH_SCALE(9), sexButton_man.top, sexButton_man.width, sexButton_man.height);
    [sexButton_woman setTitle:@"女" forState:UIControlStateNormal];
    sexButton_woman.tag=10002;
    sexButton_woman.layer.masksToBounds = YES;
    sexButton_woman.layer.cornerRadius = WH_SCALE(10);

    [sexButton_woman setBackgroundImage:[CowUtils createImageWithColor:RGB(254, 239, 215)] forState:UIControlStateNormal];
    [sexButton_woman setBackgroundImage:[CowUtils createImageWithColor:RGB(252, 177, 57)] forState:UIControlStateSelected];
    [sexButton_woman setBackgroundImage:[CowUtils createImageWithColor:RGB(254, 239, 215)] forState:UIControlStateHighlighted];
    [sexButton_woman setTitleColor:RGB(252, 177, 57) forState:UIControlStateNormal];
    [sexButton_woman setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    sexButton_woman.titleLabel.font=FONT_MEDIUM(13);
    [sexButton_woman addTarget:self action:@selector(userSexBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [horoscopeEditView addSubview:sexButton_woman];
    
    UILabel *dateLabel1=[[UILabel alloc] initWithFrame:CGRectMake(nameLabel1.left, CGRectGetMaxY(sexLabel1.frame) + sizeLbY, nameLabel1.width, nameLabel1.height)];
    dateLabel1.backgroundColor=[UIColor clearColor];
    dateLabel1.text=@"生日";
    dateLabel1.textAlignment = NSTextAlignmentLeft;
    dateLabel1.textColor=self.topTitleColor;
    dateLabel1.font=FONT_MEDIUM(12);
    [horoscopeEditView addSubview:dateLabel1];
    
    horoscopeLabel_one=[[UILabel alloc] initWithFrame:CGRectMake(sexButton_man.left, sexButton_man.bottom + WH_SCALE(9), WH_SCALE(257), WH_SCALE(38))];
    horoscopeLabel_one.backgroundColor=RGB(243, 243, 243);
    horoscopeLabel_one.layer.masksToBounds = YES;
    horoscopeLabel_one.layer.cornerRadius = WH_SCALE(10);
    horoscopeLabel_one.font= FONT_MEDIUM(14);
    horoscopeLabel_one.textColor=[UIColor blackColor];
    [horoscopeEditView addSubview:horoscopeLabel_one];
    [dateLabel1 setFrameY:horoscopeLabel_one.top + ((WH_SCALE(38) - dateLabel1.height)/2)];
    
    UIButton *horoscopeLabelBtn_one=[UIButton buttonWithType:UIButtonTypeCustom];
    horoscopeLabelBtn_one.frame=horoscopeLabel_one.frame;
    horoscopeLabelBtn_one.tag=10001;
    [horoscopeLabelBtn_one addTarget:self action:@selector(horoscopeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [horoscopeEditView addSubview:horoscopeLabelBtn_one];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showPickViewAction];

}

-(void)showPickViewAction
{

    self.view.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    self.topTitleColor = RGB(170, 170, 170);
    sexValue_one=1;
    sexValue_two=0;
    currentSelectType=1;
    isEditing_one=NO;
    isEditing_two=NO;
    isShow=NO;
    self.calculationString_one=self.currentString_one;
    self.calculationString_two=self.currentString_two;

    self.view.layer.masksToBounds=YES;

    bgView=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.3;
    bgView.tag = 10001;
    [bgView handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
        [self commendAction:sender];
    }];
    //    bgView.hidden = YES;
    [self.view addSubview:bgView];


    userName_one = [[UITextField alloc] init];
    //展示八字的pickview
    if (showBaziFlag)
    {
        [self initWithHoroscopeEditView];
    }else
    {
        //只有时间选择器的
        [self showPickViewUI];
    }

    [self initWithUserData];

    [self initDatePickView];

    [UIView animateWithDuration:0.3f animations:^{
            self->horoscopeEditView.frame=CGRectMake(0, SCREEN_HEIGHT-self->topPickBgHeight, SCREEN_WIDTH, self->topPickBgHeight);
    } completion:^(BOOL finished){}];

    UIButton *button_temp=[UIButton buttonWithType:UIButtonTypeCustom];
    button_temp.tag=10001;
    [self editHoroscopeAction:button_temp];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - 日期选择器

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(component==0)
    {
        return WH_SCALE(80);
    }
    else if(component==1)
    {
        return WH_SCALE(55);
    }
    else if(component==2)
    {
        return WH_SCALE(55);
    }
    else
    {
        return WH_SCALE(80);
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return WH_SCALE(34);
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        return [[dateFormatter stringFromDate:[NSDate date]] intValue] - 1900;
    }else if(component == 1)
    {
        return 12;
    }else if(component == 2)
    {
       long int year = [pickerView selectedRowInComponent:0] + 1901;
       long int month = [pickerView selectedRowInComponent:1] + 1;
        BOOL isNongLi = NO;
        isNongLi = isLunar0;
        return [MyDateHelper dayOfMonthInYear:(int)year inMonth:(int)month ifNongLi:isNongLi];
    }else if(component == 3)
    {
        return 24;
    }
    
    return 0;
}

// 重写方法

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        [pickerLabel setTextColor:RGB(51, 51, 51)];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:WH_SCALE(17)]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%d年",(int)row+1901];
            break;
        case 1:
            return [NSString stringWithFormat:@"%d月",(int)row+1];
            break;
        case 2:
            return [NSString stringWithFormat:@"%d日",(int)row+1];
            break;
        case 3:
        {
            NSString * hourStr = [MyDateHelper formateHour:(int)row];
            return [NSString stringWithFormat:@"%@时",hourStr];
            break;
        }
        default:
            return @"";
            break;
    }
}

#pragma mark - 更新日期选择器
-(void)updateDateSetViewAndDataCache{
    BOOL isNongLi = NO;
    BOOL isRunYueShouldShow = NO;
    BOOL isRunYueChecked = NO;
    isNongLi = isLunar0;
    
    
    if(isNongLi)
    {
        NSInteger year = [datePickerView selectedRowInComponent:0]+1901;
        NSInteger month = [datePickerView selectedRowInComponent:1]+1;

        //iphone6/p 闰月解释为1 5及其他则正常解析润月份
        NSInteger moneyStr = (year == 1938 ? 7 : year == 1941 ? 6: year == 1944 ? 4 : year == 1947 ? 2 : year == 1949 ? 7 : year == 1952 ? 5 : year == 1955 ? 3 : year == 1957 ? 8: year == 1960 ? 6 : year == 1963 ? 4 : year == 1966 ? 3 : year == 1968 ? 7 : year == 1971 ? 5 : year == 1974 ? 4: year == 1976 ? 8 : year == 1979 ? 6 : year == 1982 ? 4 : year == 1984 ? 10 : year == 1987 ? 6 : year == 1990 ? 5: year == 1993 ? 3 : year == 1995 ? 8 : year == 1998 ? 5 : year == 2001 ? 4 : year == 2004 ? 2 : year == 2006 ? 7 : year == 2009 ? 5 : year == 2012 ? 4 : year == 2014 ? 9 : year == 2017 ? 6 : year == 2020 ? 4  : year == 2023 ? 2 :  13 );

        for (int i = 1938; i<2024; i++)
        {
            if (i%3==0)
            {
                if (month == moneyStr)
                {
                    isRunYueShouldShow = YES;

                }else
                {
                    isRunYueShouldShow = NO;
                }
            }
        }

      if(isRunYueShouldShow)
        {
            //显示闰月
            [runButton setHidden:NO];
            [runLabel setHidden:NO];
            isRunYueChecked=runButton.isSelected;
        }else
        {
            [runButton setHidden:YES];
            [runLabel setHidden:YES];
            isRunYueChecked = NO;
            [runButton setSelected:NO];
        }
    }else{
        isRunYueShouldShow = NO;
        isRunYueChecked = NO;
        [runButton setSelected:NO];
        [runButton setHidden:YES];
        [runLabel setHidden:YES];
    }
    
    isLeapChecked0=isRunYueChecked;
    isLeap0 = isRunYueShouldShow;
    
    year0 = [datePickerView selectedRowInComponent:0]+1901;
    month0 = [datePickerView selectedRowInComponent:1]+1;
    day0 = [datePickerView selectedRowInComponent:2]+1;
    hour0 = [datePickerView selectedRowInComponent:3];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [datePickerView reloadComponent:2];
            break;
        case 1:
            [datePickerView reloadComponent:2];
            break;
        default:
            break;
    }


    [self updateDateSetViewAndDataCache];
    [self showBirth_editingBirthLabel:0];
}

#pragma mark - 显示日期
-(void)showBirth_editingBirthLabel:(int)index{
    if (index == 0) {
        NSString *riLiStr = isLunar0?@"农历":@"公历";

        if (currentSelectType==1) {
            self.calculationString_one=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_one.text,sexValue_one==1?@"男":@"女",riLiStr,year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];
            
        }else if(currentSelectType==2){
            self.calculationString_two=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_two.text,sexValue_two==1?@"男":@"女",riLiStr,year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];
        }
        [self initWithUserData];

    }
}

#pragma mark - 公历按钮点击
-(void)gongLiBtnPressed:(id)sender{
    [nongliButton setSelected:NO];
    [gongliButton setSelected:YES];
    if (isLunar0) {
        isLunar0 = NO;
        isLeap0 = NO;
        isLeapChecked0 = NO;
        [runButton setHidden:!isLeap0];
        [runLabel setHidden:!isLeap0];
        runButton.selected = isLeapChecked0;
        [datePickerView reloadComponent:2];
        [self showBirth_editingBirthLabel:0];
    }
}
#pragma mark - 农历按钮点击
-(void)nongLiBtnPressed:(id)sender{
    [nongliButton setSelected:YES];
    [gongliButton setSelected:NO];

    if (!isLunar0)
       {
           //切换不显示闰月
           isLunar0 = YES;
           NSInteger year = [datePickerView selectedRowInComponent:0]+1901;
           NSInteger month = [datePickerView selectedRowInComponent:1]+1;
           isLeap0 = [MyDateHelper leapMonthOfYear:(int)year] == month;
           isLeapChecked0 = NO;

           NSInteger moneyStr = (year == 1938 ? 7 : year == 1941 ? 6: year == 1944 ? 4 : year == 1947 ? 2 : year == 1949 ? 7 : year == 1952 ? 5 : year == 1955 ? 3 : year == 1957 ? 8: year == 1960 ? 6 : year == 1963 ? 4 : year == 1966 ? 3 : year == 1968 ? 7 : year == 1971 ? 5 : year == 1974 ? 4: year == 1976 ? 8 : year == 1979 ? 6 : year == 1982 ? 4 : year == 1984 ? 10 : year == 1987 ? 6 : year == 1990 ? 5: year == 1993 ? 3 : year == 1995 ? 8 : year == 1998 ? 5 : year == 2001 ? 4 : year == 2004 ? 2 : year == 2006 ? 7 : year == 2009 ? 5 : year == 2012 ? 4 : year == 2014 ? 9 :  year == 2017 ? 6 : year == 2020 ? 4  : year == 2023 ? 2 :13 );

           for (int i = 1938; i<2024; i++)
           {
               if (i%3==0)
               {
                   if (month == moneyStr)
                   {

                       [runButton setHidden:NO];
                       [runLabel setHidden:NO];
                   }else
                   {
                       [runButton setHidden:YES];
                       [runLabel setHidden:YES];
                   }
               }
           }
           runButton.selected = isLeapChecked0;
           [datePickerView reloadComponent:2];
           [self showBirth_editingBirthLabel:0];
       }

}

#pragma mark - 闰月按钮点击
-(void)runBtnPressed:(id)sender{
    isLeapChecked0 = !isLeapChecked0;
    runButton.selected = isLeapChecked0;
    [self showBirth_editingBirthLabel:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (isShow) {
        [self dateValueComformButtonClick];
    }
    textField.text=@"";
    //    [textField selectAll:self];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==userName_one) {
        self.calculationString_one=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_one.text,sexValue_one==1?@"男":@"女",isLunar0?@"农历":@"公历",year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];
    }
    if (textField==userName_two) {
        self.calculationString_two=[NSString stringWithFormat:@"%@|%@|%@|%ld|%ld|%ld|%ld|%@|%@",userName_two.text,sexValue_two==1?@"男":@"女",isLunar0?@"农历":@"公历",year0,month0,day0,hour0,@"0",isLeapChecked0?@"是":@"否"];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
//    NSDictionary*info=[notification userInfo];
//    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    float topHeight=20.0;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        topHeight=0.0;
    }
    horoscopeEditView.frame=CGRectMake(0, SCREEN_HEIGHT-topPickBgHeight, SCREEN_WIDTH, topPickBgHeight);
}

#pragma mark 菜鸡旧代码直接修改
-(UIView*)showGongliSwitchBtnActionView:(NSString*)btn1Name btn2Name:(NSString*)btn2Name leftVc:(UIView*)leftVc rightVc:(UIView*)rightVc supView:(UIView*)supView
{
    rightVc.hidden = YES;

    int showY = WH_SCALE(13);
    if (showBaziFlag)
    {
        COWSHOW_DEFUAL_LINE_UILABLE(topline, CGRectMake(0, WH_SCALE(8), SCREEN_WIDTH, 1), RGB(236, 236, 236), supView)
        COWSHOW_DEFUAL_LINE_UILABLE(botline, CGRectMake(0, WH_SCALE(58), SCREEN_WIDTH, 1), RGB(236, 236, 236), supView)
    }else
    {
       showY = WH_SCALE(9);
    }

    UIView * showBtnVc = [UIView new];
    showBtnVc.frame = CGRectMake(0, showY, SCREEN_WIDTH, WH_SCALE(40));
    showBtnVc.backgroundColor = [UIColor clearColor];
    [supView addSubview:showBtnVc];
    
    __block bool _isRightFlag = NO;
    __block UIButton * topBtn[2];
    __block UIButton * leftSelectBtn;
    __block UIButton * rightSelectBtn;
    
    for (int i = 0; i < 2; i ++)
    {
        topBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        int showtapX = showBaziFlag ? WH_SCALE(85) : WH_SCALE(85);
        int showtapY = showBaziFlag ? WH_SCALE(3) : WH_SCALE(0);
        topBtn[i].frame = CGRectMake(showtapX+i*WH_SCALE(77), showtapY, WH_SCALE(77), WH_SCALE(32));
        [topBtn[i] setTitle:i == 0 ? btn1Name : btn2Name forState:UIControlStateNormal];
        topBtn[i].tag = 100 + i;
        [topBtn[i] setTitleColor: [UIColor whiteColor] forState:UIControlStateSelected];
        [topBtn[i] setTitleColor:RGBA(252, 177, 57, 1)  forState:UIControlStateNormal];
        [topBtn[i] setBackgroundImage:[CowUtils createImageWithColor:RGBA(254, 239, 215, 1)] forState:UIControlStateNormal];
        [topBtn[i] setBackgroundImage:[CowUtils createImageWithColor:RGBA(252, 177, 57, 1)] forState:UIControlStateSelected];

        topBtn[i].selected = i == 1 ? NO : YES;
        topBtn[i].titleLabel.font = [UIFont boldSystemFontOfSize:14];

        UIRectCorner cellCor = i == 0 ? (UIRectCornerTopLeft  | UIRectCornerBottomLeft) : (UIRectCornerTopRight  | UIRectCornerBottomRight);
        [self showViewBezierPathType:cellCor layerRadii:CGSizeMake( WH_SCALE(10), WH_SCALE(10)) supLayer:topBtn[i]];

        if (i == 0)
        {
            leftSelectBtn = topBtn[0];
            gongliButton = leftSelectBtn;
        }else
        {
            rightSelectBtn = topBtn[1];
            nongliButton = rightSelectBtn;
        }
        
        [topBtn[i] handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton * sender)
         {
             _isRightFlag = (sender.tag == 100) ? YES : NO;
          
             if (!_isRightFlag)
             {
                 [[rightSelectBtn superview] insertSubview:rightSelectBtn aboveSubview:leftSelectBtn];
                   [self nongLiBtnPressed:sender];
             }else
             {
                 [[leftSelectBtn superview] insertSubview:leftSelectBtn aboveSubview:rightSelectBtn];
               
                 [self gongLiBtnPressed:sender];
             }
             
             [leftSelectBtn setSelected:_isRightFlag];
             [rightSelectBtn setSelected:!_isRightFlag];
             
             [UIView animateWithDuration:0.4f animations:^{
                 
                 if (_isRightFlag)
                 {
                     leftVc.hidden = NO;
                     rightVc.hidden = YES;
                 }else
                 {
                     leftVc.hidden = YES;
                     rightVc.hidden = NO;
                 }
             } completion:^(BOOL finished)
              {
                  
                
              }];
         }];
        [showBtnVc addSubview:topBtn[i]];
        
    }
    
    
    [[leftSelectBtn superview] insertSubview:leftSelectBtn aboveSubview:rightSelectBtn];
    return showBtnVc;
}

//生日的多段文字颜色显示
-(UILabel*)getLableShowHadLbTitleColor:(NSArray*)titleArr textColor:(NSArray*)textColorArr textFont:(NSArray*)textFontArr titleLb:(UILabel*)titleLb
{
    NSString * leftStr = titleArr[0];
    NSString * midStr = titleArr[1];
    NSString * rightStr = titleArr[2];

    if (![midStr containsString:@"/"])
    {
        midStr = [midStr stringByReplacingOccurrencesOfString:@"年" withString:@"年/"];
        midStr = [midStr stringByReplacingOccurrencesOfString:@"月" withString:@"月/"];
        midStr = [midStr stringByReplacingOccurrencesOfString:@"日" withString:@"日/"];
    }
    NSString * showTitleStr = CowNSStringFormat(@"%@%@%@",leftStr,midStr,rightStr);

    //颜色
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showTitleStr];
    NSRange range1 = [[str string] rangeOfString:leftStr];
    [str addAttribute:NSForegroundColorAttributeName value:textColorArr[0] range:range1];
    [str addAttribute:NSFontAttributeName value:textFontArr[0] range:range1];
    
    NSRange range2 = [[str string] rangeOfString:midStr];
    [str addAttribute:NSForegroundColorAttributeName value:textColorArr[1] range:range2];
    [str addAttribute:NSFontAttributeName value:textFontArr[1] range:range2];
    
    NSRange range3 = [[str string] rangeOfString:rightStr];
    [str addAttribute:NSForegroundColorAttributeName value:textColorArr[2] range:range3];
    [str addAttribute:NSFontAttributeName value:textFontArr[2] range:range3];
    
    titleLb.attributedText = str;
    return titleLb;
}

//指定倒角
-(void)showViewBezierPathType:(UIRectCorner)corners layerRadii:(CGSize)cornerRadii supLayer:(UIView*)supView
{

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:supView.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = supView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    supView.layer.mask = maskLayer;
}

-(UIColor*)topCancelTitleColor
{
    if (!_topTitleColor)
    {
        _topTitleColor = RGB(170, 170, 170);
    }
    return _topTitleColor;
}

@end


