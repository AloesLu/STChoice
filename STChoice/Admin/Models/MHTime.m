//
//  MHTime.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHTime.h"

@implementation MHTime
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.timeId=[dict objectForKey:@"id"];
        self.timeType=[dict objectForKey:@"timeType"];
        self.startTime=[dict objectForKey:@"startTime"];
        self.endTime=[dict objectForKey:@"endTime"];
        self.timeStatus=[dict objectForKey:@"timeStatus"];
    }
    return self;
}
+ (instancetype)timeWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
