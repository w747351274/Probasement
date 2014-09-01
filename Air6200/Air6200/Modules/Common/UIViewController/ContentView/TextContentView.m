//
//  TextContentView.m
//  Air6200
//
//  Created by 江磊 on 8/30/14.
//  Copyright (c) 2014 Jianglei Wang. All rights reserved.
//

#import "TextContentView.h"

@implementation TextContentView

-(void)initViews{
    NSDictionary *viewsDictionary;
    
    // Create the scroll view and the image view.
    scrollView  = [[UIScrollView alloc] init];
    
    // Add the scroll view to our view.
    [self addSubview:scrollView];
    
    label = [[UILabel alloc]init];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setNumberOfLines:0];
    [scrollView addSubview:label];
    // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
    scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    viewsDictionary = NSDictionaryOfVariableBindings(scrollView, label);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(scrollView)]|" options:0 metrics: 0 views:viewsDictionary]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|" options:0 metrics: 0 views:viewsDictionary]];
    
};
- (void)reloadViewWithURL:(NSURL *)url{
    
    label.text = [NSString stringWithContentsOfURL:url
                                          encoding:NSUTF8StringEncoding error:nil];
    [scrollView setContentOffset:CGPointMake(0, 0)];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
