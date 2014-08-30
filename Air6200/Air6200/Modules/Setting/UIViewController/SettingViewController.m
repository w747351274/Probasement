//
//  SettingViewController.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initViews {
    textfield =[[UITextField alloc]init];
    textfield.borderStyle = UITextBorderStyleBezel;
    textfield.autocorrectionType = NO;
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfield.returnKeyType =UIReturnKeyGo;
    textfield.delegate = self;
    textfield.keyboardType = UIKeyboardTypeURL;
    textfield.clearsOnBeginEditing = YES;
    textfield.text = @"https://translate.google.co.jp/#en/zh-CN/NOT%20INTERLACED";
    [self.view addSubview:textfield];
    UIButton *buttonGo = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonGo setTitle:@"前往" forState:UIControlStateNormal];
    [buttonGo setTitle:@"前往" forState:UIControlStateHighlighted];
    [buttonGo addTarget:self action:@selector(goPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonGo];
    
    self.contentView = [[WebContentView alloc]init];
    
    [self.view addSubview:self.contentView];
    
    [textfield layoutTopInSuperwithSize:CGSizeMake(430, 30)];
    [buttonGo layoutHorizontalNextTo:textfield ofSize:CGSizeMake(30, 30)];
    [self.contentView layoutVerticalNextTo:textfield ofSize:CGSizeMake(0, 0)];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textfield resignFirstResponder];
    [self goPage];
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (![textfield.text isEqualToString:@""]) {
        currentSite = textfield.text;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textfield.text isEqualToString:@""]) {
        textfield.text = currentSite;
    }
}
-(void)goPage{
    NSString *strUrl;
    if ([textfield.text hasPrefix:@"http://"]||[textfield.text hasPrefix:@"https://"]) {
        
        strUrl  =[NSString stringWithFormat:@"%@",textfield.text];
    }else{
        strUrl  =[NSString stringWithFormat:@"http://%@",textfield.text];
    }
 
    [self.contentView reloadViewWithURL:[NSURL URLWithString:strUrl]];
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
