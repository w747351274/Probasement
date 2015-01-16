//
//  BTFileTools.h
//  XMPPClient
//
//  Created by zhihuiguan on 14-5-15.
//  Copyright (c) 2014年 zhihuiguan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileTools : NSObject

+(NSString *)appDocumentsDirectory;

+(NSString *)appCachesDirectory;

+(NSString *)applicationSupportDirectory;

+(NSString *)appTemporaryDirectory;

+(NSString *)currentUserDirectory;

+(NSString *)userDirectoryWithID:(NSString *)userID;

+(BOOL)resolveDirectoryAtPath:(NSString *)dirPath;

@end


@interface FileTools (Conversation)

+(NSString *)audioDirectory;
+(NSString *)originalImageDirectory;
+(NSString *)thumbnailImageDirectory;
+(NSString *)videoDirectory;

+(NSString *)thumbnailFileNameWithOriginalName:(NSString *)originalName;

@end


@interface FileTools (Avatar)

+(NSString *)avatarDirectory;

@end
