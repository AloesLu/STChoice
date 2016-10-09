//
//  MHWish.h
//  STChoice
//
//  Created by AloesLu on 16/4/27.
//  Copyright © 2016年 AloesLu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHWish : NSObject
@property(nonatomic,strong,readwrite)NSString *wishId;
@property(nonatomic,strong,readwrite)NSString *teaId;
@property(nonatomic,strong,readwrite)NSString *stuId;
@property(nonatomic,strong,readwrite)NSString *content;
@property(nonatomic,strong,readwrite)NSNumber *wishNum;

@property(nonatomic,strong,readwrite)NSString *stuName;
@property(nonatomic,strong,readwrite)NSString *teaName;
@property(nonatomic,strong,readwrite)NSString *stuContact;
@property(nonatomic,strong,readwrite)NSString *teaContact;

@property(nonatomic,strong,readwrite)NSString *teaTitle;

@property(nonatomic,strong,readwrite)MHTeacher *teacher;
@property(nonatomic,strong,readwrite)MHStudent *student;


+ (instancetype)wishWithDict:(NSDictionary *)dict;
@end
