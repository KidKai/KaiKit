//
//  NSString+KKTransform.h
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

@interface NSString (KKTransform)

@property (nonatomic, readonly) NSString *combine;
@property (nonatomic, readonly) NSString *urlEncoded;

// NSString *str1 = @"0123456789🔟十二,\"Hello World\"";
// NSString *str2 = [str1 substringFromIndex:9 toIndex:8];
// NSString *str3 = [str1 substringFromIndex:9 toIndex:9];
// NSString *str4 = [str1 substringFromIndex:9 toIndex:18];
// NSString *str5 = [str1 substringFromIndex:19 toIndex:28];
// NSString *str6 = [str1 substringFromIndex:19 toIndex:38];
// NSLog(@"%@\n%@\n%@\n%@\n%@\n%@", str1,str2,str3,str4,str5,str6);
//
// All Output:
// 0123456789🔟十二,"Hello World"
// (null)
// 9
// 9🔟十二,"He
// lo World"
// lo World"
- (nullable NSString *)substringFromIndex:(NSUInteger)from
                                  toIndex:(NSUInteger)to
NS_SWIFT_UNAVAILABLE("Please use String slicing subscript.");

@end

NS_ASSUME_NONNULL_END
