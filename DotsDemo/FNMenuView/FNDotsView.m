//
//  FNDotsView.m
//  FNDotsView
//
//  Created by Adward on 2018/8/22.
//  Copyright © 2018年 FN. All rights reserved.
//

#import "FNDotsView.h"

#define kDotPerWindow 34
#define dotTimes 10

@interface FNDotsView()

@property (nonatomic, strong) NSArray *dotArray;
@property (nonatomic, assign) NSUInteger lastIndex;


@end


@implementation FNDotsView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configView];
    }
    return self;
}

- (void)configView
{
    self.dotCount = kDotPerWindow;
    self.dotRadius = 2.;
    self.scaleValue = 4.;
    self.duration = .3;
    self.dotColor = [UIColor blueColor];
    
    [self updateView:self.bounds.size.width];
   
}

- (void)updateViewWidth:(CGFloat)width
{
    int dotCnt = width/self.bounds.size.width*kDotPerWindow;
    self.dotCount = dotCnt;
    [self updateView:width];
}

- (void)updateView:(CGFloat)w;
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    NSMutableArray *ret = [@[]mutableCopy];
    CGFloat gap = w/self.dotCount;
    gap -= self.dotRadius;
    CGFloat width = self.dotRadius;
    CGFloat startX = 0;
    
    for (int i = 0; i < self.dotCount; i ++)
    {
        CALayer *dot = [CALayer layer];
        dot.frame = CGRectMake(startX, (self.frame.size.height - self.dotRadius-10), self.dotRadius, self.dotRadius);
        dot.backgroundColor = self.dotColor.CGColor;
        // [self.dotColor colorWithAlphaComponent:.15].CGColor;
        dot.cornerRadius = self.dotRadius/2.;
        dot.masksToBounds = YES;
        
        [self.layer addSublayer:dot];
        startX += width;
        startX += gap;
        [ret addObject:dot];
    }
    self.dotArray = ret;
}


#pragma mark - public methods

- (void)scaleToFrameX:(CGFloat)originX
{
    CGFloat x = (originX/self.bounds.size.width)*kDotPerWindow;
    [self scaleDotsAtIndex:x];
}

- (void)scaleDotsAtX:(CGFloat)x
{
    NSInteger idx =  x / self.frame.size.width;
    [self scaleDotsAtIndex:idx];
}


- (void)scaleDotsAtIndex:(NSUInteger)index
{
    [self removeLastScale];

    if (index < 3 ) {
        index = 3;
    }
    if (index > self.dotArray.count - 3) {
        index = self.dotArray.count - 3;
    }
    
    self.lastIndex = index;

    CALayer *layer1 = [self.dotArray objectAtIndex:index];
    [self addScaleToLayer:layer1 scale:self.scaleValue];
    layer1.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:1].CGColor;

    CALayer *layer2 = [self.dotArray objectAtIndex:(index + 1)];
    [self addScaleToLayer:layer2 scale:self.scaleValue];
    layer2.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:1].CGColor;

    
    CALayer *layer3 = [self.dotArray objectAtIndex:(index - 1)];
    [self addScaleToLayer:layer3 scale:(self.scaleValue/2.)];
    layer3.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:.8].CGColor;

    CALayer *layer4 = [self.dotArray objectAtIndex:(index + 2)];
    [self addScaleToLayer:layer4 scale:(self.scaleValue/2.)];
    layer4.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:.8].CGColor;

    
    CALayer *layer5 = [self.dotArray objectAtIndex:(index - 2)];
    [self addScaleToLayer:layer5 scale:(self.scaleValue/3.)];
    layer5.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:.4].CGColor;


    CALayer *layer6 = [self.dotArray objectAtIndex:(index + 3)];
    [self addScaleToLayer:layer6 scale:(self.scaleValue/3.)];
    layer6.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:.4].CGColor;

}

#pragma mark - private methods
- (void)addScaleToLayer:(CALayer *)layer scale:(CGFloat)scale
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue         = [NSNumber numberWithFloat:1.0];
    animation.toValue           = [NSNumber numberWithFloat:scale];
    animation.duration          = self.duration;
    animation.autoreverses      = NO;
    animation.repeatCount       = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode          = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"zoom"];
}

#pragma mark - 移除动画
- (void)removeLastScale
{
    if (self.lastIndex < 3) {
        return;
    }
    CALayer *layer1  = [self.dotArray objectAtIndex:self.lastIndex];
    CALayer *layer2  = [self.dotArray objectAtIndex:(self.lastIndex + 1)];
    CALayer *layer3  = [self.dotArray objectAtIndex:(self.lastIndex - 1)];
    CALayer *layer4  = [self.dotArray objectAtIndex:(self.lastIndex + 2)];
    CALayer *layer5  = [self.dotArray objectAtIndex:(self.lastIndex - 2)];
    CALayer *layer6  = [self.dotArray objectAtIndex:(self.lastIndex + 3)];
    
    [self removeScaleFromLayer:layer1 scale:self.scaleValue];
    [self removeScaleFromLayer:layer2 scale:self.scaleValue];
    [self removeScaleFromLayer:layer3 scale:self.scaleValue/2.];
    [self removeScaleFromLayer:layer4 scale:self.scaleValue/2.];
    [self removeScaleFromLayer:layer5 scale:self.scaleValue/3.];
    [self removeScaleFromLayer:layer6 scale:self.scaleValue/3.];

}

- (void)removeScaleFromLayer:(CALayer *)layer scale:(CGFloat)scale
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue         = [NSNumber numberWithFloat:scale];
    animation.toValue           = [NSNumber numberWithFloat:1.0];
    animation.duration          = self.duration;
    animation.autoreverses      = NO;
    animation.repeatCount       = 0;
    animation.removedOnCompletion = NO;
    animation.fillMode          = kCAFillModeForwards;
    [layer addAnimation:animation forKey:@"zoom"];
    layer.backgroundColor = self.dotColor.CGColor;
    //[self.dotColor colorWithAlphaComponent:.15].CGColor;
}


@end
