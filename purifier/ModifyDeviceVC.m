//
//  ModifyDeviceVC.m
//  purifier
//
//  Created by Tony on 15/11/25.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "ModifyDeviceVC.h"
#import "UIButton+Bootstrap.h"

@interface ModifyDeviceVC ()
@property(strong,nonatomic)IBOutlet UILabel *modelLabel;
@property(strong,nonatomic)IBOutlet UILabel *productionLabel;
@property(strong,nonatomic)IBOutlet UITextField *nameField;
@property(strong,nonatomic)IBOutlet UIButton *saveButton;

@end

@implementation ModifyDeviceVC
@synthesize saveButton;
@synthesize saveDelegate;
@synthesize productionLabel;
@synthesize modelLabel;
@synthesize nameField;

- (id)initWithDevice:(DeviceModel *)device
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initialization];
    [self initView];
}

- (void)initialization
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, IOS7OFFSET)];
    UIImage *navBackgroundImage = [UIImage imageNamed:@"NAVGrayBg"];
    headerView.backgroundColor = [UIColor colorWithPatternImage:navBackgroundImage];
    [self.view addSubview:headerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, IOS7OFFSET - 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.text = @"Air Purifier 1";
    [headerView addSubview:titleLabel];
}

- (void)initView
{
//    productionLabel.font = [UIFont systemFontOfSize:13.0];
    
    [saveButton defaultStyle];
    saveButton.layer.borderColor = [UIColor blackColor].CGColor;
    saveButton.layer.borderWidth = 1.0;
    saveButton.layer.masksToBounds = YES;
}

- (IBAction)saveButtonClick:(id)sender
{
    if (nameField.text == nil || [nameField.text isEqualToString:@""]) {
        [self showHint:@"请输入设备的名称"];
        return;
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    PurifierModel *deviceModel = [[PurifierModel alloc] init];
    deviceModel.name = nameField.text;
    deviceModel.model = modelLabel.text;
    deviceModel.productionTime = productionLabel.text;
    [saveDelegate saveSucceedWithModel:deviceModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
