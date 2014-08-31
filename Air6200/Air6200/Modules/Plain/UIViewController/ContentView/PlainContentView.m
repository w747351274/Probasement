//
//  PlainContentView.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainContentView.h"
#import "TextContentView.h"
@implementation PlainContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)initViews{
    [super initViews];

    self.content = [[TextContentView alloc]init];
    [self addSubview:self.content];
    [self.content layoutFullInSuper];
};
-(void)reloadContent:(NSString *)strUrl{
    NSString *path = strUrl;
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.content reloadViewWithURL:url];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
