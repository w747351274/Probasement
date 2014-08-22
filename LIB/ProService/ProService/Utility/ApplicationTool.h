//
//  ApplicationTool.h
//  Pro10788
//
//  Created by WangJiangLei on 19/5/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationTool : NSObject
+(void)pushLocalNotification:(NSString*)alertBody user:(NSDictionary*)userInfo;
@end
