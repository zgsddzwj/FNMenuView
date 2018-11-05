//
//  FNMenuView.h
//  FNMenuView
//
//  Created by Adward on 2018/8/10.
//  Copyright © 2018年 FN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNMenuDefine.h"

#define kLeftSpace kRealWidth(24.0)
#define kItemGap   kRealWidth(12)

@protocol FNMenuViewDelegate <NSObject>

- (void)didSelectMenu:(NSInteger)index;

@end

@interface FNMenuView : UIScrollView

@property (nonatomic, weak) id<FNMenuViewDelegate> menuDelegate;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;

@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectFont;

@property (nonatomic, strong) NSArray *textArray;

@property(nonatomic,assign) NSInteger curSelectedIndex;

/**
 是否显示下划线
 */
@property (nonatomic, assign) BOOL showLine;

- (void)setupItem:(BOOL)animated;

- (void)updateItemView;

-(void)selectIndex:(NSInteger)index animated:(BOOL)animated;

@end
