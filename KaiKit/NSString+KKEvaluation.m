//
//  NSString+KKEvaluation.m
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

#import "NSString+KKEvaluation.h"

static BOOL matches(NSString *regex, NSString *value)
{
    // https://jex.im/regulex/#!flags=&re=%5E(a%7Cb)*%3F%24
    id predicate = [NSPredicate predicateWithFormat:@"self matches %@", regex];
    return [predicate evaluateWithObject:value];
}

@implementation NSString (KKEvaluation)

- (BOOL)isAnURL
{
    NSString *regex = @"^(?:(?:https?|ftp):\\/\\/)(?:\\S+(?::\\S*)?@)?(?:(?!(?:10|127)(?:\\.\\d{1,3}){3})(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,}))\\.?)(?::\\d{2,5})?(?:[/?#]\\S*)?$";
    return matches(regex, self);
}

- (BOOL)isEmpty
{
    if (!self.length || [self isEqual:[NSNull null]]) return YES;
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if (![[self stringByTrimmingCharactersInSet:set] length]) return YES;
    
    return NO;
}

- (BOOL)isInURL
{
    NSString *regex = @"^(?:(?:https?|ftp):\\/\\/)(?:\\S+(?::\\S*)?@)?(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,}))\\.?)(?::\\d{2,5})?(?:[/?#]\\S*)?$";
    return matches(regex, self);
}

- (BOOL)isUndefined
{
    if (self.isEmpty) return YES;
    
    if ([self isEqualToString:@"undefined"]) return YES;
    
    return NO;
}

- (BOOL)isChinaPhone
{
    NSString *regex = @"((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(14[57]))\\d{8}";
    return matches(regex, self);
}

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return matches(regex, self);
}

- (BOOL)isValidIDNUM
{
    NSString *regex = @"([1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3})|([1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X))";
    return matches(regex, self);
}

- (BOOL)isAllNumbers
{
    NSString *regex = @"[0-9]{1,}";
    return matches(regex, self);
}

- (BOOL)isHasNumbers
{
    NSString *regex = @".*?\\d+.*?";
    return matches(regex, self);
}

- (BOOL)isHasULetter
{
    NSString *regex = @".*?[A-Z]+.*?";
    return matches(regex, self);
}

- (BOOL)isHasLLetter
{
    NSString *regex = @".*?[a-z]+.*?";
    return matches(regex, self);
}

- (BOOL)isHasSpecial
{
    NSString *regex = @".*?[^A-Za-z0-9]+.*?";
    return matches(regex, self);
}

- (BOOL)isHasChinese
{
    NSString *regex = @".*?[\\u4e00-\\u9fa5]+.*?";
    return matches(regex, self);
}

@end
