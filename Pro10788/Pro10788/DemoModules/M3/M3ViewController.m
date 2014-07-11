//
//  M3ViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "M3ViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface M3ViewController ()

@end

@implementation M3ViewController

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
    progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 200, 320, 10)];
    [self.view addSubview:progress];
    progress2 = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 300, 320, 10)];
    [self.view addSubview:progress2];
    
    UIButton *btnPro = [UIButton buttonWithStr:@"requestData"];
    [btnPro setCenter:ccp(CEN_X(progress), CEN_Y(progress)+V_H(btnPro))];
    [btnPro addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPro];
    
    UIButton *btnMessage = [UIButton buttonWithStr:@"AlertUTF8"];
    [btnMessage setCenter:ccp(CEN_X(progress), V_BOT_Y(btnPro) + V_H(btnMessage)/2 +15)];
    [btnMessage addTarget:self action:@selector(actionAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMessage];

}
-(void)configureAll{
    [super configureAll];
    self.service = [[M3Service alloc]initWithDelegate:self];
    [self.service makeHappy];
//    [self showHttpWaiting];
//    [self.service loadDataWithProgress:progress];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [UILabel labelWithContent:@"网络请求"];
    UIImageView *imgCell = [[UIImageView alloc]init];
    NSURL *url = [NSURL URLWithString:@"http://s7.sinaimg.cn/small/60f977e74a767f8c0cdd6&690"];

    [imgCell sd_setImageWithURL:url placeholderImage:UIResourceBundleImage(@"sanji") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [imgCell sizeToFit];
    }];

    [imgCell setFrame:CGRectMake(10, 3, 36, 36)];
    [self.view addSubview:imgCell];
    
    
}

-(void)actionBtn:(UIButton *)btn{
    NSLog(@"request begin");
    
    
    [HttpUtil requestWithUrl:@"http://allseeing-i.com/ASIHTTPRequest/tests/images/large-image.jpg" withCompleteBlock:^(NSDictionary *dict) {
        NSLog(@"dict->%@",dict);
    } errorBlock:^(NSError *error) {
        NSLog(@"errot->%@",error);
    } downLoadProgress:progress2];
}
-(void)actionAlert:(UIButton *)sender{
    [HttpUtil requestWithUrl:@"http://192.168.1.121:8011/CharServlet/CharService" withCompleteBlock:^(NSDictionary *dict) {
        NSString *content = dict[@"data"];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:content
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"OK", nil];
        [av show];

    } errorBlock:^(NSError *error) {
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    int a= 11;
    int *b;
    b =  &a;
    a = 12;
    
    int cc ;
    cc =  *b;
    NSLog(@"integer afterchange b-->%d , cc -->%d",*b ,cc);
 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)message{
    NSLog(@"show Messgae!");
}
-(void)haveFun{
    NSLog(@"couldHaveFun");
}
-(void)dataReceived:(NSDictionary *)dict{
    __block UILabel * prevObj = nil;
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *strKey = [NSString stringWithFormat:@"%@",key];
        NSString *strValue = [NSString stringWithFormat:@"%@",obj];
        UILabel *label = [UILabel labelWithContent:[NSString stringWithFormat:@"%@:%@",strKey,strValue]];
        [self.view addSubview:label];
        
        if (prevObj) {
            [label layoutVerticalNextTo:prevObj];
        }else{
            [label layoutTopInSuperwithSize:CGSizeMake(0, 0)];
        }
        prevObj = label;
    }];
    [self hideWaiting];
}

@end
