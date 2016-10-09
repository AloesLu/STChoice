//
//  MJDIYHeadlineHeader.m
//  vomoho
//
//  Created by AloesLu on 16/2/16.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MJDIYHeadlineHeader.h"
#import "MJRefreshConst.h"

@interface MJDIYHeadlineHeader()
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UISwitch *s;
@property (weak, nonatomic) UIImageView *logo;
@property (weak, nonatomic) UIActivityIndicatorView *loading;
@end

@implementation MJDIYHeadlineHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 70;
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kWeakTextColor;
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // logo
    UIImageView *logo = [[UIImageView alloc] init];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:logo];
    self.logo = logo;
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    //    self.label.frame = self.bounds;
    self.label.frame = CGRectMake(0,50, self.bounds.size.width, 20);
    self.logo.bounds = CGRectMake(0,40, self.bounds.size.width, 40);
    self.logo.center = CGPointMake(self.mj_w * 0.5+5.5, - self.logo.mj_h + 70);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.logo.animationImages=@[[UIImage imageNamed:@"下拉1"]];
            self.logo.animationDuration = 0.25f;
            self.logo.animationRepeatCount = 0;
            [self.logo startAnimating];
            self.label.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.logo.animationImages=@[[UIImage imageNamed:@"下拉2"]];
            self.logo.animationDuration = 0.25f;
            self.logo.animationRepeatCount = 0;
            [self.logo startAnimating];
            self.label.text = @"松开刷新";
            break;
        case MJRefreshStateRefreshing:
            self.logo.animationImages=@[[UIImage imageNamed:@"下拉3"],[UIImage imageNamed:@"下拉4"],[UIImage imageNamed:@"下拉5"],[UIImage imageNamed:@"下拉6"]];
            self.logo.animationDuration = 0.25f;
            self.logo.animationRepeatCount = 0;
            [self.logo startAnimating];
            self.label.text = @"正在刷新";
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if(pullingPercent>0.1){
        self.label.hidden=NO;
        self.logo.hidden=NO;
    }else{
        self.label.hidden=YES;
        self.logo.hidden=YES;
    }
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    //    CGFloat red = 1.0 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    CGFloat red = 0.7 - pullingPercent * 0.5;
    //    CGFloat green = 0.5 - 0.5 * pullingPercent;
    //    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
