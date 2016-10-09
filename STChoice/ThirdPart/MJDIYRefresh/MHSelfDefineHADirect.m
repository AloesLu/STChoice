//
//  MHSelfDefineHADirect.m
//  vomoho
//
//  Created by AloesLu on 16/3/3.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHSelfDefineHADirect.h"
#import "MHPost.h"
#import "MHDayTask.h"

@interface MHSelfDefineHADirect()<UIScrollViewDelegate>{
//    CGFloat _viewWidth;
}
//轮播图片名字的数组
@property(strong,nonatomic) NSArray *imageArr;
//自定义视图的数组
@property(strong,nonatomic) NSArray *viewArr;
//定时器
@property(strong,nonatomic) NSTimer *timer;
//点击图片出发Block
@property(assign,nonatomic) imageClickBlock clickBlock;


@property(assign,nonatomic) BOOL isCor;
@property(strong,nonatomic) NSMutableArray *modelArry;
@end

@implementation MHSelfDefineHADirect
//获取ScrollView的X值偏移量
#define contentOffSet_x self.direct.contentOffset.x
//获取ScrollView的宽度
#define frame_width self.direct.frame.size.width
//获取ScrollView的contentSize宽度
#define contentSize_x self.direct.contentSize.width

#pragma mark -========================初始化==============================
#pragma mark 静态初始化方法
+(instancetype)direcWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;
{
    return [[MHSelfDefineHADirect alloc]initWithtFrame:frame ImageArr:imageNameArray AndImageClickBlock:clickBlock];
}

#pragma mark 静态初始化自定义视图方法
+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr AndClickBlock:(imageClickBlock)clickBlock
{
    return [[MHSelfDefineHADirect alloc]initWithtFrame:frame ViewArr:customViewArr AndImageClickBlock:clickBlock];
}

+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr isCor:(BOOL)isCor modelArry:(NSMutableArray *)modelArry AndClickBlock:(imageClickBlock)clickBlock
{
    return [[MHSelfDefineHADirect alloc]initWithtFrame:frame ViewArr:customViewArr isCor:(BOOL)isCor modelArry:modelArry AndImageClickBlock:clickBlock];
}

+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr modelArry:(NSMutableArray *)modelArry AndClickBlock:(imageClickBlock)clickBlock{
    return [[MHSelfDefineHADirect alloc]initWithtFrame:frame ViewArr:customViewArr isCor:NO modelArry:modelArry AndImageClickBlock:clickBlock];
}

#pragma mark 初始化自定义视图方法
-(instancetype)initWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr AndImageClickBlock:(imageClickBlock)clickBlock
{
//    _viewWidth=frame.size.width;
    _isCor=NO;
    if(self=[self initWithFrame:frame])
    {
        //设置ScrollView的contentSize
        self.direct.contentSize=CGSizeMake((customViewArr.count+4)*frame_width,0);
        
        self.pageVC.numberOfPages=customViewArr.count;
        
        self.viewArr=customViewArr;
        
        //设置图片点击的Block
        self.clickBlock=clickBlock;
    }
    return self;
}
-(instancetype)initWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr isCor:(BOOL)isCor modelArry:(NSMutableArray *)modelArry AndImageClickBlock:(imageClickBlock)clickBlock
{
    //    _viewWidth=frame.size.width;
    _isCor=isCor;
    _modelArry=modelArry;
    if(self=[self initWithFrame:frame])
    {
        //设置ScrollView的contentSize
        self.direct.contentSize=CGSizeMake((customViewArr.count+4)*frame_width,0);
        
        self.pageVC.numberOfPages=customViewArr.count;
        
        self.viewArr=customViewArr;
        
        //设置图片点击的Block
        self.clickBlock=clickBlock;
    }
    return self;
}
#pragma mark 默认初始化方法
-(instancetype)initWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;
{
    _isCor=NO;
    if(self=[self initWithFrame:frame])
    {
        //设置ScrollView的contentSize
        self.direct.contentSize=CGSizeMake((imageNameArray.count+4)*frame_width,0);
        
        self.pageVC.numberOfPages=imageNameArray.count;
        
        //设置滚动图片数组
        self.imageArr=imageNameArray;
        
        //设置图片点击的Block
        self.clickBlock=clickBlock;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        //初始化轮播ScrollView
        self.direct=[[UIScrollView alloc]init];
        self.direct.delegate=self;
        self.direct.pagingEnabled=YES;
        self.direct.frame=self.bounds;
        self.direct.clipsToBounds=NO;
        self.direct.contentOffset=CGPointMake(frame_width*2, 0);
        self.direct.showsHorizontalScrollIndicator=NO;
        [self addSubview:self.direct];
        
        //初始化轮播页码控件
        self.pageVC=[[UIPageControl alloc]init];
        //设置轮播页码的位置
        self.pageVC.frame=CGRectMake(0,kScreen_Width-20, kScreen_Width, 20);
        self.pageVC.pageIndicatorTintColor=[UIColor colorWithWhite:1.0 alpha:0.5];
        self.pageVC.currentPageIndicatorTintColor=kMainColor;
        [self addSubview:self.pageVC];
        
        self.time=1.5;
    }
    return self;
}

#pragma mark-===========================定时器===============================
#pragma mark 初始化定时器
-(void)beginTimer
{
    //    if(self.timer==nil)
    //    {
    //        self.timer =[NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(timerSel) userInfo:nil repeats:YES];
    //    }
}
#pragma mark 摧毁定时器
-(void)stopTimer
{
    //    [self.timer invalidate];
    //    self.timer=nil;
}

#pragma mark 定时器调用的方法
-(void)timerSel
{
    //获取并且计算当前页码
    CGPoint currentConOffSet=self.direct.contentOffset;
    currentConOffSet.x+=frame_width;
    
    //动画改变当前页码
    [UIView animateWithDuration:0.5 animations:^{
        self.direct.contentOffset=currentConOffSet;
    }completion:^(BOOL finished) {
        [self updataWhenFirstOrLast];
    }];
}

#pragma mark-========================UIScrollViewDelegate=====================
#pragma mark 开始拖拽代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

#pragma mark 结束拖拽代理
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTimer];
}

#pragma mark 结束滚动代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当最后或者最前一张图片时改变坐标
    [self updataWhenFirstOrLast];
}

#pragma mark-=====================轮播页码改变=====================
#pragma mark 更新PageControl
-(void)updataPageControl
{
    NSInteger index=(contentOffSet_x-frame_width*2)/frame_width;
    self.pageVC.currentPage=index;
}

#pragma mark -=====================其他一些方法===================
#pragma mark轮播定时器时间
-(void)setTime:(CGFloat)time
{
    if(time>0)
    {
        _time=time;
        [self stopTimer];
        [self beginTimer];
    }
}

#pragma mark 重写自定义视图的数组
-(void)setViewArr:(NSArray *)viewArr
{
    _viewArr=viewArr;
    
    [self addCustomViewToScrollView];
    
    [self beginTimer];
}

#pragma mark 图片点击事件
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    if(self.clickBlock)
    {
        self.clickBlock(view.tag);
    }
}

#pragma mark 根据自定义视图添加到ScrollView
-(void)addCustomViewToScrollView
{
    //初始化一个可变数组
    NSMutableArray *imgMArr=[NSMutableArray arrayWithArray:self.viewArr];
    
    //序列化后反序列化View，生成一个新的对象
    UIView *lastView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr lastObject]]];
    
    //将无法序列化和反序列化的Image进行递归，并且赋值到新VIEW上
    //    [self imageCopy:[self.viewArr lastObject] To:lastView];
    
    //添加新对象到可变数组
    [imgMArr insertObject:lastView atIndex:0];
    
    if(self.viewArr.count==1){
        UIView *lastlastView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr lastObject]]];
        [imgMArr insertObject:lastlastView atIndex:0];
    }else if(self.viewArr.count>1){
        UIView *lastlastView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr objectAtIndex:self.viewArr.count-2]]];
        [imgMArr insertObject:lastlastView atIndex:0];
    }
    
    //序列化后反序列化View，生成一个新的对象
    UIView *firstView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr firstObject]]];
    
    //将无法序列化和反序列化的Image进行递归，并且赋值到新VIEW上
    //    [self imageCopy:[self.viewArr firstObject] To:firstView];
    
    //添加新对象到可变数组
    [imgMArr addObject:firstView];
    
    if(self.viewArr.count==1){
        UIView *firstfirstView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr firstObject]]];
        [imgMArr addObject:firstfirstView];
    }else if(self.viewArr.count>1){
        UIView *firstfirstView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr objectAtIndex:1]]];
        [imgMArr addObject:firstfirstView];
    }
    
    NSInteger tag=-1;
    for (UIView *customView in imgMArr) {
        customView.frame=CGRectMake(frame_width*(tag+1), 0, frame_width, self.frame.size.height);
        if(_isCor){
            UIImageView *view1=[customView viewWithTag:200];
            UIImageView *view2=[customView viewWithTag:300];
            view1.layer.cornerRadius=5;
            view2.layer.cornerRadius=5;
            view1.layer.masksToBounds=YES;
            view2.layer.masksToBounds=YES;
            if(tag==-1){
                [self setSDTaskImage:customView index:imgMArr.count-6];
            }else if(tag==0){
                [self setSDTaskImage:customView index:imgMArr.count-5];
            }else if(tag==imgMArr.count-3){
                [self setSDTaskImage:customView index:0];
            }else if(tag==imgMArr.count-2){
                [self setSDTaskImage:customView index:1];
            }
        }else{
            if(tag==-1){
                [self setSDImage:customView index:imgMArr.count-6];
            }else if(tag==0){
                [self setSDImage:customView index:imgMArr.count-5];
            }else if(tag==imgMArr.count-3){
                [self setSDImage:customView index:0];
            }else if(tag==imgMArr.count-2){
                [self setSDImage:customView index:1];
            }
        }
        
        //设置tag
        customView.tag=tag;
        tag++;
        //添加手势
//        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
//        [customView addGestureRecognizer:tap];
        
        //开启用户交互
//        customView.userInteractionEnabled=YES;
        [self.direct addSubview:customView];
    }
}

- (void)setSDImage:(UIView *)view index:(NSInteger)index{
    if(_modelArry&&self.modelArry.count>0){
        UITapImageView *imageView1=[view viewWithTag:100];
        MHPost *post=nil;
        if(_modelArry.count==1){
            post=[_modelArry objectAtIndex:0];
        }else{
            post=[_modelArry objectAtIndex:index];
        }
        if(post.picList.count>0){
            NSString *width=[NSString stringWithFormat:@"%d",(int)((kScreen_Width-60)*1.5)];
            NSString *height=[NSString stringWithFormat:@"%d",(int)(145*kHeightRate*1.5)];
            [imageView1 setImageWithUrl:[MHGlobalFunction imageHandleTwoSide:[post.picList objectAtIndex:0] width:width height:height firstReason:@"1" isDeal:@"1"] placeholderImage:kDefaultImage350X185 tapBlock:nil];
        }
    }
}

- (void)setSDTaskImage:(UIView *)view index:(NSInteger)index{
    if(_modelArry&&self.modelArry.count>0){
        UITapImageView *imageView1=[view viewWithTag:200];
        MHDayTask *dayTask=nil;
        if(_modelArry.count==1){
            dayTask=[_modelArry objectAtIndex:0];
        }else{
            dayTask=[_modelArry objectAtIndex:index];
        }
        if(dayTask.background){
            NSString *width=[NSString stringWithFormat:@"%d",(int)((kScreen_Width-60)*1.5)];
            NSString *height=[NSString stringWithFormat:@"%d",(int)(150*1.5)];
            [imageView1 setImageWithUrl:[MHGlobalFunction imageHandleTwoSide:dayTask.background width:width height:height firstReason:@"1" isDeal:@"1"] placeholderImage:kDefaultImage350X185 tapBlock:nil];
        }
    }
}

#pragma mark 递归图片
/**
 *参数1：被拷贝的UIView
 *参数2：新拷贝的UIView
 */
-(void)imageCopy:(id)obj To:(id)obj2
{
    //图片无法在序列化和反序列化中被重新生成，因此判断为图片类型时为新对象IMAGE赋值
    if([obj isKindOfClass:[UIImageView class]])
    {
        ((UIImageView *)obj2).image=((UIImageView *)obj).image;
    }
    
    //遍历子对象中是否包含UIImageView类型
    if([obj isKindOfClass:[UIView class]])
    {
        UIView *view=(UIView *)obj;
        UIView *view2=(UIView *)obj2;
        for(int i=0;i<view.subviews.count;i++)
        {
            //递归操作
            [self imageCopy:view.subviews[i] To:view2.subviews[i]];
        }
    }
}

#pragma mark 判断是否第一或者最后一个图片,改变坐标
-(void)updataWhenFirstOrLast
{
    //当图片移动到最后第二张时，动画结束移动到第三张图片的位置
    if(contentOffSet_x>=contentSize_x-frame_width*2)
    {
        self.direct.contentOffset=CGPointMake(frame_width*2, 0);
    }
    //当图片移动到第二张时，动画结束移动到倒数第三张的位置
    else if (contentOffSet_x<=frame_width)
    {
        self.direct.contentOffset=CGPointMake(contentSize_x-3*frame_width, 0);
    }
    
    //更新PageControl
    [self updataPageControl];
}

@end
