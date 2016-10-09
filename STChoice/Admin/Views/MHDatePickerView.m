//
//  MHDatePickerView.m
//  vomoho
//
//  Created by AloesLu on 16/3/29.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import "MHDatePickerView.h"
@interface MHDatePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UIButton *maskView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *typePickerView;
@property (strong, nonatomic) NSString *nowDate;
@property (strong, nonatomic) NSMutableArray *typeArry;
@property (strong, nonatomic) MHActivityType *selectType;
@end

@implementation MHDatePickerView

- (instancetype)initWithNowDate:(NSString *)nowDate{
    if(self=[super init]){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MHDatePickerView" owner:self options:nil];
        if (nib > 0) {
            self = [nib objectAtIndex:0];
            self.datePicker=[self viewWithTag:1];
            UIButton *sureButton=[self viewWithTag:2];
            UIButton *cancleButton=[self viewWithTag:3];
            [sureButton addTarget:self action:@selector(datePickerViewSureBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cancleButton addTarget:self action:@selector(datePickerViewCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        _nowDate=nowDate;
        [self alterView];
        [self setDatePickerNewData];
    }
    return self;
}
- (instancetype)initWithTypeArry:(NSMutableArray *)typeArry{
    if(self=[super init]){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MHTypePickerView" owner:self options:nil];
        if (nib > 0) {
            self = [nib objectAtIndex:0];
            self.typePickerView=[self viewWithTag:1];
            UIButton *sureButton=[self viewWithTag:2];
            UIButton *cancleButton=[self viewWithTag:3];
            [sureButton addTarget:self action:@selector(typePickerViewSureBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cancleButton addTarget:self action:@selector(typePickerViewCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        _typeArry=typeArry;
        [self alterView];
        [self setTypePickerNewData];
    }
    return self;
}
#pragma mark -  自定义的日期选择器弹出
- (void)alterView{
    //设置遮盖Button
    self.maskView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.frame.size.width, kKeyWindow.frame.size.height)];
    self.maskView.backgroundColor = [UIColor grayColor];
    self.maskView.alpha = 0.5;
    [kKeyWindow addSubview:self.maskView];
    [self.maskView  addTarget:self action:@selector(maskViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.frame = CGRectMake(0, kKeyWindow.frame.size.height, kKeyWindow.frame.size.width, 300);
    [kKeyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kKeyWindow.frame.size.height-300, kKeyWindow.frame.size.width, 300);
    }];
}

/**
 *  设置时间选择器数据
 */
- (void)setDatePickerNewData{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"yyyy-MM-dd HH:mm:ss";
    if(_nowDate){
        NSDate *date = [formatter dateFromString:_nowDate];
        [self.datePicker setDate:date animated:YES];
    }
}

/**
 *  设置类别选择器数据
 */
- (void)setTypePickerNewData{
    self.typePickerView.delegate=self;
    self.typePickerView.dataSource=self;
}


/**
 *  确定点击，选择日期结束后
 */
- (void)datePickerViewSureBtn:(id)sender {
    NSDate *selectedDate       = _datePicker.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat       = @"yyyy-MM-dd HH:mm";
    NSString *dateString       = [formatter stringFromDate:selectedDate];
    
    NSDate *selectedDate1       =[formatter dateFromString:dateString];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat       = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString1       = [formatter1 stringFromDate:selectedDate1];
    
    if(_returnSelectTimeBlock){
        _returnSelectTimeBlock(dateString1);
    }
}

/**
 *  取消日期选择按钮点击
 */
- (void)datePickerViewCancelBtn:(id)sender {
    [self cancelOrMaskViewClick];
}
- (void)typePickerViewSureBtn:(id)sender {
    if(self.selectType==nil&&self.typeArry.count>0){
        self.selectType=[self.typeArry objectAtIndex:0];
    }
    if(_returnSelectTypeBlock){
        _returnSelectTypeBlock(self.selectType);
    }
}
- (void)typePickerViewCancelBtn:(id)sender {
    [self cancelOrMaskViewClick];
}
-(void)maskViewClick{
    [self cancelOrMaskViewClick];
}
-(void)cancelOrMaskViewClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kKeyWindow.frame.size.height, kKeyWindow.frame.size.width, 300);
        self.maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark- 设置数据
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.typeArry.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    MHActivityType *type= [self.typeArry objectAtIndex:row];;
    return @"";
}

#pragma mark-设置下方的数据刷新
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectType= [self.typeArry objectAtIndex:row];;
}


@end
