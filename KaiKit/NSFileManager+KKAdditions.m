//
//  NSFileManager+KKAdditions.m
//
//  Copyright (c) 2018 KidKai
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "NSFileManager+KKAdditions.h"

@implementation NSFileManager (KKAdditions)

+ (NSString *)documentPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)cachesPath
{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    if (![self fileExistsAtPath:path]) {
        return [NSFileManager.defaultManager
                createDirectoryAtPath:path
                withIntermediateDirectories:YES
                attributes:nil
                error:NULL];
    }
    return YES;
}

+ (BOOL)copyItemAtPath:(NSString *)srcPath
                toPath:(NSString *)dstPath
{
    if ([self fileExistsAtPath:dstPath])
        [self removeItemAtPath:dstPath];
    NSError *error = nil;
    BOOL result =
    [NSFileManager.defaultManager
     copyItemAtPath:srcPath toPath:dstPath error:&error];
    if (error) result = NO;
    return result;
}

+ (BOOL)moveItemAtPath:(NSString *)srcPath
                toPath:(NSString *)dstPath
{
    if ([self fileExistsAtPath:dstPath])
        [self removeItemAtPath:dstPath];
    NSError *error = nil;
    BOOL result =
    [NSFileManager.defaultManager
     moveItemAtPath:srcPath toPath:dstPath error:&error];
    if (error) result = NO;
    return result;
}

+ (BOOL)removeItemAtPath:(NSString *)path
{
    NSError *error = nil;
    BOOL result =
    [NSFileManager.defaultManager
     removeItemAtPath:path error:&error];
    if (error) result = NO;
    return result;
}

+ (BOOL)fileExistsAtPath:(NSString *)path
{
    return [NSFileManager.defaultManager fileExistsAtPath:path];
}

+ (BOOL)removeSubfileAtPath:(NSString *)path
{
    NSArray *subpaths = [NSFileManager.defaultManager subpathsAtPath:path];
    for (NSString *subpath in subpaths) {
        NSString *filePath = [path stringByAppendingPathComponent:subpath];
        if ([self fileExistsAtPath:filePath]) {
            if (![self removeItemAtPath:filePath]) return NO;
        }
    }
    return YES;
}

+ (BOOL)createFileAtPath:(NSString *)path
{
    if (![self fileExistsAtPath:path]) {
        return [NSFileManager.defaultManager
                createFileAtPath:path contents:[NSData data] attributes:nil];
    }
    return YES;
}

+ (float)folderSizeAtPath:(NSString *)path
{
    if (![self fileExistsAtPath:path]) return 0.f;
    NSEnumerator *enumerator =
    [NSFileManager.defaultManager
     subpathsAtPath:path].objectEnumerator;
    NSString *filename = nil;
    unsigned long long folderSize = 0;
    while ((filename = enumerator.nextObject) != nil) {
        NSString *filePath = [path stringByAppendingPathComponent:filename];
        folderSize += [self fileSizeAtPath:filePath];
    }
    return (float)folderSize / 1024.f / 1024.f;
}

+ (unsigned long long)fileSizeAtPath:(NSString *)path
{
    if ([self fileExistsAtPath:path]) {
        return [NSFileManager.defaultManager
                attributesOfItemAtPath:path
                error:NULL].fileSize;
    }
    return 0;
}

@end
