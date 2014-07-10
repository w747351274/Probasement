//
//  TreeNodeCoreDataStorageObject.h
//  Pro10788
//
//  Created by WangJiangLei on 14/5/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TreeNodeCoreDataStorageObject;

@interface TreeNodeCoreDataStorageObject : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * sortId;
@property (nonatomic, retain) TreeNodeCoreDataStorageObject *parent;

@end
