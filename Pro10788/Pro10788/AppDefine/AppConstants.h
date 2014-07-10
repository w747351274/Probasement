//
//  AppConstants.h
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//
//genstrings -o /Users/zhihuiguan/Documents/ **/*.m
#import <Foundation/Foundation.h>
// 常用的宏定义
#define ccp(x, y) CGPointMake((x),(y))

/** 判断运行环境是否是iPad */
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// Frame的快捷操作
CG_INLINE CGFloat V_X(UIView *view){ return view.frame.origin.x;}//等同于CGRectGetMaxX(view.frame)
CG_INLINE CGFloat V_Y(UIView *view){ return view.frame.origin.y;}//等同于CGRectGetMaxY(view.frame)
CG_INLINE CGFloat V_W(UIView *view){ return view.frame.size.width;} //等同于CGRectGetWidth(view.frame)
CG_INLINE CGFloat V_H(UIView *view){ return view.frame.size.height;} //等同于CGRectGetHeight(view.frame)
CG_INLINE CGFloat V_BOT_Y(UIView *view){ return V_Y(view) + V_H(view);} //等同于CGRectGetMinY(view.frame)
CG_INLINE CGFloat V_RIGHT_X(UIView *view){ return V_X(view) + V_W(view);} //等同于CGRectGetMaxX(view.frame)
CG_INLINE CGFloat CEN_X(UIView *view){return view.center.x;} //等同于CGRectGetMidX(view.frame)
CG_INLINE CGFloat CEN_Y(UIView *view){return view.center.y;} //等同于CGRectGetMidY(view.frame)

// 屏幕旋转后的通知, 由appdelegate 发起
#define UIApplicationDidChangeStatusBarOrientationNotificationLocal @"UIApplicationDidChangeStatusBarOrientationNotificationLocal"