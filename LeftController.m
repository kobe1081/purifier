//
//  LeftController.m
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftController.h"
#import "DDMenuController.h"

@interface LeftController()
@property(nonatomic,strong)NSArray *viewControllers;
@property(strong,nonatomic)NSArray *iconArray;
@property(strong,nonatomic)NSArray *titleArray;

@end

@implementation LeftController

@synthesize tableView=_tableView;
@synthesize viewControllers;
@synthesize iconArray;
@synthesize titleArray;

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, IOS7OFFSET)];
    
    UIImage *navBackgroundImage = [UIImage imageNamed:@"NAVGrayBg"];
    
    headerView.backgroundColor = [UIColor colorWithPatternImage:navBackgroundImage];
    [self.view addSubview:headerView];
    
    if (!_tableView) {
        CGRect tableFrame = self.view.bounds;
        tableFrame.origin.y = IOS7OFFSET;
        UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = (id<UITableViewDelegate>)self;
        tableView.dataSource = (id<UITableViewDataSource>)self;
        [self.view addSubview:tableView];
        self.tableView = tableView;
    
        
    }
    [self addViewControllers];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}

- (void)addViewControllers
{
    
    
}

#pragma mark - UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [titleArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    CGFloat imageY = 15;
    CGFloat imageX = 15;
    CGFloat imageH = cellSize.height - 2 * imageY;
    CGFloat imageW = imageH;
    
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconArray[indexPath.row]]];
    iconImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
    [cell addSubview:iconImage];
    
    CGFloat labelX = imageX + imageW + 10;
    CGFloat labelY = 15;
    CGFloat labelW = cellSize.width - labelX - 5;
    CGFloat labelH = cellSize.height - 2 * labelY;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    titleLabel.text = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [cell addSubview:titleLabel];
    
    return cell;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // set the root controller
    
}



@end
