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
-(void)writePlist{
    //读取plist
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ls" ofType:@"plist"];
    
    NSArray *arr =[[NSArray alloc]initWithContentsOfFile:plistPath];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    
    //添加一项内容
    [data setObject:@"add some content" forKey:@"description"];
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
    //输入写入
    [data writeToFile:filename atomically:YES];
    
    //那怎么证明我的数据写入了呢？读出来看看
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"%@", data1);
}

@end
