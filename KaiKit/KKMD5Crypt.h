//
//  KKMD5Crypt.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MD5)

@property (nonatomic, readonly) NSData *md5;

@property (nullable, nonatomic, readonly) NSString *md5L; // lowercase
@property (nullable, nonatomic, readonly) NSString *md5U; // uppercase

@end

@interface NSString (MD5)

@property (nullable, nonatomic, readonly) NSString *md5L; // lowercase
@property (nullable, nonatomic, readonly) NSString *md5U; // uppercase

@end

//
//  Created by Kelp on 12/5/12.
//  Updated by KidKai on 18/5/18.
//  Copyright (c) 2012 Kelp http://kelp.phate.org/
//

@interface NSData (HEX)

- (nullable NSString *)hexUsingLower:(BOOL)isOutputLower;

@end

NS_ASSUME_NONNULL_END