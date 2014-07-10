//
//  ContactCoreDataStorageObject.h
//  Pro10788
//
//  Created by WangJiangLei on 27/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactCoreDataStorageObject : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * age;

@end
