//
//  TreeNodeCoreDataStorage.m
//  Pro10788
//
//  Created by WangJiangLei on 14/5/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "TreeNodeCoreDataStorage.h"

@implementation TreeNodeCoreDataStorage
static TreeNodeCoreDataStorage *sharedInstance;

+(TreeNodeCoreDataStorage *)sharedInstance{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[TreeNodeCoreDataStorage alloc] initWithDatabaseFilename:nil];
	});
	
	return sharedInstance;
}
- (id)insertContactData:(NSDictionary *)dic {
    __block TreeNodeCoreDataStorageObject *contactObj = nil;
    [self executeBlock:^{
        NSManagedObjectContext *moc = [self managedObjectContext];
        if (dic == nil) {
            return;
        }
        contactObj= [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TreeNodeCoreDataStorageObject class])
                                                  inManagedObjectContext:moc];
        NSArray *keys = [dic allKeys];
        for (int i = 0; i < [keys count]; i++)
        {
            [contactObj setValue:[dic objectForKey:keys[i]] forKey:keys[i]];
        }
    }];
    return contactObj;
}

- (NSFetchRequest *)getfetchedRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([TreeNodeCoreDataStorageObject class])];
    fetchRequest.fetchBatchSize = 20;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@""]];
    [fetchRequest setResultType:NSManagedObjectIDResultType];
    return fetchRequest;
}

-(NSFetchedResultsController *)fetchedResultController{
    NSManagedObjectContext *moc =[self mainThreadManagedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TreeNodeCoreDataStorageObject class]) inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entity];
    //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(age >= 100) and (age <= 200)"]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"sortId" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [fetchRequest setIncludesPendingChanges:YES];
    [fetchRequest setFetchBatchSize:5];
    NSFetchedResultsController *tempFetchedResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    
    return tempFetchedResultController;
}

-(void)showData{
    //后台线程取得数据显示到前台线程显示的例子
    __weak NSManagedObjectContext *mainContext = [self mainThreadManagedObjectContext];
    __block NSMutableArray *mutableContact = nil;
    NSManagedObjectContext *backgroundContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    backgroundContext.persistentStoreCoordinator = [self persistentStoreCoordinator];
    [backgroundContext performBlock:^{
        NSError *err = nil;
        NSArray *contactIds = [backgroundContext executeFetchRequest:[self getfetchedRequest] error:&err];
        if (contactIds != nil && err ==nil) {
            mutableContact = [[NSMutableArray alloc]initWithCapacity:contactIds.count];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (NSManagedObjectID *contactId in contactIds) {
                    
                    TreeNodeCoreDataStorageObject *treeNode = (TreeNodeCoreDataStorageObject *)[mainContext objectWithID:contactId];
                    [mutableContact addObject:treeNode];
                }
                
                if (self.showDataInMain) {
                    self.showDataInMain(mutableContact);
                }
            });
        }
    }];
}

-(void)clearAllData{
    
    [self executeBlock:^{
        NSManagedObjectContext *moc = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TreeNodeCoreDataStorageObject class])
                                                  inManagedObjectContext:moc];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        [fetchRequest setIncludesPendingChanges:YES];
        [fetchRequest setFetchLimit:1000];
        NSArray * results = [moc executeFetchRequest:fetchRequest error:nil];
        [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [moc deleteObject:obj];
        }];
    }];
}
- (void)deleteContactData:(TreeNodeCoreDataStorageObject *)obj{
    
    __block TreeNodeCoreDataStorageObject *contactObj = obj;
    [self executeBlock:^{
        NSManagedObjectContext *moc = [self managedObjectContext];
        //因为这个数据是在主线程MOC里获取的，要重新从子线程获取对象然后删除
        [moc deleteObject:[moc objectWithID:contactObj.objectID]];
    }];
}
-(int )countInManagedObjectContext{
    
    __block NSArray *results;
    [self executeBlock:^{
        NSManagedObjectContext *moc = [self managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([TreeNodeCoreDataStorageObject class])
                                                  inManagedObjectContext:moc];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        [fetchRequest setIncludesPendingChanges:YES];
        [fetchRequest setFetchLimit:1000];
        results = [moc executeFetchRequest:fetchRequest error:nil];
    }];
    return (int)results.count;
}
-(NSEntityDescription *)contactEntity:(NSManagedObjectContext *)moc{
    
    return [NSEntityDescription entityForName:NSStringFromClass([TreeNodeCoreDataStorageObject class])
                       inManagedObjectContext:moc];
}
@end
