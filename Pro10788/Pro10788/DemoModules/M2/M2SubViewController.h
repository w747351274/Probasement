//
//  M2SubViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 24/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//
#import <ProService/GCDMulticastDelegate.h>
#import "M2ViewProtocal.h"
#import "M2Service2.h"
#import "M2Service.h"

@interface M2SubViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>{
    GCDMulticastDelegate<M2ViewProtocal> *multicast;
    dispatch_queue_t queue;
    //多播委托
    M2Service *m1;
    M2Service2 *m2;
}
@property(nonatomic,strong)UITableView *tableViewMain;
@property(nonatomic,strong)id<M2ViewProtocal> service;
@end
