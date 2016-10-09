//
//  MHAdminManager.m
//  STChoice
//
//  Created by AloesLu on 16/5/13.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHAdminManager.h"
#import "MHTime.h"
#define kNowTimeSection @"nowTimeSection"

@implementation MHAdminManager
+ (instancetype)sharedManager{
    static MHAdminManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)setKNowTimeSection:(MHTime *)time{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(time==nil){
        [defaults setObject:nil forKey:kNowTimeSection];
        [defaults synchronize];
        return;
    }
    NSDictionary *dict=@{@"startTime":time.startTime,@"endTime":time.endTime,@"timeStatus":time.timeStatus,@"timeType":time.timeType};
    [defaults setObject:dict forKey:kNowTimeSection];
    [defaults synchronize];
}

- (MHTime *)getKNowTimeSection{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict=[defaults objectForKey:kNowTimeSection];
    MHTime *time=[MHTime timeWithDict:dict];
    return time;
}

- (NSNumber *)getTimeType{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict=[defaults objectForKey:kNowTimeSection];
    MHTime *time=[MHTime timeWithDict:dict];
    return time.timeType;
}

@end
