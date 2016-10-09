//
//  CustomButton.m
//  vomoho
//
//  Created by Arthury on 15/9/23.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

- (void)changeBackgroundColor:(int)buttonTypeNum{
    self.buttonTypeNum = buttonTypeNum;
    if (buttonTypeNum == 0) {
        [self setBackgroundColor:[UIColor grayColor]];
    }else if (buttonTypeNum == 1){
        [self setBackgroundColor:[UIColor whiteColor]];
    }else{
        [self setBackgroundColor:[UIColor greenColor]];
    }
}

@end