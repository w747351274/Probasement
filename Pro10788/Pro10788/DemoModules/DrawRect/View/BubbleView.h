//
//  BubbleView.h
//  Pro10788
//
//  Created by WangJiangLei on 16/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

typedef NS_ENUM(NSUInteger, BubbleStatus) {
    KAnimation,
    KStop
};


#import <UIKit/UIKit.h>

@interface BubbleView : UIView{
    UIImageView *imgView;
    CAKeyframeAnimation *pathAnimation;
}
@property(nonatomic,strong) NSString *strContent;
@property(nonatomic,assign) BubbleStatus animationStatus;
@end
