//
//  M3Service.m
//  Pro10788
//
//  Created by WangJiangLei on 20/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "M3Service.h"

@implementation M3Service
-(void)makeHappy{
    if ([self.delegate respondsToSelector:@selector(message)]) {
        [self.delegate message];
    }
    if ([self.delegate respondsToSelector:@selector(haveFun)]) {
        [self.delegate haveFun];
    }
}
-(void)loadData{

    NSString *url = @"http://validate.jsontest.com/?json=%5BJSON-code-to-validate%5D";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [HttpUtil requestWithUrl:url withCompleteBlock:^(NSDictionary *dict) {
            NSLog(@"dict->%@",dict);
            if ([self.delegate respondsToSelector:@selector(dataReceived:)]) {
                [self.delegate dataReceived:dict];
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"errot->%@",error);
        }];
    });
}

-(void)loadDataWithProgress:(id)progressDelegate{
    
    NSString *url = @"http://validate.jsontest.com/?json=%5BJSON-code-to-validate%5D";
    [HttpUtil requestWithUrl:url withCompleteBlock:^(NSDictionary *dict) {
        NSLog(@"dict->%@",dict);
        if ([self.delegate respondsToSelector:@selector(dataReceived:)]) {
            [self.delegate dataReceived:dict];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"errot->%@",error);
    }];
    [[HttpUtil instance]setProgressDelegate:progressDelegate];
    
       for (int a =0 ; a <1;  a++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [HttpUtil requestWithUrl:url withCompleteBlock:^(NSDictionary *dict) {
                NSLog(@"dict->%@",dict);
                if ([self.delegate respondsToSelector:@selector(dataReceived:)]) {
                    [self.delegate dataReceived:dict];
                }
            } errorBlock:^(NSError *error) {
                NSLog(@"errot->%@",error);
            }];
//        });
    }
    [[HttpUtil instance]begin];
}
@end
