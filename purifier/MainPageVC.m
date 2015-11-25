//
//  MainPageVC.m
//  purifier
//
//  Created by Tony on 15/11/25.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "MainPageVC.h"

@interface MainPageVC ()
@property(strong,nonatomic)IBOutlet UIImageView *qualityBG;

@end

@implementation MainPageVC
@synthesize qualityBG;

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
}

- (void)switchButtonClick:(id)sender
{
    NSLog(@"switchButtonClick");
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
