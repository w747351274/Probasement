//
//  PlainContentView.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseView.h>
#import "ContentViewProtocal.h"

@interface PlainContentView : BaseView{

}
@property(nonatomic,strong) UIView<ContentViewProtocal> *content;
-(void)reloadContent:(NSString *)url;
-(void)layoutEqualSizeNextTo:(id)controller;
-(void)layoutEqualSize:(id)controller withXPoint:(CGFloat )x;
@end
