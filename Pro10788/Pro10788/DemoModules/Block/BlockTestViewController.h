//
//  BlockTestViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 17/3/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ProService/BaseViewController.h>
typedef int (^blk_t) (int);
@interface BlockTestViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UISearchBarDelegate>
@end
