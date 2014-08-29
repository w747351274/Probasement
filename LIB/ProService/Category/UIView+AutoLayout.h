//
//  UIView+AutoLayout.h
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//
//autolayout 暂时可能不能用，暂停更新先
#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

/*
 设置view在父类的view的顶端
    @pram size 控件的大小，若设置为零，则为系统高宽
 */
-(void)layoutTopInSuperwithSize:(CGSize )size;
/*
 menu 用
 设置view在父类的view的顶端
 @pram size 控件的边距，若设置为零，则为系统高宽
 */
-(void)layoutTopInSuperwithMarginSize:(CGSize )size;
/*
  menu 用
 设置view在父类的view的底端
 @pram size 控件的边距，若设置为零，则为系统高宽
 */
-(void)layoutBottomInSuperwithMarginSize:(CGSize )mSize;
/*
 设置view在父类的view里全满
 */
-(void)layoutFullInSuper;
/*
 设置view在父类的view里全满
 */
-(void)layoutCenter;
/*
 垂直于位于指定的控件的下方，距离是apple定义的系统距离
 */
-(void)layoutVerticalNextTo:(id)controller;
/*
 垂直于位于指定的控件的下方，距离是apple定义的系统距离
 */
-(void)layoutVerticalNextTo:(id)controller ofSize:(CGSize)size;
/*
  menu 用
 垂直于位于指定的控件的下方，设置边距
 */
-(void)layoutVerticalNextTo:(id)controller ofMarginSize:(CGSize)size;
/*
 水平位于指定控件的右方，距离是apple定义的系统距离
 */
-(void)layoutHorizontalNextTo:(id)controller;

/*
 水平位于指定控件的右方，距离是apple定义的系统距离
 */
-(void)layoutHorizontalNextTo:(id)controller ofSize:(CGSize)size;
/*
 设置view在父类的view的左端
 @pram size 控件的大小，若设置为零，则为系统高宽
 */

-(void)layoutLeftInSuperwithSize:(CGSize )size;
/*
 设置view在父类的view的右端
 @pram size 控件的大小，若设置为零，则为系统高宽
 */
-(void)layoutRightInSuperwithSize:(CGSize )size;
@end
