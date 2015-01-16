//
//  UIView+AutoLayout.m
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

-(void)layoutTopInSuperwithSize:(CGSize )size{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *KHConstraint;
    NSString *KVContraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeH > 0) {
        KHConstraint = [NSString stringWithFormat:@"V:|-[self(==%f)]",sizeH];
    }else{
        KHConstraint = @"V:|-[self(>=45)]";
    }
    if (sizeW > 0 ) {
        KVContraint = [NSString stringWithFormat:@"H:|-[self(==%f)]",sizeW];
    }else{
        KVContraint = @"H:|-[self(>=45)]";
    }
    
    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVContraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:constraintArray];
}
-(void)layoutTopInSuperwithMarginSize:(CGSize )mSize{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *KHConstraint;
    NSString *KVContraint;
    CGFloat sizeH = mSize.height;
    CGFloat sizeW = mSize.width;
    if (sizeH > 0) {
        KHConstraint = [NSString stringWithFormat:@"V:|-%f-[self(>=53)]",sizeH];
    }else{
        KHConstraint = @"V:|-[self]";
    }
    if (sizeW > 0 ) {
        KVContraint = [NSString stringWithFormat:@"H:|-%f-[self]-%f-|",sizeW,sizeW];
    }else{
        KVContraint = @"H:|-[self]-|";
    }
    
    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVContraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:constraintArray];
}
-(void)layoutBottomInSuperwithMarginSize:(CGSize )mSize{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *KHConstraint;
    NSString *KVContraint;
    CGFloat sizeH = mSize.height;
    CGFloat sizeW = mSize.width;
    if (sizeH > 0) {
        KHConstraint = [NSString stringWithFormat:@"V:[self(>=53)]-%f-|",sizeH];
    }else{
        KHConstraint = @"V:|-[self]";
    }
    if (sizeW > 0 ) {
        KVContraint = [NSString stringWithFormat:@"H:|-%f-[self]-%f-|",sizeW,sizeW];
    }else{
        KVContraint = @"H:|-[self]-|";
    }
    
    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVContraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:constraintArray];
}
-(void)layoutFullInSuper{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSMutableArray *viewConstraintArray  = [[NSMutableArray alloc]init];
    [viewConstraintArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [viewConstraintArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [viewConstraintArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    [viewConstraintArray addObject:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
    [self.superview addConstraints:viewConstraintArray];
    self.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
//    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
//    
//    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
//    [self.superview addConstraints:constraintArray];
}

-(void)layoutCenter{
    UIView *superview = self.superview;

    /* 2) Create the constraint to put the button horizontally in the center */
    NSLayoutConstraint *centerXConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0f
                                  constant:0.0f];
    /* 3) Create the constraint to put the button vertically in the center */
    NSLayoutConstraint *centerYConstraint =
    [NSLayoutConstraint constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0f
                                  constant:-100.0f];
    /* Add the constraints to the superview of the button */
    [superview addConstraints:@[centerXConstraint, centerYConstraint]];
}
-(void)layoutVerticalNextTo:(id)controller{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self,controller);
    NSString * KHConstraint =@"H:|-[self(>=50)]-|";
    NSString * KVConstraint = [NSString stringWithFormat:@"V:[controller]-[self]"];
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}
-(void)layoutVerticalNextTo:(id)controller ofSize:(CGSize)size{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self , controller);
    NSString * KHConstraint;
    NSString * KVConstraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeW > 0) {
        KHConstraint =[NSString stringWithFormat:@"H:|-[self(>=%f)]-|",sizeW];
    }else{
        KHConstraint =@"H:|-[self]-|";
    }
    if (sizeH > 0) {
        KVConstraint = [NSString stringWithFormat:@"V:[controller]-[self(==%f)]",sizeH];
    }else{
        KVConstraint = [NSString stringWithFormat:@"V:[controller]-[self]-|"];
    }
    
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}

-(void)layoutVerticalNextTo:(id)controller ofMarginSize:(CGSize)size{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self , controller);
    NSString * KHConstraint;
    NSString * KVConstraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeW > 0) {
        KHConstraint =[NSString stringWithFormat:@"H:|-%f-[self]-%f-|",sizeW,sizeW];
    }else{
        KHConstraint =@"H:|-[self]-|";
    }
    if (sizeH > 0) {
        KVConstraint = [NSString stringWithFormat:@"V:[controller]-[self(>=53)]"];
    }else{
        KVConstraint = [NSString stringWithFormat:@"V:[controller]-[self]"];
    }
    
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}

-(void)layoutHorizontalNextTo:(id)controller{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self , controller);
    NSString * KHConstraint;
    NSString * KVConstraint;
    
    
    KHConstraint =@"H:[controller][self]|";
    
    KVConstraint = [NSString stringWithFormat:@"V:|[self]|"];
    
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}

-(void)layoutHorizontalNextTo:(id)controller ofSize:(CGSize)size{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dicBrentView = NSDictionaryOfVariableBindings(self , controller);
    NSString * KHConstraint;
    NSString * KVConstraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeW > 0) {
        KHConstraint =[NSString stringWithFormat:@"H:[controller]-[self(==%f)]",sizeW];
    }else{
        KHConstraint =@"H:[controller]-[self]|";
    }
    if (sizeH > 0) {
        KVConstraint = [NSString stringWithFormat:@"V:|-[self(>=%f)]",sizeH];
    }else{
        KVConstraint = [NSString stringWithFormat:@"V:|-[self]|"];
    }
    
    NSMutableArray *constraintArray = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:dicBrentView]];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVConstraint options:0 metrics:nil views:dicBrentView]];
    [self.superview addConstraints:constraintArray];
}

-(void)layoutLeftInSuperwithSize:(CGSize )size{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *KHConstraint;
    NSString *KVContraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeW > 0) {
        KVContraint = [NSString stringWithFormat:@"H:|[self(==%f)]",sizeW];
    }else{
        KVContraint = @"H:|[self(>=50)]";
    }
    if (sizeH > 0 ) {
        KHConstraint = [NSString stringWithFormat:@"V:|[self(>=%f)]|",sizeH];
    }else{
        KHConstraint = @"V:|[self]|";
    }
    
    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVContraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:constraintArray];
}
-(void)layoutRightInSuperwithSize:(CGSize )size{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *KHConstraint;
    NSString *KVContraint;
    CGFloat sizeH = size.height;
    CGFloat sizeW = size.width;
    if (sizeW > 0) {
        KVContraint = [NSString stringWithFormat:@"H:[self(==%f)]|",sizeW];
    }else{
        KVContraint = @"H:|[self(>=50)]|";
    }
    if (sizeH > 0 ) {
        KHConstraint = [NSString stringWithFormat:@"V:|[self(>=%f)]|",sizeH];
    }else{
        KHConstraint = @"V:|[self]|";
    }
    
    NSMutableArray *constraintArray  = [[NSMutableArray alloc]init];
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KHConstraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [constraintArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:KVContraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [self.superview addConstraints:constraintArray];
}
@end
