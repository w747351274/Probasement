//
//  PlainService.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlainProtocol.h"
@interface PlainService : NSObject<PlainProtocol>
-(NSArray *)plainDataSource;
-(NSString *)dataFilePath:(NSString *)strFileName;
-(NSString *)defaultContentFile;
@end
