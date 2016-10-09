//
//  MJDIYFooter.m
//  vomoho
//
//  Created by AloesLu on 16/3/7.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MJDIYFooter.h"

@interface MJDIYFooter(){
    /** 显示刷新状态的label */
    __weak UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;

@end

@implementation MJDIYFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(MJRefreshState)state {
    return self.stateTitles[@(state)];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:@"\U0000e6f5  上拉进入现场" forState:MJRefreshStateIdle];
    [self setTitle:@"\U0000e606  释放进入现场" forState:MJRefreshStatePulling];
    [self setTitle:nil forState:MJRefreshStateRefreshing];
    [self setTitle:nil forState:MJRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
    self.stateLabel.font=[UIFont fontWithName:@"iconfont" size:14];
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    if(state==MJRefreshStateIdle){
        self.stateLabel.hidden=YES;
    }else{
        self.stateLabel.hidden=NO;
    }
}
#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    if(pullingPercent>0.01){
        self.stateLabel.hidden=NO;
    }else{
        self.stateLabel.hidden=YES;
    }
}
@end
