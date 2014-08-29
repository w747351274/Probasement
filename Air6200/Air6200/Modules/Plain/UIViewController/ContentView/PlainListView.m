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
    self.backgroundColor = [UIColor redColor];
    UILabel *label = [UILabel labelWithContent:@"plainListViewController"];
    [self addSubview:label];
    [label layoutTopInSuperwithMarginSize:CGSizeMake(50, 100)];
    tableViewMain = [[UITableView alloc]init];
    tableViewMain.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    tableViewMain.delegate = self;
    tableViewMain.dataSource = self;
    [self addSubview:tableViewMain];
    [tableViewMain layoutFullInSuper];
    self.service = [[PlainService alloc]init];
};
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (NSInteger)[self.service plainDataSource].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellId];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"文章%d",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSString *path = [NSString pathFromFileNamed:[self.service plainDataSource][indexPath.row]] ;
    if ([self.delegate respondsToSelector:@selector(selectedPlainUrl:)]) {
        [self.delegate selectedPlainUrl:path];
    }
}
@end
