//
//  PlainService.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainService.h"

@implementation PlainService
-(NSArray *)plainDataSource{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ls" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return arr;
}

@end
