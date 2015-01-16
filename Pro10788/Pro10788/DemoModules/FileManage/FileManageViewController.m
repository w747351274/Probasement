//
//  FileManageViewController.m
//  Pro10788
//
//  Created by Jianglei Wang on 2014/09/17.
//  Copyright (c) 2014年 江磊. All rights reserved.
//

#import "FileManageViewController.h"
#import "FileTools.h"

@interface FileManageViewController ()

@end

@implementation FileManageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView {
    [super loadView];
    //self.wantsFullScreenLayout = YES; //could add this for translucent status bars
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
}
-(void)initViews{
    [super initViews];
    NSArray *arrtest = @[@{@"loginname":@"lloginname1",@"jid":@"32222332223",@"groupid":@"groupid111",@"loginpwd":@"loginpwd1222"},@{@"loginname":@"lloginname2",@"jid":@"32222332223",@"groupid":@"groupid111",@"loginpwd":@"loginpwd1222"},@{@"loginname":@"lloginname3",@"jid":@"32222332223",@"groupid":@"groupid111",@"loginpwd":@"loginpwd1222"},@{@"loginname":@"lloginname4",@"jid":@"32222332223",@"groupid":@"groupid111",@"loginpwd":@"loginpwd1222"}];

    NSString * fileName = @"sf";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrtest];
    NSString *path = [[FileTools appDocumentsDirectory]stringByAppendingPathComponent:fileName] ;

    if ([data writeToFile:path atomically:NO]) {
        
        NSData * dataRead = [NSData dataWithContentsOfFile:path];
        NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:dataRead];
        NSLog(@"dd%@",arr2);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"filemanage";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
