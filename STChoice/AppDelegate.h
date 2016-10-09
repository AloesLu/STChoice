//
//  AppDelegate.h
//  STChoice
//
//  Created by AloesLu on 16/4/11.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)loginApp:(int)type;
- (void)logoutApp:(int)type;
@end

