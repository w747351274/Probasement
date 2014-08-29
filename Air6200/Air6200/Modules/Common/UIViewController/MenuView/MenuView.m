//
//  MenuView.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "MenuView.h"
#import "MenuButtonItem.h"

@implementation MenuView

-(void)initViews{
    self.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    arrMenuItems = [[NSMutableArray alloc]initWithCapacity:3];
    for (NSDictionary *dic in self.arrMenu) {
        MenuButtonItem *menu = [[MenuButtonItem alloc]init];
        menu.image = [UIImage imageNamed:[dic
                                          objectForKey:@"image"]];
        menu.title = [dic objectForKey:@"title"];
        [self addSubview:menu];
        [arrMenuItems addObject:menu];
    }
    CGFloat beginPoint =  heightMenuButtonItem*[arrMenuItems count];
    for (MenuButtonItem *menu in arrMenuItems) {
        NSInteger index =  [arrMenuItems indexOfObject:menu];
        menu.index = index;
        menu.block_Select = ^(NSUInteger index){
            [self setSelectedIndex:index];
        };
        if (index == 0) {
            //the first one
            [menu layoutTopInSuperwithMarginSize:CGSizeMake(kOffset,beginPoint)];
        }else if(index == [arrMenuItems count] -1){
            //the last one
            [menu layoutBottomInSuperwithMarginSize:CGSizeMake(kOffset,100)];
        }else{
            MenuButtonItem *preMenu = [arrMenuItems objectAtIndex:index -1];
            [menu layoutVerticalNextTo:preMenu ofMarginSize:CGSizeMake(kOffset, kOffset)];
        }
    }
    UIView *rightLine = [[UIView alloc]init];
    [rightLine setBackgroundColor:UIColorFromRGB(0xc6c6c6)];
    [self addSubview:rightLine];
    [rightLine layoutRightInSuperwithSize:CGSizeMake(0.5, 0)];
};

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithMenu:(NSArray *)arr{
    self.arrMenu = arr;
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
*/

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    if ([self.menuDelegate respondsToSelector:@selector(indexChanged:)]) {
        [self.menuDelegate indexChanged:selectedIndex];
    }
    for (MenuButtonItem *menu  in arrMenuItems) {
        NSUInteger index = [arrMenuItems indexOfObject:menu];
        if (index != selectedIndex) {
            [menu setIsSelected:NO];
        }else{
            [menu setIsSelected:YES];
        }
    }
}

@end
