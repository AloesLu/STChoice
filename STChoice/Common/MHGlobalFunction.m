//
//  MHGlobalFunction.m
//  vomoho
//
//  Created by AloesLu on 15/9/23.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import "MHGlobalFunction.h"
#import "CustomButton.h"
#import "UITapImageView.h"
#import "MHTime.h"

@implementation MHGlobalFunction

+ (UIButton *)getIconFontBarButtonItem:(NSString *)title rect:(CGRect)rect size:(CGFloat)size{
    UIFont *iconfont=[UIFont fontWithName:@"iconfont" size:size];
    UIButton *button=[[UIButton alloc]initWithFrame:rect];
    button.titleLabel.text=title;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:iconfont];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:kTitleColor forState:UIControlStateNormal];
    [button setTitleColor:kTitleColorPress forState:UIControlStateHighlighted];
    return button;
}

+ (void)setIconImageButton:(NSString *)title size:(CGFloat)size btn:(UIButton*)button{
    UIFont *iconfont=[UIFont fontWithName:@"iconfont" size:size];
    button.titleLabel.text=title;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:iconfont];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:kDescribeColor forState:UIControlStateNormal];
}

+ (UIButton *)getIconNavBarButton:(NSString *)title{
    UIFont *iconfont=[UIFont fontWithName:@"iconfont" size:22];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 32)];
    button.titleLabel.text=title;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:iconfont];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:kTitleColor forState:UIControlStateNormal];
    [button setTitleColor:kTitleColorPress forState:UIControlStateHighlighted];
    return button;
}

+ (UIButton *)getWordNavBarButton:(NSString *)title{
    UIFont *font=[UIFont systemFontOfSize:16];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    button.titleLabel.text=title;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:kTitleColor forState:UIControlStateNormal];
    [button setTitleColor:kTitleColorPress forState:UIControlStateHighlighted];
    return button;
}

+ (void)setOperateButton:(CustomButton *)button title:(NSString *)title state:(int)state{
    button.titleLabel.text=title;
    [button setTitle:title forState:UIControlStateNormal];
    if(state==0){
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor=kDescribeColor;
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    }else{
        button.backgroundColor=kMainColorIcon;
        [button setTitleColor:kTitleColor forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:kMainColorIcon] forState:UIControlStateHighlighted];
    }
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    button.layer.cornerRadius=2;
    button.layer.masksToBounds=YES;
}

+ (void)setGenderAndAgeLabel:(UILabel*)label gender:(NSNumber *)gender{
    NSString *str=nil;
    if([gender intValue]==2){
        str= @"\U0000e654    ";
        [label setBackgroundColor:kMHGirlPink];
    }else if([gender intValue]==1){
        str= @"\U0000e653    ";
        [label setBackgroundColor:kMHManBule];
    }else{
        str= @"\U0000e65e    ";
        [label setBackgroundColor:kBorderLine];
    }
    label.layer.cornerRadius=1;
    label.layer.masksToBounds=YES;
    label.textColor=[UIColor whiteColor];
    label.text=str;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont fontWithName:@"iconfont" size:10];
}

+ (void)setImageToImageView:(UITapImageView *)imageView url:(NSString *)url{
    NSRange num=[url rangeOfString:@"assets-library"];
    if(!num.length){
        [imageView setImageWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@@100w_100h_1e_1c_50-2ci_2o",url]] placeholderImage:kDefaultImage80X80 tapBlock:nil];
    }else{
        PHFetchResult *arry=[PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
        if(arry.count>0){
            PHAsset *asset=[arry objectAtIndex:0];
            PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc]init];
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:CGSizeMake(100,100)
                                                      contentMode:PHImageContentModeDefault
                                                          options:requestOptions
                                                    resultHandler:^(UIImage *result, NSDictionary *info) {
                                                        
                                                        [imageView setImageWithUrl:nil placeholderImage:result tapBlock:nil];
                                                        
                                                    }];
        }
    }
}

+ (void)judgeNumTextView:(UITextView *)textView maxLenght:(int)maxLenght showText:(NSString *)showText{
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length >= maxLenght) {
                textView.text = [toBeString substringToIndex:maxLenght];
                [kKeyWindow showStatusBarSuccessStr:showText];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length >= maxLenght) {
            [kKeyWindow showStatusBarSuccessStr:showText];
            textView.text = [toBeString substringToIndex:maxLenght];
        }
    }
    
}

+ (void)judgeNumTextField:(UITextField *)textField maxLenght:(int)maxLenght showText:(NSString *)showText{
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length >= maxLenght) {
                textField.text = [toBeString substringToIndex:maxLenght];
                [kKeyWindow showStatusBarSuccessStr:showText];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length >= maxLenght) {
            [kKeyWindow showStatusBarSuccessStr:showText];
            textField.text = [toBeString substringToIndex:maxLenght];
        }
    }
}

+ (NSString *)timeIntervalFromString:(NSString *)str{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * nowdate = [dateFormatter dateFromString:str];
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSTimeInterval time = [nowdate timeIntervalSince1970]*1000;//毫秒数要乘以1000
    double i=time;      //NSTimeInterval返回的是double类型
    NSString *timeIntervalStr = [NSString stringWithFormat:@"%.f", i];    
    return timeIntervalStr;
}

+ (void)show4SHUD:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.userInteractionEnabled=NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:4.0];
}

+ (void)showHUD:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.userInteractionEnabled=NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

+ (void)showHUD:(NSString *)text andView:(UIView *)view andHUD:(MBProgressHUD *)hud{
    hud.userInteractionEnabled=YES;
    [view addSubview:hud];
    hud.labelText = text;//显示提示
    //hud.dimBackground = YES;//使背景成黑灰色，让MBProgressHUD成高亮显示
    hud.square = YES;//设置显示框的高度和宽度一样
    [hud show:YES];
    [hud hide:YES afterDelay:30];
}

+ (NSString *)getNowTip{
    MHTime *time=[[MHAdminManager sharedManager]getKNowTimeSection];
    NSString *str=nil;
    if([time.timeType intValue]==1){
        str=[NSString stringWithFormat:@"当前学生志愿选择阶段，时间为：%@--%@",time.startTime,time.endTime];
    }else if([time.timeType intValue]==2){
        str=[NSString stringWithFormat:@"当前教师第一志愿筛选阶段，时间为：%@--%@",time.startTime,time.endTime];
    }else if([time.timeType intValue]==3){
        str=[NSString stringWithFormat:@"当前教师第二志愿筛选阶段，时间为：%@--%@",time.startTime,time.endTime];
    }else if([time.timeType intValue]==4){
        str=[NSString stringWithFormat:@"当前教师第三志愿筛选阶段，时间为：%@--%@",time.startTime,time.endTime];
    }else if([time.timeType intValue]==5){
        str=[NSString stringWithFormat:@"当前智能随机分配阶段，时间为：%@--%@",time.startTime,time.endTime];
    }else{
        str=@"当前未开始综合导师双向选择，如有问题，请联系管理员";
    }
    return str;
}

@end
