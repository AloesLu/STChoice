//
//  MHUser.h
//  vomoho
//
//  Created by AloesLu on 15/9/26.
//  Copyright © 2015年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHUser : NSObject

//用户id
@property(nonatomic,strong,readwrite)NSString *uid;
//云账号
@property(nonatomic,strong,readwrite)NSString *openAccountId;
//梦虎号
@property(nonatomic,strong,readwrite)NSString *username;
//用户昵称
@property(nonatomic,strong,readwrite)NSString *nick;
//头像url
@property(nonatomic,strong,readwrite)NSString *avatar;
//注册时间
@property(nonatomic,strong,readwrite)NSString *registerTime;
//性别 男女
@property(nonatomic,strong,readwrite)NSNumber *gender;
//年龄
@property(nonatomic,strong,readwrite)NSString *age;
//个性签名
@property(nonatomic,strong,readwrite)NSString *motto;
//电话
@property(nonatomic,strong,readwrite)NSString *phone;
//生日
@property(nonatomic,strong,readwrite)NSString *birthday;
//是否修改全部
@property(nonatomic,strong,readwrite)NSNumber *is_update_all;
//背景图
@property(nonatomic,strong,readwrite)NSString *backgroundPicture;
//星座
@property(nonatomic,strong,readwrite)NSString *constellation;
//爱好
@property(nonatomic,strong,readwrite)NSString *hobby;
//婚姻状况
@property(nonatomic,strong,readwrite)NSNumber *marriageStat;
//个人相册
@property(nonatomic,strong,readwrite)NSMutableArray *picList;
//职位
@property(nonatomic,strong,readwrite)NSString *position;
//职位代码
@property(nonatomic,strong,readwrite)NSString *positionNo;
//关系
@property(nonatomic,strong,readwrite)NSString *relation;
//关系状态
@property(nonatomic,strong,readwrite)NSNumber *relationStat;
//最后一次登陆时间
@property(nonatomic,strong,readwrite)NSString *lastLoginTime;

//注册城市
@property(nonatomic,strong,readwrite)NSString *registerCity;
//重复名
@property(nonatomic,strong,readwrite)NSString *repeatNick;
//角色id
@property(nonatomic,strong,readwrite)NSString *roleId;
//
@property(nonatomic,strong,readwrite)NSString *salt;
//状态
@property(nonatomic,strong,readwrite)NSString *stat;

//标签
@property(nonatomic,strong,readwrite)NSMutableArray *tagMap;
@property(nonatomic,strong,readwrite)NSMutableArray *dynamicPictures;

//token
@property(nonatomic,strong,readwrite)NSString *token;

//最后一次访问接口时间
@property(nonatomic,strong,readwrite)NSString *lastActiveTime;
@property(nonatomic,strong,readwrite)NSString *showTime;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
