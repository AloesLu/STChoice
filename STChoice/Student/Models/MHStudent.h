//
//  MHStudent.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHStudent : NSObject
@property(nonatomic,strong,readwrite)NSString *stuId;
@property(nonatomic,strong,readwrite)NSString *stuName;
@property(nonatomic,strong,readwrite)NSNumber *sex;
@property(nonatomic,strong,readwrite)NSString *avatar;
//班级
@property(nonatomic,strong,readwrite)NSString *clazz;
//专业
@property(nonatomic,strong,readwrite)NSString *major;
//联系电话
@property(nonatomic,strong,readwrite)NSString *contact;
//邮件
@property(nonatomic,strong,readwrite)NSString *email;
//排名
@property(nonatomic,strong,readwrite)NSNumber *rank;
//荣誉情况
@property(nonatomic,strong,readwrite)NSString *honour;
//兴趣爱好
@property(nonatomic,strong,readwrite)NSString *interst;
//作品
@property(nonatomic,strong,readwrite)NSString *works;
//过往经历
@property(nonatomic,strong,readwrite)NSString *experience;

@property(nonatomic,strong,readwrite)NSString *grade;
@property(nonatomic,strong,readwrite)NSString *QQ;
@property(nonatomic,strong,readwrite)NSString *remarks;

@property(nonatomic,assign,readwrite)BOOL isSelect;
+ (instancetype)studentWithDict:(NSDictionary *)dict;
@end
