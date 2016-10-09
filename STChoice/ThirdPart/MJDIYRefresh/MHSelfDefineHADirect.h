//
//  MHSelfDefineHADirect.h
//  vomoho
//
//  Created by AloesLu on 16/3/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef void(^imageClickBlock)(NSInteger index);

@interface MHSelfDefineHADirect : UIView

//轮播的ScrollView
@property(strong,nonatomic) UIScrollView *direct;
//轮播的页码
@property(strong,nonatomic) UIPageControl *pageVC;
//轮播滚动时间间隔
@property(assign,nonatomic) CGFloat time;


//初始化图片格式的HADirect
+(instancetype)direcWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;

//初始化自定义样式的HADirect
+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr AndClickBlock:(imageClickBlock)clickBlock;

+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr isCor:(BOOL)isCor modelArry:(NSMutableArray *)modelArry AndClickBlock:(imageClickBlock)clickBlock;

+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr modelArry:(NSMutableArray *)modelArry AndClickBlock:(imageClickBlock)clickBlock;

//开始定时器
-(void)beginTimer;

//销毁定时器
-(void)stopTimer;
@end
