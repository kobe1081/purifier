//
//  HeStartPairVC.m
//  purifier
//
//  Created by Tony on 15/11/25.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "HeStartPairVC.h"
#import "UIButton+Bootstrap.h"
#import "AppDelegate.h"
#import "MainPageVC.h"
#import "CustomNavigationController.h"
#import "LeftController.h"
#import "DDMenuController.h"

@interface HeStartPairVC ()
@property(strong,nonatomic)IBOutlet UILabel *searchLabel;
@property(strong,nonatomic)IBOutlet UIImageView *searchImage;

@end

@implementation HeStartPairVC
@synthesize bannerImage;
@synthesize bgImage;
@synthesize pairButton;
@synthesize searchLabel;
@synthesize searchImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialization];
    [self initView];
}

- (void)initialization
{
    self.navigationController.navigationBarHidden = YES;
    UIImage *image = [UIImage imageNamed:@"blueBG"];
    [pairButton setBackgroundImage:image forState:UIControlStateNormal];
    pairButton.layer.cornerRadius = 20.0;
    pairButton.layer.borderWidth = 0;
    pairButton.layer.borderColor = [UIColor clearColor].CGColor;
    pairButton.layer.masksToBounds = YES;
}

- (void)initView
{

}

- (IBAction)pairButtonClick:(UIButton *)sender
{
    sender.hidden = YES;
    searchImage.hidden = NO;
    searchLabel.hidden = NO;
    //扫描设备
    [self performSelector:@selector(scanDevice) withObject:nil afterDelay:1.0];
}

- (void)scanDevice
{
    searchLabel.hidden = YES;
    searchImage.hidden = YES;
    
    CGRect bannerFrame = bannerImage.frame;
    CGFloat labelX = bannerFrame.origin.x;
    CGFloat labelY = bannerFrame.origin.y + bannerFrame.size.height + 20 ;
    CGFloat labelW = 200;
    CGFloat labelH = 30;
    
    UILabel *selectLabel = [[UILabel alloc] init];
    selectLabel.backgroundColor = [UIColor clearColor];
    selectLabel.textColor = [UIColor blueColor];
    selectLabel.textAlignment = NSTextAlignmentLeft;
    selectLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    selectLabel.text = @"SELECT DEVICE";
    selectLabel.font = [UIFont systemFontOfSize:20.0];
    [selectLabel sizeToFit];
    [self.view addSubview:selectLabel];
    
    UIImageView *seperateLine = [[UIImageView alloc] init];
    seperateLine.backgroundColor = [UIColor blueColor];
    seperateLine.frame = CGRectMake(labelX, labelY + labelH + 2, ScreenWidth - labelX - 20, 1);
    [self.view addSubview:seperateLine];
    
    labelY = labelY + 5;
    
    for (int i = 0; i < 3; i++) {
        CGFloat deviceDistance = 10;
        CGFloat deviceH = 20;
        CGFloat deviceX = labelX;
        CGFloat deviceW = ScreenWidth - deviceX - 20;
        CGFloat deviceY = labelY + labelH + i * deviceH + (i + 1) * deviceDistance;
        UILabel *deviceLabel = [[UILabel alloc] init];
        deviceLabel.backgroundColor = [UIColor clearColor];
        deviceLabel.textColor = [UIColor blueColor];
        deviceLabel.font = [UIFont systemFontOfSize:16.0];
        deviceLabel.frame = CGRectMake(deviceX, deviceY, deviceW, deviceH);
        deviceLabel.text = [NSString stringWithFormat:@"DEVICE %d",i + 1];
        deviceLabel.tag = i;
        [self.view addSubview:deviceLabel];
        deviceLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *scanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanDeviceDetail:)];
        scanTap.numberOfTapsRequired = 1;
        scanTap.numberOfTouchesRequired = 1;
        [deviceLabel addGestureRecognizer:scanTap];
    }
    
}

- (void)scanDeviceDetail:(UITapGestureRecognizer *)tap
{
    MainPageVC *mainController = [[MainPageVC alloc] initWithNibName:nil bundle:nil];
    CustomNavigationController *navController = [[CustomNavigationController alloc] initWithRootViewController:mainController];
    
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navController];
    
    LeftController *leftController = [[LeftController alloc] init];
    rootController.leftViewController = leftController;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.menuController = rootController;
    
    appDelegate.window.rootViewController = rootController;
    
    appDelegate.window.backgroundColor = [UIColor whiteColor];
    [appDelegate.window makeKeyAndVisible];
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
