//
//  ContentViewProtocal.h
//  Air6200
//
//  Created by 江磊 on 8/30/14.
//  Copyright (c) 2014 Jianglei Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContentViewProtocal <NSObject>
@required
- (void)reloadViewWithURL:(NSURL *)url;
@end
