//
//  PlainListView.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainListView.h"
#import "PlainService.h"

@implementation PlainListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initViews{
    [super initViews];
    tableViewMain = [[UITableView alloc]init];
    tableViewMain.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableViewMain.delegate = self;
    tableViewMain.dataSource = self;
    [self addSubview:tableViewMain];
    [tableViewMain layoutFullInSuper];
    self.service = [[PlainService alloc]init];
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (NSInteger)[self.service plainDataSource].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellId];
    }
    NSString *strRowContent =  [[self.service plainDataSource][indexPath.row] objectForKey:@"description"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d.%@",indexPath.row+1,strRowContent];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fileName = [[self.service plainDataSource][indexPath.row] objectForKey:@"fileName"];
    NSString *path = [self.service dataFilePath:fileName];
    if ([self.delegate respondsToSelector:@selector(selectedPlainUrl:)]) {
        [self.delegate selectedPlainUrl:path];
    }
}
-(void)showDefaultContent{
    if ([self.delegate respondsToSelector:@selector(selectedPlainUrl:)]) {
        [self.delegate selectedPlainUrl:[self.service defaultContentFile]];
    }
}
@end
