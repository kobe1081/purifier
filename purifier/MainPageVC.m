//
//  MainPageVC.m
//  purifier
//
//  Created by Tony on 15/11/25.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "MainPageVC.h"

#define SHUTDOWNTAG 100   //关闭空气净化器选择界面的背景
#define BUTTONSTARTTAG 200    //选择关闭空气净化器的按钮Tag起始值
#define SHUTDOWNBGTAG 300    //关闭控制的背景
#define SHUTDOWNNOW 301     //立刻关闭
#define SHUTDOWNSETNUM 302   //设置时间
#define SETNUMOPERATION 400
#define SETSHUTDOWNHOUR 500


@interface MainPageVC ()
{
    
}
@property(strong,nonatomic)IBOutlet UIImageView *qualityBG;
@property(strong,nonatomic)UIView *dismissView;
@property(assign,nonatomic)BOOL isShowingShotDown;

@end

@implementation MainPageVC
@synthesize qualityBG;
@synthesize dismissView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = @"Air Purifier 1";
    [label sizeToFit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialization];
    [self initView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)initialization
{
    self.isShowingShotDown = NO;
}

- (void)initView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"switchIcon.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"switchIcon.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    qualityBG.image = [UIImage imageNamed:@"goodQualityBG"];
    dismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    dismissView.backgroundColor = [UIColor blackColor];
    dismissView.hidden = YES;
    dismissView.alpha = 0.7;
    [self.view addSubview:dismissView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewGes:)];
    tapGes.numberOfTapsRequired = 1;
    tapGes.numberOfTouchesRequired = 1;
    [dismissView addGestureRecognizer:tapGes];
}

- (void)dismissViewGes:(UITapGestureRecognizer *)ges
{
    self.isShowingShotDown = NO;
    UIView *mydismissView = ges.view;
    mydismissView.hidden = YES;
    
    UIView *alertview = [self.view viewWithTag:SHUTDOWNTAG];
    if (!alertview) {
        alertview = [self.view viewWithTag:SHUTDOWNBGTAG];
    }
    if (!alertview) {
        alertview = [self.view viewWithTag:SETNUMOPERATION];
    }
    if (!alertview) {
        alertview = [self.view viewWithTag:SETSHUTDOWNHOUR];
    }
    [alertview removeFromSuperview];
}

- (void)switchButtonClick:(id)sender
{
    //关闭空气净化器
    if (self.isShowingShotDown) {
        return;
    }
    self.isShowingShotDown = YES;
    [self.view addSubview:dismissView];
    dismissView.hidden = NO;
    
    UIImage *topBgImage = [UIImage imageNamed:@"NavBarIOS7"];
    
    CGFloat alertViewW = 250;
    CGFloat alertViewH = 250;
    CGFloat alertViewX = (ScreenWidth - alertViewW) / 2.0;
    CGFloat alertViewY = 100;
    UIView *shutDownAlert = [[UIView alloc] init];
    shutDownAlert.tag = SHUTDOWNTAG;
    shutDownAlert.frame = CGRectMake(alertViewX, alertViewY, alertViewW, alertViewH);
    shutDownAlert.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertViewW, 40)];
    topLabel.backgroundColor = [UIColor colorWithPatternImage:topBgImage];
    topLabel.font = [UIFont boldSystemFontOfSize:20.0];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = @"PLEASE SELECT";
    [shutDownAlert addSubview:topLabel];
    
    shutDownAlert.userInteractionEnabled = YES;
    
    NSArray *buttonArray = @[@"Shut Down",@"Set Number of Hours of Operation",@"Cancel"];
    for (int i = 0; i < [buttonArray count]; i++) {
        CGFloat buttonDistance = 20;
        CGFloat buttonX = 15;
        CGFloat buttonW = alertViewW - 2 * buttonX;
        CGFloat buttonH = (alertViewH - topLabel.frame.size.height - ([buttonArray count] + 1) * buttonDistance) / [buttonArray count];
        CGFloat buttonY = (i + 1) * buttonDistance + i * buttonH + topLabel.frame.size.height;
        UIButton *functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        functionButton.layer.borderColor = [UIColor blackColor].CGColor;
        functionButton.layer.borderWidth = 1.0;
        functionButton.tag = i + BUTTONSTARTTAG;
        [functionButton setTitle:buttonArray[i] forState:UIControlStateNormal];
        [functionButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
//        if (i == 1) {
//            [functionButton.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
//        }
        functionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [functionButton sizeToFit];
        [functionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [functionButton addTarget:self action:@selector(shutDownClick:) forControlEvents:UIControlEventTouchUpInside];
        functionButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [shutDownAlert addSubview:functionButton];
    
    }
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [shutDownAlert.layer addAnimation:popAnimation forKey:nil];
    [self.view addSubview:shutDownAlert];
    
}

- (void)shutDownClick:(UIButton *)sender
{
    dismissView.hidden = YES;
    self.isShowingShotDown = NO;
    UIView *alertview = [self.view viewWithTag:SHUTDOWNTAG];
    [alertview removeFromSuperview];
    
    NSInteger buttonTag = sender.tag;
    switch (buttonTag) {
        case BUTTONSTARTTAG:
        {
            [self shutDownPurifier];
            break;
        }
        case BUTTONSTARTTAG + 1:
        {
            [self setNumberWithTitle:@"Set Number of Hours of Operation" setType:SETNUMOPERATION];
            break;
        }
        case BUTTONSTARTTAG + 2:
        {
            
            break;
        }
        default:
            break;
    }
}

- (void)shutDownPurifier
{
    //关闭空气净化器
    if (self.isShowingShotDown) {
        return;
    }
    self.isShowingShotDown = YES;
    [self.view addSubview:dismissView];
    dismissView.hidden = NO;
    
    CGFloat alertViewW = 250;
    CGFloat alertViewH = 250;
    CGFloat alertViewX = (ScreenWidth - alertViewW) / 2.0;
    CGFloat alertViewY = 100;
    UIImageView *shutDownAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleGraySepBG"]];
    shutDownAlert.tag = SHUTDOWNBGTAG;
    shutDownAlert.frame = CGRectMake(alertViewX, alertViewY, alertViewW, alertViewH);
    shutDownAlert.backgroundColor = [UIColor whiteColor];
    shutDownAlert.userInteractionEnabled = YES;
    
    CGFloat buttonW = 80;
    CGFloat buttonH = 80;
    CGFloat buttonX = (alertViewW - buttonW) / 2.0;
    CGFloat buttonY = 40;
    
    UIButton *shutDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shutDownButton setBackgroundImage:[UIImage imageNamed:@"shutDownIcon"] forState:UIControlStateNormal];
    shutDownButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [shutDownButton addTarget:self action:@selector(shutDownNow:) forControlEvents:UIControlEventTouchUpInside];
    shutDownButton.tag = SHUTDOWNNOW;
    [shutDownAlert addSubview:shutDownButton];
    
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonX, buttonY + buttonH + 10, buttonW, 30)];
    startLabel.backgroundColor = [UIColor clearColor];
    startLabel.font = [UIFont boldSystemFontOfSize:20.0];
    startLabel.textColor = [UIColor blackColor];
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.text = @"START";
    [shutDownAlert addSubview:startLabel];
    
    
    UIButton *s_shutDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    s_shutDownButton.tag = SHUTDOWNSETNUM;
    [s_shutDownButton setBackgroundImage:[UIImage imageNamed:@"shutDownIcon"] forState:UIControlStateNormal];
    s_shutDownButton.frame = CGRectMake(50, 180, 30, 30);
    [s_shutDownButton addTarget:self action:@selector(shutDownNow:) forControlEvents:UIControlEventTouchUpInside];
    [shutDownAlert addSubview:s_shutDownButton];
    
    
    UILabel *s_startLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 180, 120, 30)];
    startLabel.backgroundColor = [UIColor clearColor];
    s_startLabel.backgroundColor = [UIColor clearColor];
    s_startLabel.font = [UIFont systemFontOfSize:13.0];
    s_startLabel.textColor = [UIColor blackColor];
    s_startLabel.textAlignment = NSTextAlignmentLeft;
    s_startLabel.text = @"Time-Setting Start";
    [shutDownAlert addSubview:s_startLabel];
    
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [shutDownAlert.layer addAnimation:popAnimation forKey:nil];
    [self.view addSubview:shutDownAlert];
}

- (void)shutDownNow:(UIButton *)button
{
    dismissView.hidden = YES;
    self.isShowingShotDown = NO;
    UIView *alertview = [self.view viewWithTag:SHUTDOWNBGTAG];
    [alertview removeFromSuperview];
    
    switch (button.tag) {
        case SHUTDOWNNOW:
        {
            
            break;
        }
        case SHUTDOWNSETNUM:
        {
            [self setNumberWithTitle:@"TIME-SETTING START (hr)" setType:SETSHUTDOWNHOUR];
            break;
        }
        
        default:
            break;
    }
}

- (void)setNumberWithTitle:(NSString *)title setType:(NSInteger)type
{
    //关闭空气净化器
    if (self.isShowingShotDown) {
        return;
    }
    self.isShowingShotDown = YES;
    [self.view addSubview:dismissView];
    dismissView.hidden = NO;
    
    UIImage *topBgImage = [UIImage imageNamed:@"NavBarIOS7"];
    
    CGFloat alertViewW = 250;
    CGFloat alertViewH = 280;
    CGFloat alertViewX = (ScreenWidth - alertViewW) / 2.0;
    CGFloat alertViewY = 100;
    UIView *shutDownAlert = [[UIView alloc] init];
    shutDownAlert.tag = type;
    shutDownAlert.frame = CGRectMake(alertViewX, alertViewY, alertViewW, alertViewH);
    shutDownAlert.backgroundColor = [UIColor whiteColor];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertViewW, 40)];
    topLabel.backgroundColor = [UIColor colorWithPatternImage:topBgImage];
    topLabel.font = [UIFont boldSystemFontOfSize:20.0];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = title;
    [shutDownAlert addSubview:topLabel];
    topLabel.adjustsFontSizeToFitWidth = YES;
    shutDownAlert.userInteractionEnabled = YES;
    
    NSArray *buttonArray = @[@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    for (int i = 0; i < [buttonArray count]; i++) {
        
        CGFloat buttonX = 0;
        CGFloat buttonW = alertViewW;
        CGFloat buttonH = ((alertViewH - topLabel.frame.size.height - 40) / [buttonArray count]);
        CGFloat buttonDistance = 0;
//        ((alertViewH - topLabel.frame.size.height - 10) / [buttonArray count]) / 4.0;
        
        CGFloat buttonY = (i + 1) * buttonDistance + i * buttonH + topLabel.frame.size.height;
        UIButton *functionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        functionButton.layer.borderColor = [UIColor blackColor].CGColor;
//        functionButton.layer.borderWidth = 1.0;
        functionButton.tag = [buttonArray[i] integerValue] + type;
        [functionButton setTitle:buttonArray[i] forState:UIControlStateNormal];
        [functionButton setBackgroundImage:[UIImage imageNamed:@"blueBG"] forState:UIControlStateSelected];
        [functionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        functionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [functionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [functionButton addTarget:self action:@selector(numberSet:) forControlEvents:UIControlEventTouchUpInside];
        functionButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [shutDownAlert addSubview:functionButton];
        
    }
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(0, alertViewH - 30, alertViewW / 2.0, 30);
    commitButton.layer.borderColor = [UIColor blackColor].CGColor;
    commitButton.layer.borderWidth = 1.0;
    commitButton.tag = 1;
    [commitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitButton setTitle:@"OK" forState:UIControlStateNormal];
    commitButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [commitButton addTarget:self action:@selector(commitButtonCilck:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(alertViewW / 2.0, alertViewH - 30, alertViewW / 2.0, 30);
    cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
    cancelButton.layer.borderWidth = 1.0;
    cancelButton.tag = 0;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cancelButton addTarget:self action:@selector(commitButtonCilck:) forControlEvents:UIControlEventTouchUpInside];
    
    [shutDownAlert addSubview:commitButton];
    [shutDownAlert addSubview:cancelButton];
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [shutDownAlert.layer addAnimation:popAnimation forKey:nil];
    [self.view addSubview:shutDownAlert];
}

- (void)commitButtonCilck:(UIButton *)button
{
    dismissView.hidden = YES;
    self.isShowingShotDown = NO;
    
    if (button.tag == 0) {
        return;
    }
    
    [button.superview removeFromSuperview];
}

- (void)numberSet:(UIButton *)button
{
    button.selected = YES;
    NSInteger tag = button.tag;
//    dismissView.hidden = YES;
//    self.isShowingShotDown = NO;
    UIView *alertview = [self.view viewWithTag:SETNUMOPERATION];
    
    if (!alertview) {
        //设置关闭时间
        alertview = [self.view viewWithTag:SETSHUTDOWNHOUR];
        
        tag = tag - SETSHUTDOWNHOUR;
        
    }
    tag = tag - SETNUMOPERATION;
    
    for (UIView *subview in alertview.subviews) {
        if (subview.tag != button.tag) {
            if ([subview isMemberOfClass:[UIButton class]]) {
                ((UIButton *)subview).selected = NO;
            }
        }
    }
    //设置操作时间
//    [alertview removeFromSuperview];
    
    
    
}

- (IBAction)functionButtonClick:(UIButton *)sender
{
    NSInteger buttonTag = sender.tag;
    switch (buttonTag) {
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        case 4:
        {
            break;
        }
        case 5:
        {
            break;
        }
        case 6:
        {
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
