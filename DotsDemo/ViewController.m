//
//  ViewController.m
//  DotsDemo
//
//  Created by Adward on 2018/11/3.
//  Copyright © 2018年 FN. All rights reserved.
//

#import "ViewController.h"
#import "FNMenuView/FNMenuView.h"
#import "FNMenuView/FNDotsView.h"

@interface ViewController ()<FNMenuViewDelegate,UIScrollViewDelegate>
/**
 顶部切换按钮
 */
@property (nonatomic, strong) FNMenuView *menuView;

/**
 切换按钮底部的点view
 */
@property (nonatomic, strong) FNDotsView *dotsView;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = @[@"水里水里来",@"水里",@"水里水里来水里水里来",@"水里里来",@"水里水里来",@"水里来",@"水里水里来水里水里来",@"水里水里来"];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.dotsView];
    
    
    self.menuView.textArray = self.dataSource;
    
    [self.dotsView updateViewWidth:self.menuView.contentSize.width];
    
    [self didSelectMenu:0];
}



- (FNMenuView *)menuView {
    if (!_menuView)
    {
        FNMenuView *menuView = [[FNMenuView alloc] initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, (60))];
        menuView.menuDelegate = self;
        menuView.delegate = self;
        menuView.textArray = self.dataSource;
        
        menuView.showLine = NO;
        _menuView = menuView;
    }
    return _menuView;
}

- (FNDotsView *)dotsView {
    if (!_dotsView) {
        FNDotsView *dotsView = [[FNDotsView alloc] initWithFrame:CGRectMake(self.menuView.frame.origin.x, CGRectGetMaxY(self.menuView.frame) - (18), self.menuView.frame.size.width, (25))];
        _dotsView = dotsView;
        
    }
    return _dotsView;
}

- (void)didSelectMenu:(NSInteger)index;
{
    NSArray *arr = self.dataSource;
    
    NSInteger left = kLeftSpace;
    NSInteger space = kItemGap;
    CGFloat dotLeft = left;
    
    for (int i = 0; i < index; i ++)
    {
        CGSize size = [arr[i] sizeWithAttributes:@{NSFontAttributeName:self.menuView.normalFont}];
        dotLeft +=size.width;
        dotLeft +=space;
    }
    
    CGSize curSize = [arr[index] sizeWithAttributes:@{NSFontAttributeName:self.menuView.selectFont}];
    dotLeft += curSize.width/2;
    
    [self.dotsView scaleToFrameX:dotLeft];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.dotsView setContentOffset:scrollView.contentOffset];
}



@end
