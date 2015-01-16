//
//  ResourseManager.h
//  Pro10788
//
//  Created by Jianglei Wang on 2014/09/12.
//  Copyright (c) 2014年 江磊. All rights reserved.
//

#import <Foundation/Foundation.h>

CG_INLINE UIImage * UIResourceBundleImage(NSString *strPath){
    return [UIImage imageNamed:[NSString stringWithFormat:@"default.bundle/image/%@.png",strPath]];
}

@interface ResourseManager : NSObject

@end
