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
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44)];
    searchBar.placeholder = @"検索";
    searchBar.delegate = self;
    tableViewMain.tableHeaderView = searchBar;
    
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
- (void)addShadowToTable{
    if (!viewShadow) {
        viewShadow = [[UIView alloc]initWithFrame:CGRectMake(0, 44, CGRectGetWidth(tableViewMain.frame), CGRectGetHeight(tableViewMain.frame) -44)];
    }
    tableViewMain.bounces = NO;
    [viewShadow setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [tableViewMain addSubview:viewShadow];

}
-(void)removeShadowToTable{
    if (viewShadow) {
        [viewShadow removeFromSuperview];
        tableViewMain.bounces = YES;
        viewShadow = nil;
    }
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    [self addShadowToTable];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [self removeShadowToTable];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchText isEqualToString:@""]){
        [self addShadowToTable];
    }else{
        [self removeShadowToTable];
    }
}

@end