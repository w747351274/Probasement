//
//  PlainViewController.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseViewController.h>
#import "PlainListView.h"
#import "PlainContentView.h"

@interface PlainViewController : BaseViewController<PlainSelectedProtocol>{
    PlainListView *plainListView;
    PlainContentView *plainContentView;
    BOOL isContentFull;
}

@end
