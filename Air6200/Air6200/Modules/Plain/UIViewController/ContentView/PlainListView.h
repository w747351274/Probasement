//
//  PlainListView.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseView.h>
#import "PlainProtocol.h"

@protocol PlainSelectedProtocol <NSObject>

-(void)selectedPlainUrl:(NSString *)url;
@end

@interface PlainListView : BaseView<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UITableView *tableViewMain;
    UIView * viewShadow;
}
@property(nonatomic, strong)id<PlainProtocol> service;
@property(nonatomic, weak)  id<PlainSelectedProtocol> delegate;
-(void)showDefaultContent;
@end
