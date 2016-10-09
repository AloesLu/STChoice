//
//  AES256Encryp.h
//  sh-ios
//
//  Created by lyx on 13-2-18.
//  Copyright (c) 2013年 沙海瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "NSStringToBytes.h"

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES256EncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;   //解密
- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString *)base64encode:(NSString*)str;           //同上64编码
+ (NSData *)dataWithBase64EncodedString:(NSString *)string; //64解码
- (NSString *)AES256EncryptReturnNSString:(NSString *)key resource:(NSData *)plain;   //加密返回NSString字符串
+(NSString *)decryptResult:(NSString *)responseString decKey:(NSString *)key;//对云端返回结果进行AES解密
@end
