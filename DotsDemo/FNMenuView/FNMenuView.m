//
//  FNMenuView.m
//  FNMenuView
//
//  Created by Adward on 2018/8/10.
//  Copyright © 2018年 FN. All rights reserved.
//

#import "FNMenuView.h"

@interface FNMenuView()

@property(nonatomic, strong) NSMutableArray *titleArray;

@property(nonatomic, assign) CGFloat leftDistance;

@property(nonatomic, assign) CGFloat curTitleWidth;

@property(nonatomic, weak) UIButton *selectButton;

@property(nonatomic, strong) NSMutableArray *lineArray;

@property(nonatomic, weak) UIView *selectLineView;

@property(nonatomic, strong) UIView *lineView;

@end


@implementation FNMenuView

-(NSMutableArray *)titleArray
{
    if(_titleArray == nil)
    {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealWidth(15), kRealWidth(3))];
        _lineView.layer.cornerRadius = 2.f;
        _lineView.backgroundColor = self.selectColor?:[UIColor blackColor];
    }
    return _lineView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.backgroundColor = kBackgroundBlackDominantColor;
        self.leftDistance = 0.0;
        self.curTitleWidth = 0.0;
        self.curSelectedIndex = 0;
        self.normalColor = [UIColor grayColor];//HexRGB(0x333333);
        self.selectColor = [UIColor greenColor];//HexRGB(0x0780ed);
        self.normalFont = [UIFont systemFontOfSize:12];//PingFangMediumFontSize(12);
        self.selectFont = [UIFont systemFontOfSize:21];//PingFangMediumFontSize(21);
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

-(void)setTextArray:(NSArray *)textArray
{
    _textArray = textArray;
    [self.titleArray removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(NSInteger i = 0; i < textArray.count ;i++)
    {
        NSString *titleStr = textArray[i];
        CGSize size = [self getTextSize:titleStr];
        if(size.height != 0 && size.width != 0)
        {
            UIButton *button = [[UIButton alloc] init];
            [button setTitle:titleStr forState:UIControlStateNormal];
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
            button.tag = i;
            [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchDown];
            [self.titleArray addObject:button];
            
            if(i == self.curSelectedIndex)
            {
                [self selctedBtn:button];
            }
            [self addSubview:button];
        }
    }
    [self setupItem:NO];
    [self addSubview:self.lineView];
}

-(void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    self.lineView.hidden = !showLine;
}

-(void)titleButtonClick:(UIButton *)btn
{
    if (self.menuDelegate && [self.menuDelegate respondsToSelector:@selector(didSelectMenu:)]) {
        [self.menuDelegate didSelectMenu:btn.tag];
    }
    [self selctedBtn:btn];
    [self updateItemView];
}

-(void)selectIndex:(NSInteger)index animated:(BOOL)animated
{
    UIButton *btn = [self.titleArray objectAtIndex:index];
    [self selctedBtn:btn];
    [self setupItem:animated];
}

- (void)selctedBtn:(UIButton *)btn
{
    _selectLineView.hidden = YES;
    _selectLineView = _lineArray[btn.tag];
    _selectLineView.hidden = NO;
    _selectButton = btn;
    _curSelectedIndex = btn.tag;
}

- (CGSize)getTextSize:(NSString*)strText
{
    CGSize size = CGSizeMake(0, 0);
    if (strText.length > 15)
    {
        return size;
    }
    
    return [strText sizeWithAttributes:@{NSFontAttributeName:self.selectFont}];
}
-(void)updateItemView
{
    [self setupItem:YES];
}

- (void)setupItem:(BOOL)animated
{
    CGFloat contentWidth = 0;
    for (NSInteger i =0;i<[self.titleArray count];i++) {
        UIButton *button = self.titleArray[i];
        
        if(i == 0)
        {
            self.leftDistance = kLeftSpace;
        }
        else
        {
            self.leftDistance = self.curTitleWidth + kItemGap;
        }
        UIFont *font = nil;
        if (button.tag == self.curSelectedIndex) {
            [button setTitleColor:self.selectColor forState:UIControlStateNormal];
            [self.lineView setBackgroundColor:self.selectColor];
            font = self.selectFont;
        }else
        {
            [button setTitleColor:self.normalColor forState:UIControlStateNormal];
            font = self.normalFont;
        }
        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:font}];
        button.titleLabel.font = font;
        self.curTitleWidth = size.width + self.leftDistance;
        
        if (animated) {
            CGFloat dur = animated?.2:0;
            [UIView animateWithDuration:dur animations:^{
                [self setupButton:button size:size];
            }];
        } else {//初始化时，不应该有动画。添加动画会有问题
            [self setupButton:button size:size];
        }

        contentWidth = CGRectGetMaxX(button.frame);
    }
    self.contentSize = CGSizeMake(contentWidth, 0);
}

- (void)setupButton:(UIButton *)button size:(CGSize)size
{
    if ([button isEqual:self.selectButton]) {
        button.frame = CGRectMake(self.leftDistance, 2, size.width, size.height);
    }else {
        button.frame = CGRectMake(self.leftDistance, self.selectFont.pointSize-self.normalFont.pointSize, size.width, size.height);
    }
    CGPoint curCenter = CGPointMake(self.selectButton.center.x, CGRectGetMaxY(self.selectButton.frame)+kRealWidth(5));
    self.lineView.center = curCenter;

}

@end
