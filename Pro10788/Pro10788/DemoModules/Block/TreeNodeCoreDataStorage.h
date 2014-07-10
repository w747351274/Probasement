//
//  TreeNodeCoreDataStorage.h
//  Pro10788
//
//  Created by WangJiangLei on 14/5/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "CoreDataStorage.h"
#import "CoreDataStorageProtected.h"
#import "TreeNodeCoreDataStorageObject.h"

@interface TreeNodeCoreDataStorage : CoreDataStorage{
}

+(TreeNodeCoreDataStorage *)sharedInstance;
-(NSEntityDescription *)contactEntity:(NSManagedObjectContext *)moc;
- (id)insertContactData:(NSDictionary *)dict;
-(void)clearAllData;
-(int )countInManagedObjectContext;
-(void)showData;
- (void)deleteContactData:(TreeNodeCoreDataStorageObject *)obj;
-(NSFetchedResultsController *)fetchedResultController;
@end
