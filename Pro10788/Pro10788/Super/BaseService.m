//
//  BaseService.m
//  Pro10788
//
//  Created by WangJiangLei on 20/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

-(id)initWithDelegate:(id)viewController{
    if (self = [super init]) {
        self.delegate = viewController;
    }
    return self;
}
@end
