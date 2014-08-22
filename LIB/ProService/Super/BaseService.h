//
//  BaseService.h
//  Pro10788
//
//  Created by WangJiangLei on 20/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//
/**主要提供数据源和delegate，ViewController的业务使用block实现，
 ViewController和service的消息传输主要通过代理模式,viewController和service解耦
1、ViewControler是代理的实现：ViewController使用数据
2、service将数据返回给ViewController
 **/
#import <Foundation/Foundation.h>

@interface BaseService : NSObject

@property (nonatomic , assign)id delegate;

//设置代理的目标

-(id)initWithDelegate:(id)viewController;
@end
