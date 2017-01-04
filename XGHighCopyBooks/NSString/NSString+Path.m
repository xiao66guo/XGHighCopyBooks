//
//  NSString+Path.m
//  沙盒
//
//  Created by 小果 on 14-7-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

+ (NSString *)documentPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)cachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)tempPath
{
    return NSTemporaryDirectory();
}

- (NSString *)appendDocumentPath
{
    return [[NSString documentPath] stringByAppendingPathComponent:self];
}

- (NSString *)appendCachePath
{
    return [[NSString cachePath] stringByAppendingPathComponent:self];
}

- (NSString *)appendTempPath
{
    return [[NSString tempPath] stringByAppendingPathComponent:self];
}

@end
