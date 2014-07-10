//
//  ContactCoreDataStorage.m
//  Pro10788
//
//  Created by WangJiangLei on 27/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "ContactCoreDataStorage.h"

@implementation ContactCoreDataStorage
static ContactCoreDataStorage *sharedInstance;

+(ContactCoreDataStorage *)sharedInstance{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[ContactCoreDataStorage alloc] initWithDatabaseFilename:nil];
	});
	
	return sharedInstance;
}
- (id)insertContactData:(NSDictionary *)dic {
     __block ContactCoreDataStorageObject *contactObj = nil;
    [self executeBlock:^{
        NSManagedObjectContext *moc = [self managedObjectContext];
        if (dic == nil) {
            return;
        }
        contactObj= [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([ContactCoreDataStorageObject class])
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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:NSStringFromClass([ContactCoreDataStorageObject class])];
    fetchRequest.fetchBatchSize = 20;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(age >= 100) and (age <= 200)"]];
    [fetchRequest setResultType:NSManagedObjectIDResultType];
    return fetchRequest;
}

-(NSFetchedResultsController *)fetchedResultController{
    NSManagedObjectContext *moc =[self mainThreadManagedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ContactCoreDataStorageObject class]) inManagedObjectContext:moc];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:entity];
    //    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(age >= 100) and (age <= 200)"]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
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
                    ContactCoreDataStorageObject *contactCoreDataStorageObject = (ContactCoreDataStorageObject *)[mainContext objectWithID:contactId];
                    [mutableContact addObject:contactCoreDataStorageObject];
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
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ContactCoreDataStorageObject class])
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
- (void)deleteContactData:(ContactCoreDataStorageObject *)obj{
    
    __block ContactCoreDataStorageObject *contactObj = obj;
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
        NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([ContactCoreDataStorageObject class])
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
    
    return [NSEntityDescription entityForName:NSStringFromClass([ContactCoreDataStorageObject class])
                                                             inManagedObjectContext:moc];
}
@end
