//
//  MHTeacher.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHTeacher : NSObject
@property(nonatomic,strong,readwrite)NSString *teaId;
@property(nonatomic,strong,readwrite)NSString *teaName;
@property(nonatomic,strong,readwrite)NSNumber *sex;
@property(nonatomic,strong,readwrite)NSString *avatar;
//职称
@property(nonatomic,strong,readwrite)NSString *teaTitle;
//研究方向
@property(nonatomic,strong,readwrite)NSString *direction;
//联系电话
@property(nonatomic,strong,readwrite)NSString *contact;
//邮件
@property(nonatomic,strong,readwrite)NSString *email;
//论文情况
@property(nonatomic,strong,readwrite)NSString *teaPaper;
//项目情况
@property(nonatomic,strong,readwrite)NSString *teaProject;
//荣誉情况
@property(nonatomic,strong,readwrite)NSString *honour;
//学生要求
@property(nonatomic,strong,readwrite)NSString *stuRequire;

@property(nonatomic,assign,readwrite)BOOL isSelect;

@property(nonatomic,strong,readwrite)NSString *school;
@property(nonatomic,strong,readwrite)NSString *QQ;
@property(nonatomic,strong,readwrite)NSString *remarks;

@property(nonatomic,strong,readwrite)NSNumber *selectNum;
+ (instancetype)teacherWithDict:(NSDictionary *)dict;
@end
