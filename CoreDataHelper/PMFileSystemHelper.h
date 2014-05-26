//
//  PMFileSystemHelper.h
//  CoreDataHelper
//
//  Created by Pedro Mancheno on 5/23/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#define APP_DOC_DIR [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_DOC_DIR_URL [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

@interface PMFileSystemHelper : NSObject

+ (NSString *)createDirectoryIfNotExists:(NSString *)folderName;

+ (NSString *)fullFilePathUnderDocumentsForFile:(NSString*)fileName;
+ (NSURL *)fullFileURLUnderDocumentsForFile:(NSString*)fileName;

+ (BOOL)cleanFolderUnderDocuments:(NSString *)folderName;
+ (BOOL)deleteFile:(NSString *)filePath;
+ (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString*)dstPath;

+ (NSString*)cleanFilename:(NSString*)filename;

@end
