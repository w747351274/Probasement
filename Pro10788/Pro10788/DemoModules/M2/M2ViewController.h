//
//  M2ViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ProService/MJRefresh.h>
#import <CoreData/NSFetchedResultsController.h>
#import <ProService/BaseViewController.h>
@interface M2ViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,NSFetchedResultsControllerDelegate>{
    MJRefreshHeaderView *_header;
    NSMutableArray *arrDataSource;
}
@property(nonatomic,strong) UITableView *tableViewMain;
@property(nonatomic, strong) NSFetchedResultsController *fetchedResultController;

@end
