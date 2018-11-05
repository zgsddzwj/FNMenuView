//
//  FNDotsView.h
//  FNDotsView
//
//  Created by Adward on 2018/8/22.
//  Copyright © 2018年 FN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNDotsView : UIScrollView


/**
 一共有多少个点
 */
@property (nonatomic, assign) int dotCount;

/**
 每个点的大小
 */
@property (nonatomic, assign) float dotRadius;

/**
 放大倍数
 */
@property (nonatomic, assign) float scaleValue;

/**
 动画时长
 */
@property (nonatomic, assign) double duration;

/**
 点的颜色
 */
@property (nonatomic, strong) UIColor *dotColor;


/**
 设置以上任何属性，需要更新View
 */
- (void)updateViewWidth:(CGFloat)width;


/**
 滑动到x坐标点

 @param x x坐标点
 */
- (void)scaleDotsAtX:(CGFloat)x;

- (void)scaleToFrameX:(CGFloat)originX;

/**
 滑动到第几个点

 @param index 点的索引值
 */
- (void)scaleDotsAtIndex:(NSUInteger)index;



@end
