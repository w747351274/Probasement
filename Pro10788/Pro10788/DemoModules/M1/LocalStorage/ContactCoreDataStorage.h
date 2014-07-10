//
//  ContactCoreDataStorage.h
//  Pro10788
//
//  Created by WangJiangLei on 27/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "ContactCoreDataStorageObject.h"
@interface ContactCoreDataStorage : CoreDataStorage


+(ContactCoreDataStorage *)sharedInstance;
-(NSEntityDescription *)contactEntity:(NSManagedObjectContext *)moc;
- (id)insertContactData:(NSDictionary *)dict;
-(void)clearAllData;
-(int )countInManagedObjectContext;
-(void)showData;
- (void)deleteContactData:(ContactCoreDataStorageObject *)obj;
-(NSFetchedResultsController *)fetchedResultController;
@end
