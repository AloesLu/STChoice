//
//  MHStudent.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHStudent.h"

@implementation MHStudent
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.stuId=[dict objectForKey:@"id"];
        self.stuName=[dict objectForKey:@"name"];
        self.sex=[dict objectForKey:@"sex"];
        self.avatar=[dict objectForKey:@"avatar"];
        self.clazz=[dict objectForKey:@"clazz"];
        self.major=[dict objectForKey:@"major"];

        self.contact=[dict objectForKey:@"contact"];
        self.email=[dict objectForKey:@"email"];
        self.rank=[dict objectForKey:@"rank"];
        
        self.honour=[dict objectForKey:@"honour"];
        self.interst = [dict objectForKey:@"interst"];
        self.works = [dict objectForKey:@"works"];
        self.experience = [dict objectForKey:@"experience"];
        
        self.QQ=[dict objectForKey:@"QQ"];
        self.remarks=[dict objectForKey:@"remarks"];
        self.grade=[dict objectForKey:@"grade"];
    }
    return self;
}
+ (instancetype)studentWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
