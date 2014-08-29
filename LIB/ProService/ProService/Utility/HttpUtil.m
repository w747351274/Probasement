//
//  HttpUtil.m
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "HttpUtil.h"

//服务器url
static const NSString *baseUrl = @"http://www.shobserver.com";
static HttpUtil * _instance = nil;
@implementation HttpUtil

+(void)requestWithUrl:(NSString *)strUrl withCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock {
    ASIHTTPRequest *request = [[self instance]requestWithURLString:strUrl];
    [[self instance]setupRequestWithCompleteBlock:completeBlock errorBlock:errorBlock request:request];
}

+(void)requestWithUrl:(NSString *)strUrl withCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock downLoadProgress:(id)downloadProgress {
    ASIHTTPRequest *request = [[self instance]requestWithURLString:strUrl];
    [request setDownloadProgressDelegate:downloadProgress];
    [[self instance]setupRequestWithCompleteBlock:completeBlock errorBlock:errorBlock request:request];
}
+ (HttpUtil *)instance
{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[HttpUtil alloc] initWithProgressDelete:nil];
            
        }
        
        return _instance;
    }
}

+ (HttpUtil *)instanceOfDelegate:(id)progressDelegate
{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[HttpUtil alloc] initWithProgressDelete:progressDelegate];
        }
        
        return _instance;
    }
}
- (id)initWithProgressDelete:(id)progressDelegate
{
    self = [super init];

    if (self) {
        if (!networkQueue) {
            networkQueue = [[ASINetworkQueue alloc] init];
        }
        failed = NO;
        [networkQueue reset];
        [networkQueue setRequestDidFinishSelector:@selector(fetchComplete:)];
        [networkQueue setRequestDidFailSelector:@selector(fetchFailed:)];
        [networkQueue setShowAccurateProgress:YES];
        [networkQueue setDelegate:self];
    }
    self.progressDelegate = progressDelegate;
    return self;
}
-(void)setProgressDelegate:(id)progressDelegate{

    [networkQueue setDownloadProgressDelegate:progressDelegate];
}

-(void)fetchComplete:(id)sender{
    NSLog(@"EndCompelete!!!");
}

-(void)fetchFailed:(id)sender{
    NSLog(@"endFailed!!!");
}

#pragma mark - 内部方法
//with progress
-(void)requestWithUrl:(NSString *)strUrl withCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock{
    ASIHTTPRequest *request = [self  requestWithURLString:strUrl];
    [self setupRequestWithCompleteBlock:completeBlock errorBlock:errorBlock request:request];
}


// 内部方法,生成要请求的request主体
- (ASIHTTPRequest *)requestWithURLString:(NSString *)actionPath
{
    NSString * urlStr = actionPath;
    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds = 60;

    return request;
}

// 内部方法,执行请求的主体代码
- (void)setupRequestWithCompleteBlock:(completeBlock_t)completeBlock errorBlock:(errorBlock_t)errorBlock request:(ASIHTTPRequest *)request{

    __block ASIHTTPRequest * _request = request;
    
    [request setCompletionBlock:^{
        NSData * respData = _request.responseData;
        __block NSString * respString = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
#if DEBUG
        NSLog(@"----------------------start-------------------------");
        NSLog(@"http - url => %@", _request.url);
        NSLog(@"http - response ==> %@", respString);
        NSLog(@"-----------------------end--------------------------");
#endif
        NSError *error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:respData options:NSJSONReadingAllowFragments error:&error];

        if (jsonObject !=nil && error == nil) {
            // 服务端处理正常
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *deserializedDict = jsonObject;
                completeBlock(deserializedDict);
            }
        }else if (error != nil){
            NSLog(@"An error happened while deserializing the JSON data.");
            NSDictionary *dicObject = @{@"data": respString};
            completeBlock(dicObject);
        }
        _request = nil;
        
    }];
    
    [request setFailedBlock:^{
        NSError *err = _request.error;
        errorBlock(err);
    }];
    [networkQueue addOperation:request];
    [networkQueue go];
//    [request startAsynchronous];
}
-(void)begin{
	[networkQueue go];
}
@end
