//
//  BaseNavigationController.m
//  Coding_iOS
//
//  Created by Ease on 15/2/5.
//  Copyright (c) 2015年 Coding. All rights reserved.
//
/*
 
 * 姓名：陆伟
 
 * 创建时间：2015/09/14
 
 * 类说明：总体说明（重写系统导航栏）
 
 * 修改记录：（）
 
 */
#import "MHBaseNavigationController.h"
//#import "UIImage+Extension.h"

@implementation MHBaseNavigationController

+(void)initialize{
    UINavigationBar *navBar=[UINavigationBar appearance];
    //设置系统导航栏自带按钮文字颜色
    [navBar setTintColor:kTitleColor];
    //设置导航栏title字体颜色
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = [UIFont boldSystemFontOfSize:kNavTitleFontSize];
    md[NSForegroundColorAttributeName] = kTitleColor;
    [navBar setTitleTextAttributes:md];
    //设置导航栏颜色
    [navBar setBarTintColor:kMainColor];
    
//    UIImage *backgroundImage = [UIImage imageWithColor:kMainColor];
//    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//    [navBar setTranslucent:YES];
    
    //返回指示器图片
    navBar.backIndicatorImage=[UIImage imageNamed:@"backImageBlack"];
    navBar.backIndicatorTransitionMaskImage=[UIImage imageNamed:@"backImageBlack"];
    
    //设置返回按钮字体大小
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:kBackButtonFontSize]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
}
- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return [self.visibleViewController supportedInterfaceOrientations];
//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([NSStringFromClass([viewController class]) rangeOfString:@"MHAdminManagerTimeViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"MHSelectResultViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STTeacherChooseViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STTeacherSureViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STTeacherInfoViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STStudentChooseViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STStudentSureViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"STStudentInfoViewController"].location != NSNotFound||[NSStringFromClass([viewController class]) rangeOfString:@"MHFenPeiViewController"].location != NSNotFound){
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
