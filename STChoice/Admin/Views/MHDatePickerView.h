//
//  MHDatePickerView.h
//  vomoho
//
//  Created by AloesLu on 16/3/29.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHActivityType;

@interface MHDatePickerView : UIView
@property (nonatomic, copy) void (^returnSelectTimeBlock) (NSString *selectTime);
@property (nonatomic, copy) void (^returnSelectTypeBlock) (MHActivityType *type);
- (instancetype)initWithNowDate:(NSString *)nowDate;
- (instancetype)initWithTypeArry:(NSMutableArray *)typeArry;
- (void)cancelOrMaskViewClick;
@end

