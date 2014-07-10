//
//  M3ViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HttpUtil.h"
#import "M3Service.h"

@interface M3ViewController : BaseViewController<m3Protocal>{

    UIProgressView *progress;
    UIProgressView *progress2;
}
@property (nonatomic, strong)M3Service *service;
@end
