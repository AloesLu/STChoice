//
//  MHAdminManager.h
//  STChoice
//
//  Created by AloesLu on 16/5/13.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MHTime;
@interface MHAdminManager : NSObject

+ (instancetype)sharedManager;

- (void)setKNowTimeSection:(MHTime *)time;

- (MHTime *)getKNowTimeSection;
- (NSNumber *)getTimeType;
@end
