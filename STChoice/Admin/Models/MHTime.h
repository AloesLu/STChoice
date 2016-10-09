//
//  MHTime.h
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHTime : NSObject
@property(nonatomic,strong,readwrite)NSString *timeId;
@property(nonatomic,strong,readwrite)NSNumber *timeType;
@property(nonatomic,strong,readwrite)NSString *startTime;
@property(nonatomic,strong,readwrite)NSString *endTime;
@property(nonatomic,strong,readwrite)NSNumber *timeStatus;

+ (instancetype)timeWithDict:(NSDictionary *)dict;
@end
