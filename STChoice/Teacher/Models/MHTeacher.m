//
//  MHTeacher.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHTeacher.h"

@implementation MHTeacher
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.teaId=[dict objectForKey:@"id"];
        self.teaName=[dict objectForKey:@"name"];
        self.sex=[dict objectForKey:@"sex"];
        self.avatar=[dict objectForKey:@"avatar"];
        self.teaTitle=[dict objectForKey:@"teaTitle"];
        self.direction=[dict objectForKey:@"direction"];
        self.contact=[dict objectForKey:@"contact"];
        self.email=[dict objectForKey:@"email"];
        self.teaPaper=[dict objectForKey:@"teaPaper"];
        self.teaProject=[dict objectForKey:@"teaProject"];
        self.honour=[dict objectForKey:@"honour"];
        self.stuRequire = [dict objectForKey:@"stuRequire"];
        
        self.QQ=[dict objectForKey:@"QQ"];
        self.remarks=[dict objectForKey:@"remarks"];
        self.school=[dict objectForKey:@"school"];
        self.selectNum=[dict objectForKey:@"selectNum"];
    }
    return self;
}
+ (instancetype)teacherWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
