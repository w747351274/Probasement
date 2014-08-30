//
//  WebContentView.m
//  Air6200
//
//  Created by 江磊 on 8/30/14.
//  Copyright (c) 2014 Jianglei Wang. All rights reserved.
//

#import "WebContentView.h"

@implementation WebContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initViews{
    [super initViews];
    webView =[[UIWebView alloc]init];
    webView.delegate = self;
    [webView setBackgroundColor:[UIColor clearColor]];
    webView.scrollView.bounces = YES;

    [self addSubview:webView];
    [webView layoutFullInSuper];
}
- (void)reloadViewWithURL:(NSURL *)url{
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)sender{
    if (!image) {
        image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"loading1"],
                                                   [UIImage imageNamed:@"loading2"],
                                                   [UIImage imageNamed:@"loading3"],
                                                   [UIImage imageNamed:@"loading4"],
                                                   [UIImage imageNamed:@"loading5"],
                                                   [UIImage imageNamed:@"loading6"],
                                                   [UIImage imageNamed:@"loading7"],
                                                   [UIImage imageNamed:@"loading8"]] duration:1];
        imageView = [[UIImageView alloc]initWithImage:image];
        [sender addSubview:imageView];
        [imageView layoutTopInSuperwithSize:CGSizeZero];
    }
    imageView.hidden = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    imageView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    imageView.hidden = YES;
}
@end
