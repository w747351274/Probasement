//
//  BTFileTools.m
//  XMPPClient
//
//  Created by zhihuiguan on 14-5-15.
//  Copyright (c) 2014年 zhihuiguan. All rights reserved.
//

#import "FileTools.h"

@implementation FileTools

+(NSString *)appDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)appCachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)applicationSupportDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)appTemporaryDirectory
{
    return NSTemporaryDirectory();
}

+(NSString *)currentUserDirectory
{
//    XMPPStream *stream = [[((AppDelegate *)[[UIApplication sharedApplication] delegate]) xmppManager] xmppStream];
//    
//    if (!stream || !stream.myJID) {
//        return nil;
//    }
    
    NSString *userJID = @"str";
    
    return [self userDirectoryWithID:userJID];
}

+(NSString *)userDirectoryWithID:(NSString *)userID
{
    if (!userID) {
        return nil;
    }
    
    NSString *appDocDir = [self appDocumentsDirectory];
    
    NSString *rootUserDir = [appDocDir stringByAppendingPathComponent:@"user"];
//    if (![self resolveDirectoryAtPath:rootUserDir]) {
//        return nil;
//    }
// Intermediate YES
    
    NSString *userDir = [rootUserDir stringByAppendingPathComponent:userID];
    if (![self resolveDirectoryAtPath:rootUserDir]) {
        return nil;
    }
    
    return userDir;
}

+(BOOL)resolveDirectoryAtPath:(NSString *)dirPath
{
    if (!dirPath) {
        NSLog(@"Error unresolved path: %@", dirPath);
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir] || !isDir) {
        NSError *error = nil;
        BOOL result = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!result) {
            NSLog(@"%@", [NSString stringWithFormat:@"%@: Unresolved error %@, %@", [self class], error, [error userInfo]]);
            return NO;
        }
    }
    
    return YES;
}

@end


@implementation FileTools (Conversation)

+(NSString *)audioDirectory
{
    NSString *currentUserDir = [self currentUserDirectory];
    if (!currentUserDir) {
        return nil;
    }
    
    NSString *dir = [currentUserDir stringByAppendingPathComponent:@"audio"];
    if (![self resolveDirectoryAtPath:dir]) {
        return nil;
    }
    
    return dir;
}

+(NSString *)originalImageDirectory
{
    NSString *currentUserDir = [self currentUserDirectory];
    if (!currentUserDir) {
        return nil;
    }
    
    NSString *dir = [currentUserDir stringByAppendingPathComponent:@"image_original"];
    if (![self resolveDirectoryAtPath:dir]) {
        return nil;
    }
    
    return dir;
}

+(NSString *)thumbnailImageDirectory
{
    NSString *currentUserDir = [self currentUserDirectory];
    if (!currentUserDir) {
        return nil;
    }
    
    NSString *dir = [currentUserDir stringByAppendingPathComponent:@"image_thumbnail"];
    if (![self resolveDirectoryAtPath:dir]) {
        return nil;
    }
    
    return dir;
}

+(NSString *)videoDirectory
{
    NSString *currentUserDir = [self currentUserDirectory];
    if (!currentUserDir) {
        return nil;
    }
    
    NSString *dir = [currentUserDir stringByAppendingPathComponent:@"video"];
    if (![self resolveDirectoryAtPath:dir]) {
        return nil;
    }
    
    return dir;
}

+(NSString *)thumbnailFileNameWithOriginalName:(NSString *)originalName
{
    if (!originalName) {
        return nil;
    }
    
    //缩略图名称 => 原始文件名后 + (.png) 例如：ImageFile.JPG => ImageFile.JPG.png   VideoFile.MOV => VideoFile.MOV.png
    return [NSString stringWithFormat:@"%@.png", originalName];
}

@end


@implementation FileTools (Avatar)

+(NSString *)avatarDirectory
{
    NSString *currentUserDir = [self currentUserDirectory];
    if (!currentUserDir) {
        return nil;
    }
    
    NSString *dir = [currentUserDir stringByAppendingPathComponent:@"avatar"];
    if (![self resolveDirectoryAtPath:dir]) {
        return nil;
    }
    
    return dir;
}

@end
