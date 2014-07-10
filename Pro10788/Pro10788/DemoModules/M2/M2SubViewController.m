//
//  M2SubViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 24/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "M2SubViewController.h"
@interface M2SubViewController ()

@end

@implementation M2SubViewController
@synthesize tableViewMain;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initViews{
    [super initViews];
    
    //单个实例的委托方式
    self.service = [[M2Service2 alloc]init];
    queue = dispatch_queue_create("Delegate", NULL);
    
    //多播委托
    m1 = [[M2Service alloc]init];
    m2 = [[M2Service2 alloc]init];
    
    multicast = (GCDMulticastDelegate<M2ViewProtocal> *)[[GCDMulticastDelegate alloc]init];
    [multicast addDelegate:m1 delegateQueue:queue];
    [multicast addDelegate:m2 delegateQueue:queue];

    self.navigationItem.rightBarButtonItem = [UIButton barButtonItemWithTitle:@"multicast" target:self action:@selector(actionMultiCast:)];
    self.tableViewMain = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableViewMain.delegate = self;
    self.tableViewMain.dataSource = self;
    [self.view addSubview:self.tableViewMain];
    [self.tableViewMain layoutFullInSuper];
}

-(void)actionMultiCast:(id)sender{
    [multicast m2DataSource];
}
-(void)configureAll{
    [super configureAll];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[self service] respondsToSelector:@selector(m2DataSource)]) {
        return [[self service]m2DataSource].count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellId";
    UITableViewCell *cell = [tableViewMain dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *str = [[[self service]m2DataSource]objectAtIndex:indexPath.row];
    
    cell.textLabel.text = str;
    return cell;
}

@end
