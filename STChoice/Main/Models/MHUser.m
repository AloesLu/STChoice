//
//  MHUser.m
//  vomoho
//
//  Created by AloesLu on 15/9/26.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import "MHUser.h"

@implementation MHUser

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
//        [self setValuesForKeysWithDictionary:dict];
        self.uid=[dict objectForKey:@"uid"];
        self.openAccountId=[dict objectForKey:@"openAccountId"];
        self.username=[dict objectForKey:@"username"];
        self.nick=[dict objectForKey:@"nick"];
        self.avatar=[dict objectForKey:@"avatar"];
        self.gender=[dict objectForKey:@"gender"];
        self.age=[dict objectForKey:@"age"];
        self.motto=[dict objectForKey:@"motto"];
        self.phone=[dict objectForKey:@"phone"];
        self.backgroundPicture=[dict objectForKey:@"backgroundPicture"];
        self.constellation=[dict objectForKey:@"constellation"];
        self.registerTime=[dict objectForKey:@"registerTime"];
        self.marriageStat=[dict objectForKey:@"marriageStat"];
        self.picList=[dict objectForKey:@"picList"];
        self.position=[dict objectForKey:@"position"];
        self.positionNo=[dict objectForKey:@"positionNo"];
        self.relation=[dict objectForKey:@"relation"];
        self.birthday=[dict objectForKey:@"formatBirthday"];
        self.tagMap=[dict objectForKey:@"tagList"];
        self.dynamicPictures=[dict objectForKey:@"dynamicPictures"];
        self.relationStat=[dict objectForKey:@"relationStat"];
        self.lastLoginTime=[dict objectForKey:@"lastLoginTime"];
        
        self.hobby=[dict objectForKey:@"hobby"];
        self.registerCity=[dict objectForKey:@"registerCity"];
        self.token=[dict objectForKey:@"token"];
        
        self.lastActiveTime=[dict objectForKey:@"lastActiveTime"];
        self.showTime=[dict objectForKey:@"showTime"];
    }
    return self;
}
+ (instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end