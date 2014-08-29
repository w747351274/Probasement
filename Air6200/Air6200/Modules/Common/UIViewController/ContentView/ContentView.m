//
//  ContentView.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

//-(void)initViews{
//    UIScrollView *scrollView;
//    NSDictionary *viewsDictionary;
//
//    // Create the scroll view and the image view.
//    scrollView  = [[UIScrollView alloc] init];
//
//    // Add the scroll view to our view.
//    [self addSubview:scrollView];
//
//    UILabel *label = [[UILabel alloc]init];
//    [label setLineBreakMode:NSLineBreakByWordWrapping];
//    [label setNumberOfLines:0];
//    label.text = [NSString textFromTextFileNamed:@"SEVEN ELEVEN"];
//    [scrollView addSubview:label];
//    // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
//    scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
//    label.translatesAutoresizingMaskIntoConstraints = NO;
//
//    viewsDictionary = NSDictionaryOfVariableBindings(scrollView, label);
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
//    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(scrollView)]|" options:0 metrics: 0 views:viewsDictionary]];
//    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics: 0 views:viewsDictionary]];
//
//};
-(void)initViews{
    [super initViews];
    webView =[[UIWebView alloc]init];
    webView.delegate = self;
    [webView setBackgroundColor:[UIColor clearColor]];
    webView.scrollView.bounces = YES;
    
    [self addSubview:webView];
    [webView layoutFullInSuper];
    [self reloadWebView];
    
}
-(void)reloadWebView{

    NSURLRequest* request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        // Initialization code
        self.url = url;
        [self initViews];
    }
    return self;
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
        [imageView sizeToFit];
        [sender addSubview:imageView];
        imageView.center = CGPointMake(self.center.x, self.center.y - 150);
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
