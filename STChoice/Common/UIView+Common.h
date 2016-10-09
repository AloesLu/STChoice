//
//  UIView+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>
@class EaseLoadingView, EaseBlankPageView;

typedef NS_ENUM(NSInteger, MHBlankPageType)
{
    MHBlankPageTypeView = 0,
    MHBlankPageTypeHeadline,
    MHBlankPageTypeCircle,
    MHBlankPageTypeActivitySelect,
    MHBlankPageTypeActivityAll,
    MHBlankPageTypeMessageReply,
    MHBlankPageTypeMessagePraise,
    MHBlankPageTypeMessageSystem,
    MHBlankPageTypeDiscoveryWork,
    MHBlankPageTypeDiscoveryHouse,
    MHBlankPageTypeGroup,
    MHBlankPageTypePraise,
    MHBlankPageTypeApply,
    MHBlankPageTypeMyPost,
    MHBlankPageTypeMyCollectionCircle,
    MHBlankPageTypeMyCollectionActivity,
    MHBlankPageTypeMyActivityApply,
    MHBlankPageTypeMyActivitySend,
    MHBlankPageTypeNoMyActivity,
    MHBlankPageTypeNoMyPost,
    MHBlankPageTypeNoMyNews,
    MHBlankPageTypeNoMyTrend,
    MHBlankPageTypeNoMyChat,
    MHBlankPageTypeNoMyBlack,
    MHBlankPageTypeFriendList,
    MHBlankPageTypeNotifyList,
    MHBlankPageTypeFansList,
    MHBlankPageTypeRecommendedFriend
};

typedef NS_ENUM(NSInteger, BadgePositionType) {

    BadgePositionTypeDefault = 0,
    BadgePositionTypeMiddle
};

@interface UIView (Common)

- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (CGFloat)maxXOfFrame;

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

- (void)addRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

- (void)removeViewWithTag:(NSInteger)tag;
- (CGSize)doubleSizeOfFrame;

- (UIViewController*)viewController;

+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;

#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(MHBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

@end

@interface EaseLoadingView : UIView
@property (strong, nonatomic) UIImageView *loopView, *monkeyView,*tigerLodingView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
- (void)configWithType:(MHBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end
