//
//  PMCoreDataHelper.m
//  CoreDataHelper
//
//  Created by Pedro Mancheno on 5/23/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMCoreDataHelper.h"

#import "PMFileSystemHelper.h"

static NSString *const kCoreDataModelFileName = @"Lifesum";
static NSString *const kSqliteStoreFilename = @"SQLitStore";

@interface PMCoreDataHelper()

@property (nonatomic, strong) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel          *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator  *persistentStoreCoordinator;

@property (strong, nonatomic) dispatch_queue_t              queue;

@end

@implementation PMCoreDataHelper

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static PMCoreDataHelper *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    if (self = [super init]) {
        self.queue = dispatch_queue_create([NSStringFromClass(self.class) UTF8String], 0);
    };
    
    return self;
}

#pragma mark CoreData Stack

- (void)setupCoreDataStack
{
    self.managedObjectContext = nil;
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
    
    [self createManagedObjectContext];
}

- (void)createManagedObjectContext
{
    if (!self.persistentStoreCoordinator)
        [self createPersistentStoreCoordinator];
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.undoManager = nil;
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (void)createManagedObjectModel
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kCoreDataModelFileName withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

- (void)createPersistentStoreCoordinator
{
    if (!self.managedObjectModel)
        [self createManagedObjectModel];
    
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSURL *storeURL = [self databaseURL];
    NSError *error = nil;
    if (![self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                       configuration:nil
                                                                 URL:storeURL
                                                             options:@{
                                                                       NSMigratePersistentStoresAutomaticallyOption:@YES,
                                                                       NSInferMappingModelAutomaticallyOption:@YES
                                                                       }
                                                               error:&error])
    {
        // SS: Put non-Lightweight Migration code here when needed
        
        // Warn the user that we'll be shutting down due to an inability to upgrade the DB
        NSString *errorMessage = @"Your existing database is incompatible with this version of the app. Please uninstall this version and install the new version.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Database Error"
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil]; // Released in button responder
        [alert show];
        
        NSLog(@"Unresolved Core Data error %@, %@. Likely caused by existing database being unupgradable.", error, [error userInfo]);
    }
}

- (BOOL)coreDataStackIsSetup
{
    return self.managedObjectContext != nil;
}

- (void)clearCoreDataStack
{
    self.managedObjectContext = nil;
    self.persistentStoreCoordinator = nil;
    self.managedObjectModel = nil;
    
    // delete database file after clearing stack
    [PMFileSystemHelper deleteFile:[self databaseURL].path];
}

#pragma mark - Helper methods

- (void)refreshManagedObjectContext
{
    NSManagedObjectContext *context = self.managedObjectContext;
    for (NSManagedObject *obj in [context registeredObjects])
    {
        [context refreshObject:obj mergeChanges:NO];
    }
}

- (NSManagedObjectContext*)createBackgroundContext
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.undoManager = nil;
    context.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backgroundContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:context];
    
    return context;
}

- (void)backgroundContextDidSave:(NSNotification*)notification
{
    if ([NSThread isMainThread])
    {
        [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
        return;
    }
    
    // Merge syncronously to avoid race conditions
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[self managedObjectContext] mergeChangesFromContextDidSaveNotification:notification];
    });
}

#pragma mark - Background Operations

- (void)performInBackground:(void(^)(NSManagedObjectContext *context, NSError **pError))block
                 completion:(void(^)(BOOL success, NSError *error))completion
{
    NSParameterAssert(block);
    
    NSManagedObjectContext *context = [self createBackgroundContext];
    dispatch_async(self.queue, ^{
        NSError *error = nil;
        block(context, &error);
        
        BOOL success = (error == nil);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion)
                completion(success, error);
        });
    });
}

- (void)performAndSaveInBackground:(void(^)(NSManagedObjectContext *context, NSError **pError))block
                        completion:(void(^)(BOOL success, NSError *error))completion
{
    NSParameterAssert(block);
    
    NSManagedObjectContext *context = [self createBackgroundContext];
    dispatch_async(self.queue, ^{
        NSError *error = nil;
        block(context, &error);
        
        BOOL success = (error == nil);
        if (success)
            success = [context save:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion)
                completion(success, error);
        });
    });
}

#pragma mark -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    abort();
}

#pragma mark - Accessors

- (NSString *)sqliteStoreFilename
{
    return kSqliteStoreFilename;
}

- (NSString*)databaseFileName
{
    return [NSString stringWithFormat:@"%@.sqlite", self.sqliteStoreFilename];
}

- (NSURL*)databaseURL
{
    return [APP_DOC_DIR_URL URLByAppendingPathComponent:[self databaseFileName]];
}

- (NSString*)databaseFileLocation
{
    return [APP_DOC_DIR stringByAppendingPathComponent:[self databaseFileName]];
}

@end
