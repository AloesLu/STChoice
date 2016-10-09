//
//  MHTag.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHTag : NSObject
@property(nonatomic,strong,readwrite)NSString *tagId;
@property(nonatomic,strong,readwrite)NSString *teaId;
@property(nonatomic,strong,readwrite)NSString *stuId;
@property(nonatomic,strong,readwrite)NSString *tagName;

+ (instancetype)tagWithDict:(NSDictionary *)dict;
@end
