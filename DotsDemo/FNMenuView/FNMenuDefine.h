//
//  FNMenuDefine.h
//  DotsDemo
//
//  Created by Adward on 2018/11/5.
//  Copyright © 2018年 FN. All rights reserved.
//

#ifndef FNMenuDefine_h
#define FNMenuDefine_h

/**
 *  获取屏幕尺寸、宽度、高度
 */
#define kScreenRect                 ([[UIScreen mainScreen] bounds])            //屏幕frame
#define kScreenSize                 ([UIScreen mainScreen].bounds.size)         //屏幕size
#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)   //屏幕宽度
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)  //屏幕高度

/**
 *  不同尺寸手机真实宽度、高度（以6s为基准）
 */
#define kRealWidth(value)           (((value)/375.0f) * kScreenWidth)
#define kRealHeight(value)          (((value)/667.0f) * kScreenHeight)

#endif /* FNMenuDefine_h */
