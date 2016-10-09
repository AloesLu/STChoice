//
//  MHChoose.m
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHChoose.h"

@implementation MHChoose
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.chooseId=[dict objectForKey:@"id"];
        self.stuId=[dict objectForKey:@"stuId"];
        self.teaId=[dict objectForKey:@"teaId"];
        self.wishNum=[dict objectForKey:@"wishNum"];
        self.stuStatus=[dict objectForKey:@"stuStatus"];
        self.teaStatus=[dict objectForKey:@"teaStatus"];
        
        self.stuName=[dict objectForKey:@"stuName"];
//        self.teaName=[dict objectForKey:@"teaName"];
//        self.stuContact=[dict objectForKey:@"stuContact"];
//        self.teaContact=[dict objectForKey:@"teaContact"];
//        
        self.avatar=[dict objectForKey:@"avatar"];
        self.email=[dict objectForKey:@"email"];
        
        self.major=[dict objectForKey:@"major"];
        
        self.teacher=[MHTeacher teacherWithDict:[dict objectForKey:@"teacher"]];
        self.student=[MHStudent studentWithDict:[dict objectForKey:@"student"]];
    }
    return self;
}
+ (instancetype)chooseWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
