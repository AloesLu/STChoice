//
//  MHChoose.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHChoose : NSObject
@property(nonatomic,strong,readwrite)NSString *chooseId;
@property(nonatomic,strong,readwrite)NSString *stuId;
@property(nonatomic,strong,readwrite)NSString *teaId;
@property(nonatomic,strong,readwrite)NSNumber *wishNum;
@property(nonatomic,strong,readwrite)NSNumber *stuStatus;
@property(nonatomic,strong,readwrite)NSNumber *teaStatus;

@property(nonatomic,strong,readwrite)NSString *stuName;
@property(nonatomic,strong,readwrite)NSString *teaName;
@property(nonatomic,strong,readwrite)NSString *stuContact;
@property(nonatomic,strong,readwrite)NSString *teaContact;

@property(nonatomic,strong,readwrite)NSString *avatar;
@property(nonatomic,strong,readwrite)NSString *email;

@property(nonatomic,strong,readwrite)NSString *major;

@property(nonatomic,strong,readwrite)MHTeacher *teacher;
@property(nonatomic,strong,readwrite)MHStudent *student;

@property(nonatomic,assign,readwrite)BOOL isSelect;
+ (instancetype)chooseWithDict:(NSDictionary *)dict;
@end
