//
//  TextContentView.h
//  Air6200
//
//  Created by 江磊 on 8/30/14.
//  Copyright (c) 2014 Jianglei Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ProService/BaseView.h>
#import "ContentViewProtocal.h"
@interface TextContentView : BaseView<ContentViewProtocal>{
    UILabel *label;
}
- (void)reloadViewWithURL:(NSURL *)url;
@end
