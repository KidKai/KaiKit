//
//  KKAESCrypt.m
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

#import "KKAESCrypt.h"
#import "Base64.h"

#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES)

- (NSData *)aes128WithKey:(NSString *)keyString
                operation:(CCOperation)operation
{
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr));   // fill with zeros (for padding)
    
    // fetch key data
    [keyString getCString:keyPtr
                maxLength:sizeof(keyPtr)
                 encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    /*
     for block ciphers, the output size will always be less than
     or equal to the input size plus the size of the block
     */
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus status = CCCrypt(operation,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding|kCCOptionECBMode,
                                     keyPtr,
                                     kCCKeySizeAES128,
                                     NULL,
                                     [self bytes], dataLength, // input
                                     buffer, bufferSize, // output
                                     &numBytesEncrypted);
    
    if (status == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)enaes128WithKey:(NSString *)key
{
    return [self aes128WithKey:key operation:kCCEncrypt];
}

- (NSData *)deaes128WithKey:(NSString *)key
{
    return [self aes128WithKey:key operation:kCCDecrypt];
}

@end

@implementation NSString (AES)

- (NSString *)base64Enaes128WithKey:(NSString *)key
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[data enaes128WithKey:key] base64EncodedString];
}

- (NSString *)base64Deaes128WithKey:(NSString *)key
{
    NSData *data = [[self base64DecodedData] deaes128WithKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
