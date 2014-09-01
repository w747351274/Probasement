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

-(void)layoutEqualSizeNextTo:(id)controller{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self , controller);
    NSString * KHConstraint;
    NSString * KVConstraint;

    KVConstraint =[NSString stringWithFormat:@"V:|-[self(==controller)]-|"];
    KHConstraint = [NSString stringWithFormat:@"H:[controller]-[self(==controller)]"];
    
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}
@end
