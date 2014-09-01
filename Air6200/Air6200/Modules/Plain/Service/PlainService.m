//
//  PlainService.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainService.h"
static NSString *strPlainDir = @"PlainData.bundle";

@implementation PlainService
-(NSArray *)plainDataSource{
    NSString *path = [self dataFilePath:@"ls.plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return arr;
}

-(NSString *)dataFilePath:(NSString *)strFileName{
    NSString *path =[[NSBundle mainBundle] pathForResource:strFileName ofType:nil inDirectory:strPlainDir];
    return path;
}

-(NSString *)defaultContentFile{
    return [self dataFilePath:[[self plainDataSource][0] objectForKey:@"fileName"]];
}
@end
