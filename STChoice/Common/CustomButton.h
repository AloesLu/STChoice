//
//  CustomButton.h
//  vomoho
//
//  Created by Arthury on 15/9/23.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomButton : UIButton

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@property (nonatomic) int buttonTypeNum;
@property (nonatomic) NSString *someId;
@property (nonatomic) BOOL isTapped;

- (void)changeBackgroundColor:(int)buttonTypeNum;
@property (nonatomic, copy) void (^materialBlock) (CustomButton *button);
@end