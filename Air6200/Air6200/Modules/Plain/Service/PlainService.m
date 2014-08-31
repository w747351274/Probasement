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
    NSString *path = [[NSBundle bundleWithPath:[self bundlePath]]pathForResource:@"ls" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    return arr;
}
-(NSString *)bundlePath{
    NSString * strBundlePath = [[NSBundle mainBundle]pathForResource:@"PlainData" ofType:@"bundle"];
    return strBundlePath;
}
-(NSString *)dataFilePath:(NSString *)strFileName{
    NSString *name = [strFileName stringByDeletingPathExtension];
    NSString *extension = [strFileName pathExtension];
    
    NSString *path =[[NSBundle bundleWithPath:[self bundlePath]]pathForResource:name ofType:extension];
    return path;
}
-(NSString *)defaultContentFile{
    return [self dataFilePath:[[self plainDataSource][0] objectForKey:@"fileName"]];
}
@end
