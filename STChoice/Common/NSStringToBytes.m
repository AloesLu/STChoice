//
//  NSStringToBytes.m
//  sh-ios
//
//  Created by lyx on 13-2-18.
//  Copyright (c) 2013年 沙海瑞. All rights reserved.
//

#import "NSStringToBytes.h"

@implementation NSString (NSStringHexToBytes)

-(NSData*) hexToBytes {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

@end
