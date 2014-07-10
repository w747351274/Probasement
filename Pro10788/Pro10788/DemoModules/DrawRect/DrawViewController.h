//
//  DrawViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 15/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BubbleView.h"
#import "FillWordColor.h"
#import "ShapeView.h"
#import "BerzierTest.h"
typedef enum{
    bg1 = 1<<0,
    bg2 = 2<<0,
    bg3 = 3<<0,
    bg4 = 4<<0,
    bg5 = 5<<0
} bg;
@interface DrawViewController : BaseViewController{
    BubbleView *bubbleView;
    UIImageView *iconImg;
    FillWordColor *fv;
}

@end
