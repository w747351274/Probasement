//
//  M1ViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "M1ViewController.h"

@interface M1ViewController ()

@end

@implementation M1ViewController
@synthesize dataStorage;
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
    textFieldName =[UITextField textFieldWithPlaceholder:@"name"];
    textFieldEmail =[UITextField textFieldWithPlaceholder:@"email"];
    textFieldAge = [UITextField textFieldWithPlaceholder:@"Age"];
    labelCount = [UILabel labelWithContent:@"count"];
#if DEBUG
    textFieldName.text = @"KKKKKK";
    textFieldEmail.text = @"LLLLLLL";
    textFieldAge.text = @"13";
    
#endif
    
    [self.view addSubview:textFieldName];
    [self.view addSubview:textFieldEmail];
    [self.view addSubview:textFieldAge];
    [self.view addSubview:labelCount];
    [textFieldName layoutTopInSuperwithSize:CGSizeMake(0, 0)];
    
    [textFieldEmail layoutVerticalNextTo:textFieldName];
    
    [textFieldAge layoutVerticalNextTo:textFieldEmail];
    
    
    
    UIButton *btnRegister = [UIButton buttonWithStr:@"增加"];
    [btnRegister addTarget:self action:@selector(actionAddContact:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    
    [btnRegister layoutVerticalNextTo:textFieldAge];
    
    UIButton *btnShowContact = [UIButton buttonWithStr:@"查询"];
    [btnShowContact addTarget:self action:@selector(actionShowContact:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnShowContact];
    [btnShowContact layoutVerticalNextTo:btnRegister];
     [labelCount layoutVerticalNextTo:btnShowContact ofSize:CGSizeMake(100, 100)];
}
-(void)configureAll{
    [super configureAll];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [UILabel labelWithContent:@"布局相关"];
    
}

-(void)actionAddContact:(UIButton *)btn{

    NSDictionary *dict = @{@"name": [NSString stringWithFormat:@"%@",textFieldName.text],
                           @"email": [NSString stringWithFormat:@"%@",textFieldEmail.text],
                           @"age":[NSNumber numberWithInt:[textFieldAge.text intValue]]};
   [[ContactCoreDataStorage sharedInstance] insertContactData:dict];
    
    labelCount.text =[NSString stringWithFormat:@"count:->%d" ,[[ContactCoreDataStorage sharedInstance]countInManagedObjectContext]];

}

-(void)actionShowContact:(UIButton *)btn{
    
    ContactCoreDataStorage *contactDataStorage = [ContactCoreDataStorage sharedInstance];
    contactDataStorage.showDataInMain = ^(NSMutableArray *mutableContact){
        for (ContactCoreDataStorageObject *contact in mutableContact) {
            NSLog(@"name-->%@,email--->%@,age-->%@",contact.name,contact.email,contact.age);
        }
    };
    [contactDataStorage showData];
}
-(NSFetchRequest *)newFetchRequest{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ContactCoreDataStorageObject class])];
    fetchRequest.fetchBatchSize = 20;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(age >= 100) and (age <= 200)"]];
    [fetchRequest setResultType:NSManagedObjectIDResultType];
    return fetchRequest;
}

-(void)processContacts:(NSArray *)arr{
    for (ContactCoreDataStorageObject *contact in arr) {
        NSLog(@"name-->%@,email--->%@,age-->%@",contact.name,contact.email,contact.age);
    }
}

@end

