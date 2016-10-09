//
//  MHAdminTabBarViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/26.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHAdminTabBarViewController.h"
#import "BaseViewController.h"
#import "MHBaseNavigationController.h"
#import "MHAdminManagerTimeViewController.h"
#import "MHSelectResultViewController.h"
#import "MHFenPeiViewController.h"

#define kTabbarItemCount 5
@interface MHAdminTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MHAdminTabBarViewController

#pragma mark - private

- (UITabBarItem *)_makeItemWithTitle:(NSString *)aTitle normalName:(NSString *)aNormal selectedName:(NSString *)aSelected tag:(NSInteger)aTag
{
    UITabBarItem *result = nil;
    
    UIImage *nor = [UIImage imageNamed:aNormal];
    UIImage *sel = [UIImage imageNamed:aSelected];
    //    nor=[nor imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sel=[sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.f) {
        result = [[UITabBarItem alloc] initWithTitle:aTitle image:nor selectedImage:sel];
        [result setTag:aTag];
    } else {
        result = [[UITabBarItem alloc] initWithTitle:aTitle image:nor tag:aTag];
    }
    //    [result setTitleTextAttributes:@{NSForegroundColorAttributeName:kDescribeColor} forState:UIControlStateNormal];
    [result setTitleTextAttributes:@{NSForegroundColorAttributeName:kMainColorIcon} forState:UIControlStateHighlighted];
    return result;
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *aryControllers = [NSMutableArray array];
    
    MHAdminManagerTimeViewController *adtVC=[[MHAdminManagerTimeViewController alloc]init];
    MHBaseNavigationController *nav_adtVC=[[MHBaseNavigationController alloc]initWithRootViewController:adtVC];
    UITabBarItem *item1 = [self _makeItemWithTitle:@"时间控制" normalName:@"01" selectedName:@"001" tag:100];
    [nav_adtVC setTabBarItem:item1];
    [aryControllers addObject:nav_adtVC];
    
    MHFenPeiViewController *fpVC=[[MHFenPeiViewController alloc]init];
    MHBaseNavigationController *nav_fpVC=[[MHBaseNavigationController alloc]initWithRootViewController:fpVC];
    UITabBarItem *item2 = [self _makeItemWithTitle:@"随机分配" normalName:@"02" selectedName:@"002" tag:101];
    [nav_fpVC setTabBarItem:item2];
    [aryControllers addObject:nav_fpVC];
    
    MHSelectResultViewController *srVC=[[MHSelectResultViewController alloc]init];
    MHBaseNavigationController *nav_srVC=[[MHBaseNavigationController alloc]initWithRootViewController:srVC];
    UITabBarItem *item3 = [self _makeItemWithTitle:@"结果查看" normalName:@"04" selectedName:@"004" tag:101];
    [nav_srVC setTabBarItem:item3];
    [aryControllers addObject:nav_srVC];
    
    self.viewControllers = aryControllers;
    self.delegate=self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if(item.tag==100){
        
    }else if(item.tag==101){
        
    }else if(item.tag==102){
        
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if([viewController isEqual:[tabBarController.viewControllers objectAtIndex:3]]){
//        if(![[MHUserManager sharedManager] isMHUserLogin]){
//            //            [appMHDelegate loginAccount:[tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex]];
//            return NO;
//        }
//    }
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    if ([nav.topViewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
        [rootVC tabBarItemClicked];
    }
    return YES;
}

@end
