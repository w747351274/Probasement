//
//  HttpUtil.h
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
typedef void(^completeBlock_t) (NSDictionary * dict);
typedef void(^errorBlock_t) (NSError *error);

@interface HttpUtil : NSObject{
    ASINetworkQueue *networkQueue;
    BOOL failed;
}
@property(nonatomic, assign)id progressDelegate;
//实例化的方法
+ (HttpUtil *)instance;

//实例化方法，直接初始化一个下载队列
+ (HttpUtil *)instanceOfDelegate:(id)progressDelegate;

//点号赋值和set赋值的作用效果都一样，增加队列的整体下载进度
-(void)setProgressDelegate:(id)progressDelegate;

//简单的请求方法，如需增加参数需要重写方法
+(void)requestWithUrl:(NSString *)strUrl withCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock;

+(void)requestWithUrl:(NSString *)strUrl withCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock downLoadProgress:(id)downloadProgress;

// 内部方法,生成要请求的request主体
- (ASIHTTPRequest *)requestWithURLString:(NSString *)actionPath;

// 内部方法,执行请求的主体代码
- (void)setupRequestWithCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock request:(ASIHTTPRequest *)request;

- (void)begin;
@end
