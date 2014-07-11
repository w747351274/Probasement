//
//  BlockTestViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 17/3/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BlockTestViewController.h"
#import <objc/runtime.h>
#import "TreeNodeCoreDataStorage.h"
#import "TreeNodeCoreDataStorageObject.h"
@interface BlockTestViewController ()

@end

@implementation BlockTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initViews{
//    [super initViews];
    NSLog(@"blockTestController--initViews");
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.pagingEnabled = YES;
    CGRect rect = tableView.frame;
    tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    tableView.frame = rect;
    
    [self.view addSubview:tableView];
    
}

static void *EocAlertViewKey = "AlertViewKey";
-(void)askUserAQuestion{
    int a =  [[TreeNodeCoreDataStorage sharedInstance]countInManagedObjectContext];
    NSLog(@"a--%d",a);
    
    NSDictionary *dic = @{@"sortId":[NSNumber numberWithDouble:12345],@"name":@"treenodeDesc",
                          @"desc":@"name2222"
                          };
    [[TreeNodeCoreDataStorage sharedInstance]insertContactData:dic];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Associated"
                                                 message:@"AssociatedBlock"
                                                delegate:self
                                       cancelButtonTitle:@"cancel"
                                       otherButtonTitles:@"OK", nil];
    
    void(^AlertBlock)(NSInteger index)=^(NSInteger index){
        NSLog(@"index -->%ld",(long)index);
    };
    objc_setAssociatedObject(av,EocAlertViewKey,AlertBlock,OBJC_ASSOCIATION_COPY);
    [av show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^AlertBlock)(NSInteger index) = objc_getAssociatedObject(alertView, EocAlertViewKey);
    AlertBlock(buttonIndex);
}
-(void)configureAll{
    [super configureAll];
    id obj =[self getBlockArray];
    typedef void(^blk_t1) (void);
    blk_t1 blk = (blk_t1)[obj objectAtIndex:1];
    blk();
    
    //block变量存储
    __block int val = 0;
    void (^blk3)(void) = [^{++val;} copy];
    ++val;
    blk3();
    NSLog(@"%d",val);
    blk_t bk = ^(int a){
        val +=a;
        return a;
    };
    bk(2);
    NSLog(@"%d",val);
//判断一个类的继承关系
    NSLog(@"blockTestController--configureAll");
    NSLog(@"%d",[self isKindOfClass:[UIViewController class]]);
    NSLog(@"%d",[self isMemberOfClass:[UIViewController class]]);
    if ([self isKindOfClass:[UIViewController class]]) {
        NSLog(@"self isKindOfClass:[UIViewController class]");
    }
    if ([self isMemberOfClass:[UIViewController class]]) {
        NSLog(@"self isMemberOfClass:[UIViewController class]");
    }
    if ([self isKindOfClass:[BlockTestViewController class]]) {
        NSLog(@"self isKindOfClass:[BlockTestViewController class]");
    }
    if ([self isMemberOfClass:[BlockTestViewController class]]) {
        NSLog(@"self isMemberOfClass:[BlockTestViewController class]");
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [UILabel labelWithContent:@"Block"];
    self.navigationItem.rightBarButtonItem = [UIButton barButtonItemWithTitle:@"关联对象" target:self action:@selector(askUserAQuestion)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UserTest
blk_t func(int rate){
    return ^(int count){
        return rate*count;
    };
}
-(id)getBlockArray{
    int val = 10;
    return @[[^{NSLog(@"blk0:%d",val);} copy],
            [^{NSLog(@"blk1:%d",val);} copy]];
    NSLog(@"val -->%d",val);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return mScreenWidth;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    for (int a = 0 ; a < 7 ; a++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:mImageByName(@"trends")];
        [imageView setCenter:ccp((mScreenWidth/7)*a + imageView.width/2 + 10, 44/2)];
        [cell addSubview:imageView];
    }
    return cell;
}
@end
