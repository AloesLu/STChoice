//
//  MHGlobalFunction.h
//  vomoho
//
//  Created by AloesLu on 15/9/23.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UITapImageView,CustomButton;

typedef NS_ENUM(NSInteger, MHInfoType) {
    MHInfoNone = 0,
    MHInfoNew = 1,
    MHInfoPost = 2,
    MHInfoActivity = 3,
    MHInfoAd = 4,
    MHInfoScene = 5,
    MHInfoUserDynamic = 6
};

@interface MHGlobalFunction : NSObject

//导航栏混合按钮
+ (UIButton *)getIconFontBarButtonItem:(NSString *)title rect:(CGRect)rect size:(CGFloat)size;
//内容页icon
+ (void)setIconImageButton:(NSString *)title size:(CGFloat)size btn:(UIButton*)button;
//导航栏图标按钮
+ (UIButton *)getIconNavBarButton:(NSString *)title;
//导航栏文字按钮
+ (UIButton *)getWordNavBarButton:(NSString *)title;
+ (void)setGenderAndAgeLabel:(UILabel*)label gender:(NSNumber *)gender;
+ (void)setOperateButton:(CustomButton *)button title:(NSString *)title state:(int)state;
+ (void)setImageToImageView:(UITapImageView *)imageView url:(NSString *)url;

+ (void)judgeNumTextView:(UITextView *)textView maxLenght:(int)maxLenght showText:(NSString *)showText;
+ (void)judgeNumTextField:(UITextField *)textField maxLenght:(int)maxLenght showText:(NSString *)showText;

+ (NSString *)timeIntervalFromString:(NSString *)str;

+ (void)show4SHUD:(NSString *)text;

+ (void)showHUD:(NSString *)text;
+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud;

+ (NSString *)getNowTip;
@end
