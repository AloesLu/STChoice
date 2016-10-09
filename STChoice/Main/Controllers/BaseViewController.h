//
//  BaseViewController.h
//  ReconstructionQQSlide
//
//  Created by LingLi on 15/12/24.
//  Copyright © 2015年 LingLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UITapGestureRecognizer;
@interface BaseViewController : UIViewController

- (void)tabBarItemClicked;
-(void)initBaseNavigation;
- (void)hiddenAvatarImageView;
- (void)showAvatarImageView;
@end
