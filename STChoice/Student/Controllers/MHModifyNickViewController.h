//
//  MHModifyNickViewController.h
//  vomoho
//
//  Created by 刘华军 on 15/12/1.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHModifyNickViewController : BaseViewController
@property (nonatomic,strong)NSString *content;
@property (nonatomic, copy) void (^refreshEidtInfoViewBlock) ();
-(instancetype)initWithName:(NSString *)name;
@property (nonatomic,assign)BOOL isTeacher;
@end
