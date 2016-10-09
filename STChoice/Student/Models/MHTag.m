//
//  MHTag.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHTag.h"

@implementation MHTag
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.tagId=[dict objectForKey:@"tagId"];
        self.teaId=[dict objectForKey:@"teaId"];
        self.stuId=[dict objectForKey:@"stuId"];
        self.tagName=[dict objectForKey:@"tagName"];
    }
    return self;
}
+ (instancetype)tagWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
