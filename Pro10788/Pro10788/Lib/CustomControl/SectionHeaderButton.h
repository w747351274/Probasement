//
//  SectionHeaderButton.h
//  Pro10788
//
//  Created by WangJiangLei on 8/7/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SectionHeaderButtonStatus) {
    SectionHeaderExpand,
    SectionHeaderCollapse
};
typedef void(^touchUpInsideBlock_t)(SectionHeaderButtonStatus status);
@interface SectionHeaderButton : UIButton{
    NSString *strNomalTitle;
    NSString *strHighlightedTitle;
    touchUpInsideBlock_t touchUpInsideBlock;
}
@property(nonatomic,assign)SectionHeaderButtonStatus status;

+ (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title touchUpInsideBlock:(touchUpInsideBlock_t)touchUpInsideBlock;
@end
