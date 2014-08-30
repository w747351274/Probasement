//
//  WebContentView.h
//  Air6200
//
//  Created by 江磊 on 8/30/14.
//  Copyright (c) 2014 Jianglei Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ProService/BaseView.h>
#import "ContentViewProtocal.h"
@interface WebContentView : BaseView<ContentViewProtocal,UIWebViewDelegate>{
    UIWebView *webView;
    UIImage *image;
    UIImageView *imageView;
}

- (void)reloadViewWithURL:(NSURL *)url;
@end
