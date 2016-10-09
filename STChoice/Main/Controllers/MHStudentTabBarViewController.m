//
//  MHStudentTabBarViewController.m
//  STChoice
//
//  Created by AloesLu on 16/4/28.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHStudentTabBarViewController.h"
#import "BaseViewController.h"
#import "MHBaseNavigationController.h"
#import "STStudentInfoViewController.h"
#import "STStudentSureViewController.h"
#import "STStudentChooseViewController.h"

@interface MHStudentTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MHStudentTabBarViewController


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
    
    STStudentChooseViewController *scVC=[[STStudentChooseViewController alloc]init];
    MHBaseNavigationController *nav_scVC=[[MHBaseNavigationController alloc]initWithRootViewController:scVC];
    UITabBarItem *item1 = [self _makeItemWithTitle:@"志愿选择" normalName:@"01" selectedName:@"001" tag:100];
    [nav_scVC setTabBarItem:item1];
    [aryControllers addObject:nav_scVC];
    
    STStudentSureViewController *ssVC=[[STStudentSureViewController alloc]init];
    MHBaseNavigationController *nav_ssVC=[[MHBaseNavigationController alloc]initWithRootViewController:ssVC];
    UITabBarItem *item2 = [self _makeItemWithTitle:@"确认关系" normalName:@"02" selectedName:@"002" tag:101];
    [nav_ssVC setTabBarItem:item2];
    [aryControllers addObject:nav_ssVC];
    
    STStudentInfoViewController *siVC=[[STStudentInfoViewController alloc]init];
    MHBaseNavigationController *nav_siVC=[[MHBaseNavigationController alloc]initWithRootViewController:siVC];
    UITabBarItem *item3 = [self _makeItemWithTitle:@"我" normalName:@"03" selectedName:@"003" tag:102];
    [nav_siVC setTabBarItem:item3];
    [aryControllers addObject:nav_siVC];
    
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
