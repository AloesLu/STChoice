//
//  BaseViewController.m
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()
@property(nonatomic,strong)UITapImageView *avatarImage;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=kBGColor;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
}

- (void)tabBarItemClicked{
    DebugLog(@"\ntabBarItemClicked : %@", NSStringFromClass([self class]));
}

/*
 * 方法说明：功能说明（登陆或者进入个人中心）
 * 修改记录：（）
 */
//
//- (void)loginOrMineinfo{
//    if(![[MHUserManager sharedManager] isMHUserLogin]){
//        [appMHDelegate loginAccount:self.navigationController];
//    }else{
//        [self home];
//    }
//}
@end
