//
//  MHWish.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHWish.h"

@implementation MHWish
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.wishId=[dict objectForKey:@"wishId"];
        self.teaId=[dict objectForKey:@"teaId"];
        self.stuId=[dict objectForKey:@"stuId"];
        self.wishNum=[dict objectForKey:@"wishNum"];
        self.content=[dict objectForKey:@"content"];
        
        self.stuName=[dict objectForKey:@"stuName"];
        self.teaName=[dict objectForKey:@"teaName"];
        self.stuContact=[dict objectForKey:@"stuContact"];
        self.teaContact=[dict objectForKey:@"teaContact"];
        
        self.teaTitle=[dict objectForKey:@"teaTitle"];
        
        self.teacher=[MHTeacher teacherWithDict:[dict objectForKey:@"teacher"]];
        self.student=[MHStudent studentWithDict:[dict objectForKey:@"student"]];
    }
    return self;
}
+ (instancetype)wishWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
