//
//  PlainContentView.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseView.h>
#import "ContentView.h"

@interface PlainContentView : BaseView{
    ContentView *content;
}
-(void)reloadContent:(NSString *)url;
@end
