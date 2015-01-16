//
//  M2ViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "M2ViewController.h"
#import "M2SubViewController.h"
#import "ContactCoreDataStorageObject.h"
#import "ContactCoreDataStorage.h"
@interface M2ViewController ()

@end

@implementation M2ViewController
@synthesize fetchedResultController = _fetchedResultController;
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
    self.view.backgroundColor = [UIColor redColor];
    self.tableViewMain =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableViewMain setBackgroundColor:[UIColor whiteColor]];
    self.tableViewMain.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableViewMain.dataSource = self;
    self.tableViewMain.delegate   = self;
    [self.view addSubview:self.tableViewMain];
    
    [self.tableViewMain layoutFullInSuper];
    _header = [[MJRefreshHeaderView alloc]initWithScrollView:self.tableViewMain];
    _header.delegate = self;
    
    self.tapBlock = ^{
        NSLog(@"tapblocK");
    };
    self.closeKeyboardBlock = ^(CGFloat height){
        NSLog(@"closekeyboardBlock -->%f",height);
    };
}

-(void)configureAll{

    [super configureAll];
    const char* text= "hello";
    
    int a = 1;
    void (^blk)(void) = ^{
        printf("val->>%d",a);
        printf("%c\n",text[2]);
        
    };
    blk();
    
    NSError *error = nil;
    if (![[self fetchedResultController]performFetch:&error]) {
        // Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.titleView = [UILabel labelWithContent:@"CoreData相关"];
    self.navigationItem.titleView = [UIButton buttonWithNImage:mImageByName(@"trends") pImage:mImageByName(@"trends") delegate:self selector:@selector(changeDataBase:)];
    self.navigationItem.leftBarButtonItem = [UIButton barButtonItemWithTitle:@"清数据" target:self action:@selector(clearData:)];
    self.navigationItem.rightBarButtonItem = [UIButton barButtonItemWithTitle:@"加数据" target:self action:@selector(insertData:)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(void)changeDataBase:(id)sender{
    
}
-(void)insertData:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dic =@{@"name" :[NSString stringWithFormat:@"%@",[NSDate new]],
                             @"email":@"wsd",
                             @"age"  :@([self.tableViewMain numberOfRowsInSection:0])
                             };
        [[ContactCoreDataStorage sharedInstance]insertContactData:dic];
    });

}

-(void)clearData:(id )sender{
    
    [[ContactCoreDataStorage sharedInstance]clearAllData];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    //请求数据
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshView endRefreshing];
    });
}


-(NSFetchedResultsController *)fetchedResultController{
    if (_fetchedResultController) {
        return _fetchedResultController;
    }
    _fetchedResultController = [[ContactCoreDataStorage sharedInstance] fetchedResultController];
    _fetchedResultController.delegate = self;
    return _fetchedResultController;
}

-(void)requestData{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id sectionInfo = [[_fetchedResultController sections]objectAtIndex:section];
    return  [sectionInfo numberOfObjects];
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    ContactCoreDataStorageObject *obj = [_fetchedResultController objectAtIndexPath:indexPath];
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@--%@", obj.email,obj.age];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"-%@",obj.name];
    UIButton *button = [UIButton buttonWithStr:@"change"];
    
    [button sizeToFit];
    cell.accessoryView = button;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *const strCellIdentifier = @"cellID";
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:strCellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    M2SubViewController *sub = [[M2SubViewController alloc]init];
    [self.navigationController pushViewController:sub animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ContactCoreDataStorageObject *contactId = [_fetchedResultController objectAtIndexPath:indexPath];
        [[ContactCoreDataStorage sharedInstance]deleteContactData:contactId];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark- NSFetchedResultController
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableViewMain beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableViewMain;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableViewMain insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableViewMain deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableViewMain endUpdates];
    [self scrollToBottom];
}

-(void)scrollToBottom
{
    NSInteger sections = [self.tableViewMain numberOfSections];
    
    if (sections > 0) {
        NSInteger rows = [self.tableViewMain numberOfRowsInSection:sections - 1];
        if (rows > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rows - 1 inSection:sections - 1];
            [self.tableViewMain scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
}

@end
