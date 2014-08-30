//
//  MenuButtonItem.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SELECT_COLOR UIColorFromRGB(0x0079ff)

typedef  void(^block_Select_t)(NSUInteger);
@interface MenuButtonItem : UIControl
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,copy) block_Select_t block_Select;
@property(nonatomic,assign)NSUInteger index;
-(void)setIsSelected:(BOOL)selected;
@end
