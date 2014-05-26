//
//  PMFileSystemHelper.m
//  CoreDataHelper
//
//  Created by Pedro Mancheno on 5/23/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMFileSystemHelper.h"

@implementation PMFileSystemHelper

+ (NSString *)createDirectoryIfNotExists:(NSString *)folderName
{
    NSError* error;
    BOOL isDir;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSString *directory = [self fullFilePathUnderDocumentsForFile:folderName];
    
    if (!([fileManager fileExistsAtPath:directory isDirectory:&isDir] && isDir))
    {
        BOOL wasDirCreated = [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        
        if(!wasDirCreated)
        {
            NSLog(@"Error creating temporary directory: %@", error);
            return nil;
        }
    }
    
    return directory;
}

+ (NSString *)fullFilePathUnderDocumentsForFile:(NSString *)fileName
{
    return [APP_DOC_DIR stringByAppendingPathComponent:fileName];
}
+ (NSURL *)fullFileURLUnderDocumentsForFile:(NSString*)fileName
{
    return [APP_DOC_DIR_URL URLByAppendingPathComponent:fileName];
}

// Returns true if the folder was successfully cleaned out. Returns false if the directory doesn't exist,
//   or there was an error deleting one of the sub files
+ (BOOL)cleanFolderUnderDocuments:(NSString *)folderName
{
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    
    NSString* folderToClean = [self fullFilePathUnderDocumentsForFile:folderName];
    
    BOOL isDir;
    if (![fileManager fileExistsAtPath:folderToClean isDirectory:&isDir] || !isDir)
        return NO;
    
    NSDirectoryEnumerator* directoryInfo = [fileManager enumeratorAtPath:folderToClean];
    NSError* error = nil;
    uint failCount = 0;
    
    for (NSString *file in directoryInfo)
    {
        BOOL fileDeleteSucceeded = [fileManager removeItemAtPath:[folderToClean stringByAppendingPathComponent:file] error:&error];
        if (!fileDeleteSucceeded || error)
        {
            NSLog(@"fileDelete Failed: %@", error);
            failCount++;
        }
    }
    
    return (failCount == 0);
}

// Returns true if the file was deleted, or if the file wasn't there to start. Returns FALSE otherwise
+ (BOOL)deleteFile:(NSString *)filePath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    if (!fileExists)
        return YES;
    
    NSError *error = nil;
    if(![fileManager removeItemAtPath:filePath error:&error])
    {
        NSLog(@"ERROR: unable to delete file at %@", filePath);
        return NO;
    }
    return YES;
}

+ (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString*)dstPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSError *error = nil;
    if(![fileManager moveItemAtPath:srcPath toPath:dstPath error:&error])
    {
        NSLog(@"ERROR: unable to move file from %@ to %@", srcPath, dstPath);
        return NO;
    }
    return YES;
}

+ (NSString*)cleanFilename:(NSString*)filename
{
    if(!filename) return nil;
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9\\.\\-_]+" options:NSRegularExpressionCaseInsensitive error:&error];
    return [regex stringByReplacingMatchesInString:filename options:0 range:NSMakeRange(0, [filename length]) withTemplate:@""];
}

@end
