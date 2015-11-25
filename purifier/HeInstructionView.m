//
//  HeInstructionView.m
//  com.mant.iosClient
//
//  Created by 何 栋明 on 13-11-13.
//  Copyright (c) 2013年 何栋明. All rights reserved.
//

#import "HeInstructionView.h"
#import "AppDelegate.h"
#import "LeftController.h"

#define DefaultTabBarImageHilightedTintColor             [UIColor colorWithRed:120.0f/255.0f green:202.0f/255.0f blue:255.0f/255.0f alpha:1.0]
#define DefaultTabBarTitleHilightedTintColor             [UIColor orangeColor]

@interface HeInstructionView ()
@property(strong,nonatomic)NSArray *launchArray;

@end

@implementation HeInstructionView
@synthesize loadSucceedFlag;
@synthesize launchArray;


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
        label.text = @"空气净化器";
        [label sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    myscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    myscrollView.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:230.0f/255.0f];
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 36)];
    images = [NSMutableArray arrayWithObjects:@"appIntroduce1",@"appIntroduce2",@"appIntroduce3", nil];
    [self.view addSubview:myscrollView];
    [self setupPage];
    [self.view addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self hideHud];
//    self.loadSucceedFlag = 1;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.loadSucceedFlag = 1;
}

-(void)setupPage
{
    myscrollView.delegate = self;
    [myscrollView setBackgroundColor:[UIColor colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:230.0f/255.0f]];
    [myscrollView setCanCancelContentTouches:NO];
    myscrollView.clipsToBounds = YES;
    myscrollView.scrollEnabled = YES;
    myscrollView.pagingEnabled = YES;
    myscrollView.directionalLockEnabled = NO;
    myscrollView.alwaysBounceHorizontal = NO;
    myscrollView.alwaysBounceVertical = NO;
    myscrollView.showsHorizontalScrollIndicator = NO;
    myscrollView.showsVerticalScrollIndicator = NO;
    
    NSInteger nimages = 0;
    CGFloat cx = 0;
    for (NSString *imagepath in images) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagepath]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectZero;
        CGRect rect = myscrollView.frame;
        rect.size.height = self.view.bounds.size.height;
        rect.size.width = self.view.bounds.size.width;
        rect.origin.x = cx;
        rect.origin.y = 0;
        imageView.frame = rect;
        [myscrollView addSubview:imageView];
        if (nimages == [images count] - 1) {
            enterButton = [[UIButton alloc] init];
            [enterButton setTitle:@"进入应用" forState:UIControlStateNormal];
            [enterButton dangerStyle];
            enterButton.layer.borderColor = [UIColor clearColor].CGColor;
            enterButton.layer.borderWidth = 0;
            enterButton.layer.masksToBounds = YES;
//            [enterButton setBackgroundImage:[UIImage imageNamed:@"launchBT"] forState:UIControlStateNormal];
//            [enterButton setBackgroundImage:[UIImage imageNamed:@"launchBTHL"] forState:UIControlStateHighlighted];
            UIScreen *mainScreen = [UIScreen mainScreen];
            CGFloat buttonW = 150;
            CGFloat buttonH = 39.5;
            CGFloat buttonX = (self.view.bounds.size.width - buttonW) / 2.0;
            CGFloat buttonY = mainScreen.bounds.size.height - 50 - 44;
            enterButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            myscrollView.userInteractionEnabled = YES;
            imageView.userInteractionEnabled = YES;
            [enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [enterButton setAlpha:0.8];
            [imageView addSubview:enterButton];
        }
        
        cx += myscrollView.frame.size.width;
        nimages++;
    }
    pageControl.numberOfPages = nimages;
    pageControl.currentPage = 0;
    [myscrollView setContentSize:CGSizeMake(cx, [myscrollView bounds].size.height)];
    
}

-(void)enterButtonClick:(id)sender
{
    [self performSelector:@selector(loginStateChange:) withObject:nil afterDelay:0.1];
}


-(void)loginStateChange:(NSNotification *)notification
{
    AppDelegate *myAppdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //初始化用户信息
    [self showHudInView:self.view hint:@"请稍等..."];
    [self initUser];
    
//    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MapStorageViewController alloc] init]];
//    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
//    
//    // Create frosted view controller
//    //
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//    
//    // Make it a root controller
//    //
//    myAppdelegate.window.rootViewController = frostedViewController;
//    myAppdelegate.window.backgroundColor = [UIColor whiteColor];
//    [myAppdelegate.window makeKeyAndVisible];
    
    
}

-(void)initUser
{
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pageControlIsChangingPage) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    pageControl.currentPage = page;
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlIsChangingPage = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
