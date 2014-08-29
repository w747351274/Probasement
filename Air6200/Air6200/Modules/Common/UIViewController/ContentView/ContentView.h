//
//  ContentView.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseView.h>

@interface ContentView : BaseView<UIWebViewDelegate>{
    UIWebView *webView;
    UIImage *image;
    UIImageView *imageView;
}
@property(nonatomic,strong)NSURL *url;
- (id)initWithUrl:(NSURL *)url;
-(void)reloadWebView;
@end
