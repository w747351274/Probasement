//
//  MenuView.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseView.h>
extern const CGFloat kOffset ;
extern const CGFloat kFontSize ;
extern const CGFloat heightMenuButtonItem;
@protocol MenuDelegate <NSObject>
-(void)indexChanged:(NSUInteger)index;

@end

@interface MenuView : UIControl{
    NSMutableArray *arrMenuItems;
}
@property (nonatomic,assign)id<MenuDelegate> menuDelegate;
@property (nonatomic,strong)NSArray *arrMenu;
-(id)initWithMenu:(NSArray *)arr;
@property(nonatomic) NSUInteger selectedIndex;

@end