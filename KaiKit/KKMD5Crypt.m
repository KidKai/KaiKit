//
//  KKMD5Crypt.m
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

#import "KKMD5Crypt.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

- (NSData *)md5
{
    unsigned char *digest = malloc(CC_MD5_DIGEST_LENGTH);
    
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    NSData *result = [[NSData alloc] initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    free(digest);
    
    return result;
}

- (NSString *)md5L
{
    return [self.md5 hexUsingLower:YES];
}

- (NSString *)md5U
{
    return [self.md5 hexUsingLower:NO];
}

@end

@implementation NSString (MD5)

- (NSString *)md5L
{
    return [self dataUsingEncoding:NSUTF8StringEncoding].md5L;
}

- (NSString *)md5U
{
    return [self dataUsingEncoding:NSUTF8StringEncoding].md5U;
}

@end

//
//  Created by Kelp on 12/5/12.
//  Updated by KidKai on 18/5/18.
//  Copyright (c) 2012 Kelp http://kelp.phate.org/
//

@implementation NSData (HEX)

- (NSString *)hexUsingLower:(BOOL)isOutputLower
{
    if (!self.length) return nil;
    
    static const char hexEncodeCharsLower[] = "0123456789abcdef";
    static const char hexEncodeChars[] = "0123456789ABCDEF";
    
    // Malloc result data.
    char *resultData = malloc(self.length * 2 + 1);
    // Convert data to char[].
    unsigned char *sourceData = ((unsigned char *)self.bytes);
    
    if (isOutputLower) {
        for (NSUInteger index = 0; index < self.length; index++) {
            resultData[index * 2] = hexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = hexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    } else {
        for (NSUInteger index = 0; index < self.length; index++) {
            resultData[index * 2] = hexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = hexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[self.length * 2] = 0;
    
    // Convert result(char[]) to string.
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}

@end
